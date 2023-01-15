🔎 Audit Finding: Initialize function can be invoked multiple times.
🎯 Project Name: The Graph
🔥 Severity: Medium
🛡️ Auditor: @Code4rena

Let's Start 👇👇



🐞 The Vulnerability:

📌 The implementation contract can initialize the _controller address multiple times on Managed contract even though it should only be allowed once.

📌 This means a compromised implementation can reinitialize the contract above and become the owner to complete the privilege escalation then drain the user's fund.


💡Recommended Mitigation Steps:
Use the initializer modifier to protect the function from being reinitiated

⚡How can you look for these types of bugs?
Always check if initialize function has initializer modifier to prevent function from being called more than once.


## Lines of code
https://github.com/code-423n4/2022-10-thegraph/blob/309a188f7215fa42c745b136357702400f91b4ff/contracts/l2/gateway/L2GraphTokenGateway.sol#L87
https://github.com/code-423n4/2022-10-thegraph/blob/309a188f7215fa42c745b136357702400f91b4ff/contracts/l2/token/L2GraphToken.sol#L48
https://github.com/code-423n4/2022-10-thegraph/blob/309a188f7215fa42c745b136357702400f91b4ff/contracts/gateway/L1GraphTokenGateway.sol#L99
https://github.com/code-423n4/2022-10-thegraph/blob/309a188f7215fa42c745b136357702400f91b4ff/contracts/gateway/BridgeEscrow.sol#L20

Vulnerability details
Impact
initialize function in L2GraphToken.sol, BridgeEscrow.sol, L2GraphTokenGateway.sol, L1GraphTokenGateway.sol

can be invoked multiple times from the implementation contract.

this means a compromised implementation can reinitialize the contract above and

become the owner to complete the privilege escalation then drain the user's fund.

Usually in Upgradeable contract, a initialize function is protected by the modifier

 initializer
to make sure the contract can only be initialized once.

##Proof of Concept
Provide direct links to all referenced code in GitHub. Add screenshots, logs, or any other relevant proof that illustrates the concept.

The implementation contract is compromised,

The attacker reinitialize the BridgeEscrow contract


    function initialize(address _controller) external onlyImpl {
        Managed._initialize(_controller);
    }
    
the onlyGovernor modifier's result depends on the controller because


    function _onlyGovernor() internal view {
        require(msg.sender == controller.getGovernor(), "Caller must be Controller governor");
    }
    
The attacker have the governor access to the BridgeEscrow,

The attack can call the approve function to approve malicious contract


     function approveAll(address _spender) external onlyGovernor {
        graphToken().approve(_spender, type(uint256).max);
    }
    
    
The attack can drain all the GRT token from the BridgeEscrow.


##Tools Used
Manual Review

##Recommended Mitigation Steps
We recommend the project use the modifier

 initializer
to protect the initialize function from being reinitiated

   function initialize(address _owner) external onlyImpl initializer  {
