๐ Audit Finding: 88mph Function Initialization Bug
๐ฏ Project Name: 88mph
๐ฅ Severity: Critical
๐ฐ Reward: $42,069
๐ก๏ธ Found by: AshiqAmien reported to immunefi

Let's Start ๐๐


๐ The Vulnerability:

๐ The vulnerability was an unprotected init() function in the code of these specific pools that would have allowed a malicious user to steal $6.5m in tokens, mostly in crvRenWBTC.

๐ The init() function, which is used to initialize the NFT contract on 88mphโs platform, was missing an access control modifier 'onlyOwner'.

๐ The result of this unprotected function would have allowed a malicious attacker to have access to any userโs NFTs and deposits.


๐กRecommended Mitigation Steps:
1. Add an onlyOwner modifier to critical functions
2. Add an initializer modifier to make the init() function only callable once

โกHow can you look for these types of bugs?
Always Check if critical functions have implemented proper access control mechanisms to protect the function restricted to previledge.


https://quillaudits.medium.com/access-control-vulnerability-in-defi-quillaudits-909e7ed4582c
