🔎 Audit Finding: Sandwich attack due to hardcoded slippage
🎯 Project Name: Sandclock
🔥 Severity: High
🛡️ Auditor: @Code4rena

Let's Start 👇👇


🐞 The Vulnerability:

✅ The _swapUstToUnderlying function is used to swap Ust to underlying tokens. The argument exchange_underlying specifies the minimum number of underlying to be returned from the swap.

✅ Currently, this value is set to 0, so the function is subject to a sandwich attack. Check out the below link if you don't know what is sandwich attack.
https://lnkd.in/dEAQf-Uv

✅ Specifically, an attacker can watch for transactions that call _swapUstToUnderlying, and then (using flashbots) execute a sandwich attack to manipulate the price of the underlying/Ust pair before and after the swap.


💡Recommended Mitigation Steps:
Add a slippage argument to the functions instead of hard-coded 0.

⚡How can you look for these types of bugs?
Whenever there is a function for swapping tokens, look if the slippage value is hardcoded to zero or any other number.


Vulnerability details
Impact
Sandwich attack is possible: an attacker can track market order and perform it whenever order amount to be executed is big enough to compensate for exchange manipulation costs. On Curve it is less profitable and this way less probable due to low slippage, but the possibility exists.

Proof of Concept
No minimum return is used when Curve is called to do the UST swaps:

doHardWork -> _swapUnderlyingToUst use 0 as min accepted return:

https://github.com/code-423n4/2022-01-sandclock/blob/main/sandclock/contracts/strategy/NonUSTStrategy.sol#L78-83

finishRedeemStable ->_swapUstToUnderlying also use 0 as min return:

https://github.com/code-423n4/2022-01-sandclock/blob/main/sandclock/contracts/strategy/NonUSTStrategy.sol#L94

Recommended Mitigation Steps
Add a slippage argument to doHardWork and finishRedeemStable functions and supply minimum accepted return to Curve instead of hard coded 0
