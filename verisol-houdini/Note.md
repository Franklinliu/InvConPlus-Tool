verisol_test/0xe6c011797e50015999d8b2ed41e47b2ae885b5ff.etherscan.io-XSRToken.verisol.sol

```javascript
    /// @dev Called by a pauser to pause, triggers stopped state.
    function pause() public onlyPauser() whenNotPaused() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(_paused==false);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_paused==false); // FIXME: this should change to VeriSol.Ensures(_paused!=false);
        //End of invariants
        _paused = true;
        emit Paused(msg.sender);
    }
```