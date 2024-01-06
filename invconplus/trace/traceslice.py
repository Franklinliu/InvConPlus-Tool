# Trace Slice
import copy
import itertools
import json
from typing import List
from invconplus.model.Tx import Transaction 
from invconplus.model.model import VariableModel, StructVariableModel, ArrayVariableModel, MappingVariableModel
import re  

def default(obj):
    if hasattr(obj, 'to_json'):
        return obj.to_json()
    raise TypeError(f'Object of type {obj.__class__.__name__} is not JSON serializable')

class Parameter:
    def __init__(self, name, value, elemType=None):
        self.name = name 
        self.value = value 
        self.elemType = elemType

    def to_dict(self):
        return dict(name=self.name, value=self.value)
    
    def getName(self):
        return self.name
    
    def getValue(self):
        return self.value 

class Event:
    def __init__(self, methodName, parameters: List[Parameter]):
        self.methodName = methodName
        self.parameters = parameters
        self.parameter_bindings = list()
        self.interested_parameters =  None 

    def to_dict(self):
        return dict(methodName=self.methodName, parameters=[ param.to_dict() for param in self.parameters])
    
    def getMethodName(self):
        return self.methodName

    def getParameters(self):
        return self.parameters

    def setParameters(self, parameters):
        self.parameters = parameters

    def registerParameterBinding(self, parameterBinding):
        self.parameter_bindings.append(parameterBinding)
        pre_slice_states, post_slice_states, slice_parameters = self.sliceState(parameterBinding)
        return Event(self.methodName, slice_parameters), pre_slice_states, post_slice_states
    
    def registerInterestedParameter(self, interestedParameter):
        self.interested_parameters = interestedParameter

    def getParameterValue(event, name, item_range=None, value_range=None, isArray=False):
                for parameter in event.getParameters():
                    if parameter.getName() == name :
                        value = parameter.getValue()
                        if isinstance(value, str):
                            value = value.lower()
                        return value 
                m = re.match(r"(\w+)\[(.*)\]", name)
                if m is not None:
                    base = m.group(1)
                    index = m.group(2)
                    baseParameter = event.getParameterValue(base)
                    indexParameter = event.getParameterValue(index)
                    if item_range is None:
                        if value_range is None:
                            if isinstance(indexParameter, str):
                                indexParameter = indexParameter.lower()
                                key =  list(filter(lambda x: x.lower() == indexParameter, baseParameter))[0]
                                value = baseParameter[key].getValue() 
                                if isArray:
                                    assert isinstance(value, list)
                                    results = []
                                    for item in value: 
                                        if isinstance(item, VariableModel):
                                            results.append(item.getValue())
                                        else:
                                            results.append(item)
                                    return results
                                else:
                                    return baseParameter[key].getValue()
                            else:
                                return baseParameter[indexParameter].getValue()
                        else:
                            start, end =  value_range
                            try:
                                # value = baseParameter[indexParameter].getValue()
                                indexParameter = indexParameter.lower()
                                key =  list(filter(lambda x: x.lower() == indexParameter, baseParameter))[0]
                                value = baseParameter[key].getValue() 
                                if isinstance(end, str):
                                    end = event.getParameterValue(end)
                                results = []
                                for i in range(start, end):
                                    results.append(value+i)
                                return results
                            except:
                                print(f"global indice: {baseParameter.keys()} ")
                                assert False, f"index {indexParameter} is not found"
                    else:
                        results = []
                        start, end = item_range
                        for i in range(start, end):
                            results.append(baseParameter[indexParameter+i].getValue())
                        return results
                else:
                    m  = re.match(r"(\w+)\+([0-9]+)", name)
                    if m is not None:
                        base = m.group(1)
                        offset = int(m.group(2))
                        baseParameter = event.getParameterValue(base)
                        return baseParameter + offset
                    else:
                        assert False, f"parameter {name} is not found"

    def sliceState(self, parameterBinding):
        abstractTypes = parameterBinding.keys() 
        theta = parameterBinding.values() 
        slice_parameters = list()

        item = self.interested_parameters
        for theta_item in theta:
            for name in item["params"]:
                values =  self.getParameterValue(name, item_range=item["range"] if "range" in item else None, value_range=item["valueoffset"] if "valueoffset" in item else None, isArray=item["isArray"] if "isArray" in item else False)
                if isinstance(values, list):
                    if theta_item in values:
                        slice_parameters.append(Parameter(name, theta_item))
                else:
                    value = values 
                    if theta_item == value:
                        slice_parameters.append(Parameter(name, theta_item))
        # slice states based on slice_parameters
        post_slice_states = list()
        pre_slice_states = list()
        interested_statevars = self.interested_parameters["state"]
        for statevar in interested_statevars:
            for abstractType, value in parameterBinding.items():
                statevar = statevar.replace(abstractType, str(value))
            post_state =  self.computeState(statevar)
            pre_state =  self.computeState(f"ori({statevar})")
            if isinstance(post_state, list):
                post_slice_states.extend(post_state)
            else:
                post_slice_states.append(post_state)
            
            if isinstance(pre_state, list):
                pre_slice_states.extend(pre_state)
            else:
                pre_slice_states.append(pre_state)
        # slice invariants based on slice_parameters
        return  pre_slice_states, post_slice_states, slice_parameters
                    
    def computeState(self, statevar):
        isOrignal = False
        if re.match("ori\((.*)\)", statevar):
            isOrignal = True
            statevar = re.match("ori\((.*)\)", statevar).group(1)
        indice = [item for item in re.findall("\[([\w|\*]*)\]", statevar)]
        pure_statevar = statevar 
        for index in indice:
            pure_statevar = pure_statevar.replace("["+index+"]", "")
        
        sum_pattern  = re.compile(r"Sum\((\w+)\)")
        hasSum =  False 
        if sum_pattern.match(pure_statevar):
            hasSum = True
            pure_statevar = sum_pattern.subn(r"\1", pure_statevar)[0]
        
        target = None
        for parameter in self.getParameters():
            if parameter.getName() == pure_statevar if not isOrignal else \
                parameter.getName() == "ori("+pure_statevar+")":
                if isinstance(parameter.getValue(), dict):
                        target = parameter
                        if not hasSum:
                            for index in indice:
                                if re.match("^[0-9]+$", index):
                                    index =  int(index)
                                values = target.getValue()
                                if values is not None and index in values:
                                    target = values[index]
                                else:
                                    if isinstance(target, Parameter):
                                        target = target.elemType
                                    elif isinstance(target, MappingVariableModel):
                                        target = target.val_var_type
                                    else:
                                        assert False, f"index {index} is not found" 
                        else:
                            target = target.getValue()
                            for index in indice:
                                if re.match("^[0-9]+$", index):
                                    index =  int(index)
                                if target is None:
                                    break
                                if index in target:
                                    if isinstance(target, dict):
                                        target = target[index].getValue()
                                    else:
                                        if isinstance(target, list):
                                            target = [ item[index].getValue() for item in target[index].getValue() if index in item]
                                else:
                                    if index == "*":
                                        target = [ target[index].getValue() for index in target]
                                    else:
                                        target = parameter.elemType.getValue()
                            if isinstance(target, list):
                                target = sum(target)
                            else:
                                if target is None:
                                    target =  0
                                else:
                                    target = target 
                            
                            elem = parameter.elemType
                            for index in indice[1:]:
                               elem = elem.val_var_type
                            varName = pure_statevar+"$sum"+ str(indice.index("*") + 1) + "_"+elem.varType
                            # return {varName: target}
                            return dict(name = varName if not isOrignal else f"ori({varName})", value = target, vartype = elem.varType)
                        
                        break 
                else:
                    target = parameter.elemType   
                        
                
        assert target is not None 
        if isinstance(target, StructVariableModel):
            members = list()
            for item in target.getValue():
                varName = pure_statevar+"$"+item.varName
                # members.append({varName: item.getValue()})
                members.append(dict(name = varName if not isOrignal else f"ori({varName})", value = item.getValue(), vartype = item.varType))
            return members
        else:
            if target.varName is None or target.varName == "":
                varName = pure_statevar+"$"+target.varType
            else:
                varName = pure_statevar+"$"+target.varName
            # return {varName: target.varValue}
            return dict(name = varName if not isOrignal else f"ori({varName})", value = target.varValue, vartype = target.varType)
        
class Trace:
    def __init__(self):
        self.events = []
    
    def addEvent(self, event: Event):
        self.events.append(event)

    def getEvents(self):
        return self.events

    def to_list(self):
        return [ event.to_dict() for event in self.events]

class TraceSlice:
    def __init__(self, trace: Trace):
        self.trace = trace 
        self.global_parameter_binds = dict()
        self.trace_slices = list()

    def to_list(self):
        return [dict(
            parameterBindings = trace_slice[0],
            event_trace = trace_slice[1].to_list(),
            state_trace = trace_slice[2]
        ) for trace_slice in self.trace_slices]

    # @interested_params is a list of dictionaries, each dictionary contains the following fields:
    # 1. function: the name of the function
    # 2. abstract-types: the abstract types of the parameters
    # 3. params: the names of the parameters
    # 4. state: the names of the state variables
    # Please refer to the example below
    def setSliceCriteriaByInterestedParams(self, interested_params):
        self.interested_params = interested_params
    
    def getInterestedParameters(self):
        return self.interested_params 

    def appendParameterBindingForAbstractTypesByEvent(self, event: Event):
        for item in self.interested_params:
                if event.getMethodName().split("(")[0] == item["function"]:
                    for name in item["params"]:
                        if item["abstract-types"][item["params"].index(name)] not in self.global_parameter_binds:
                            self.global_parameter_binds[item["abstract-types"][item["params"].index(name)]] = set()
                        value = event.getParameterValue(name, item["range"] if "range" in item else None, item["valueoffset"] if "valueoffset" in item else None, item["isArray"] if "isArray" in item else False)
                        if isinstance(value, list):
                            self.global_parameter_binds[item["abstract-types"][item["params"].index(name)]].update(value)
                        else:
                            self.global_parameter_binds[item["abstract-types"][item["params"].index(name)]].add(value)

    def getParameterBindingsForAbstractTypes(self):
        return self.global_parameter_binds
    
    def findExistingTraceSlice(self, parameter_binds):
        for trace_slice in self.trace_slices:
            matched = True
            for key in trace_slice[0].keys():
                if trace_slice[0][key] != parameter_binds[key]:
                    matched = False
                    break
            if matched:
                return trace_slice[1], trace_slice[2]
        return None, None 


    def onlineSlice(self, event: Event):
        newSubEvents = list()

        self.trace.addEvent(event)
        self.appendParameterBindingForAbstractTypesByEvent(event)
        self.global_parameter_binds = self.getParameterBindingsForAbstractTypes()
        abstractTypes = self.global_parameter_binds.keys()
        for theta in itertools.product(*self.global_parameter_binds.values()):
            parameter_binds = dict(zip(abstractTypes, theta))
            existing_trace_slice, existing_state_slice = self.findExistingTraceSlice(parameter_binds)
            if existing_trace_slice is not None:
               trace_slice =  existing_trace_slice
               state_slice = existing_state_slice
            else:
                trace_slice = Trace()
                state_slice = list()
            for item in self.interested_params:
                if event.getMethodName().split("(")[0] == item["function"]:
                    hit_abstractTypes = set()
                    for name in item["params"]:
                        values = event.getParameterValue(name, item["range"] if "range" in item else None, item["valueoffset"] if "valueoffset" in item else None, item["isArray"] if "isArray" in item else False)
                        if isinstance(values, list):
                            for value in values:
                                if value == parameter_binds[item["abstract-types"][item["params"].index(name)]]:
                                    hit_abstractTypes.add(item["abstract-types"][item["params"].index(name)])
                                    
                        else:
                            value = values 
                            if value == parameter_binds[item["abstract-types"][item["params"].index(name)]]:
                                hit_abstractTypes.add(item["abstract-types"][item["params"].index(name)])
                               
                    
                    if len(hit_abstractTypes) == len(abstractTypes):
                        event.registerInterestedParameter(item)
                        newEvent, pre_slice_states, post_slice_states = event.registerParameterBinding(parameter_binds)
                        trace_slice.addEvent(newEvent)
                        if len(state_slice) == 0:
                            # for item in pre_slice_states:
                            #     item["name"] = re.sub(r'ori\((.*)\)', r'\1', item["name"])
                            state_slice.append(pre_slice_states)
                        state_slice.append(post_slice_states)
                        if existing_trace_slice is None:
                            self.trace_slices.append([parameter_binds, trace_slice, state_slice])
                        
                        newSubEvents.append([newEvent, pre_slice_states, post_slice_states])
                    
        return newSubEvents
            

def covertTx2Event(tx: Transaction) -> Event:
    parameters = list()
    for item in tx.envs:
        parameters.append(Parameter(item["name"], item["value"]))
    for item in tx.pre_state.variables:
        if isinstance(item, ArrayVariableModel):
            parameters.append(Parameter("ori("+item.varName+")", item.getValue(), item.item_var_type))
        elif isinstance(item, MappingVariableModel):
            parameters.append(Parameter("ori("+item.varName+")", item.getValue(), item.val_var_type))
        else:
            parameters.append(Parameter("ori("+item.varName+")", item.getValue()))
    for item in tx.post_state.variables:
        if isinstance(item, ArrayVariableModel):
            parameters.append(Parameter(item.varName, item.getValue(), item.item_var_type))
        elif isinstance(item, MappingVariableModel):
            parameters.append(Parameter(item.varName, item.getValue(), item.val_var_type))
        else:
            parameters.append(Parameter(item.varName, item.getValue()))
    event = Event(tx.func, parameters)
    return event
