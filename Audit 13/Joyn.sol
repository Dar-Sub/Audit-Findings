🔎 Audit Finding: Centralisation RIsk: Owner Of RoyaltyVault Can Take All Funds
🎯 Project Name: Joyn
🔥 Severity: High
🛡️ Auditor: @Code4rena

Let's Start 👇👇


🐞 The Vulnerability:

📌 The owner of RoyaltyVault can set _platformFee to any arbitrary value (e.g. 100% = 10000) as there exists no upper limit for setting fees.

📌 When the owner changes fees, that share of the contracts balance and future balances will be set to the platformFeeRecipient (which is in the owner's control) rather than the splitter contract.

📌 As a result the owner can steal the entire contract balance and any future balances avoiding the splitter.


💡Recommended Mitigation Steps:
This issue may be mitigated by adding a maximum value for the _platformFee. For example 5% or 10%.
The Protocol acknowledged the issue and fixed it.

## Lines of code
https://github.com/code-423n4/2022-03-joyn/blob/c9297ccd925ebb2c44dbc6eaa3effd8db5d2368a/royalty-vault/contracts/RoyaltyVault.sol#L76-L83

Vulnerability details
Impact
The owner of RoyaltyVault can set _platformFee to any arbitrary value (e.g. 100% = 10000) and that share of the contracts balance and future balances will be set to the platformFeeRecipient (which is in the owners control) rather than the splitter contract.

As a result the owner can steal the entire contract balance and any future balances avoiding the splitter.

## Proof of Concept

    function setPlatformFee(uint256 _platformFee) external override onlyOwner {
        platformFee = _platformFee;
        emit NewRoyaltyVaultPlatformFee(_platformFee);
    }
    
## Recommended Mitigation Steps
This issue may be mitigated by add a maximum value for the _platformFee say 5% (or some reasonable value based on the needs of the platform).

Also consider calling sendToSplitter() before adjusting the platformFee. This will only allow the owner to change the fee for future value excluding the current contract balance.

## Consider the following code.

    function setPlatformFee(uint256 _platformFee) external override onlyOwner {
        require(_platformFee < MAX_FEE);
        sendToSplitter(); // @audit this will need to be public rather than external
        platformFee = _platformFee;
        emit NewRoyaltyVaultPlatformFee(_platformFee);
    }
    
