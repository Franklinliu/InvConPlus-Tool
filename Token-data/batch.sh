
verisol_test=./verisol_test
for file in $(ls ./Token-data/result/*.inv.json)
do
    IN=$(basename $file)
    arrIN=(${IN//-/ })
    address=${arrIN[0]}  
    echo $address
    timeout 1800 python3 -m invconplus.main --address $address --maxCount 200
    cp $file $verisol_test
    echo "mv $file $verisol_test"
    timeout 1800 ts-node ./AutoAnnotation/main.ts $verisol_test/$IN
done

