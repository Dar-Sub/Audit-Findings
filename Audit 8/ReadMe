🔎 Audit Finding: 88mph Function Initialization Bug
🎯 Project Name: 88mph
🔥 Severity: Critical
💰 Reward: $42,069
🛡️ Found by: AshiqAmien reported to immunefi

Let's Start 👇👇


🐞 The Vulnerability:

📌 The vulnerability was an unprotected init() function in the code of these specific pools that would have allowed a malicious user to steal $6.5m in tokens, mostly in crvRenWBTC.

📌 The init() function, which is used to initialize the NFT contract on 88mph’s platform, was missing an access control modifier 'onlyOwner'.

📌 The result of this unprotected function would have allowed a malicious attacker to have access to any user’s NFTs and deposits.


💡Recommended Mitigation Steps:
1. Add an onlyOwner modifier to critical functions
2. Add an initializer modifier to make the init() function only callable once

⚡How can you look for these types of bugs?
Always Check if critical functions have implemented proper access control mechanisms to protect the function restricted to previledge.


https://quillaudits.medium.com/access-control-vulnerability-in-defi-quillaudits-909e7ed4582c
