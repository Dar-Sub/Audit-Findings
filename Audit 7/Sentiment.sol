🔎 Audit Finding: Insufficient validation of Chainlink Oracle data feed
🎯 Project Name: Sentiment
🔥 Severity: Medium
🛡️ Auditor: Sherlock

Let's Start 👇👇


🐞 The Vulnerability:

📌 When fetching prices from latestRoundData, there is not enough validation that ensures the price returned is not stale.

📌 The getPrice function fetches oracle price from Chainlink using latestRoundData, there only exists one check to make sure the reported price is not a negative value

📌 As prices can never be a negative value, this check is not needed. Instead, there should be sufficient checks to make sure Chainlink's reported price feed is fresh and not stale.


💡Recommended Mitigation Steps:
Validate data feed by:
> Checking the returned answer is not 0.
> Verify result is within an allowed margin of freshness by checking updatedAt.
> Verify answer is indeed for the last known round.


// oracle/src/chainlink/ArbiChainlinkOracle.sol:51
// oracle/src/chainlink/ChainlinkOracle.sol:51
// oracle/src/chainlink/ChainlinkOracle.sol:67


// oracle/src/chainlink/ArbiChainlinkOracle.sol:51
function getPrice(address token) external view virtual returns (uint) {
        (, int answer,,,) =
            feed[token].latestRoundData();

        if (answer < 0)
            revert Errors.NegativePrice(token, address(feed[token]));

        return (
            (uint(answer)*1e18)/getEthPrice()
        );
    }

// oracle/src/chainlink/ChainlinkOracle.sol:51
function getPrice(address token) external view virtual returns (uint) {
        (, int answer,,,) =
            feed[token].latestRoundData();

        if (answer < 0)
            revert Errors.NegativePrice(token, address(feed[token]));

        return (
            (uint(answer)*1e18)/getEthPrice()
        );
    }

// oracle/src/chainlink/ChainlinkOracle.sol:67
function getEthPrice() internal view returns (uint) {
        (, int answer,,,) =
            ethUsdPriceFeed.latestRoundData();

        if (answer < 0)
            revert Errors.NegativePrice(address(0), address(ethUsdPriceFeed));

        return uint(answer);
    }
    
    
    // Recommendation
Validate data feed by:

Checking the returned answer is not 0.
Verify result is within an allowed margin of freshness by checking updatedAt.
Verify answer is indeed for the last known round.


function getEthPrice() internal view returns (uint) {
        (uint80 ethRoundID, int answer,, uint256 ethUpdatedAt, uint80 ethAnsweredinRound) =
            ethUsdPriceFeed.latestRoundData();
        require(ethUpdatedAt > block.timestamp - 3600, "ETH: Stale price");
        require(ethAnsweredinRound == ethRoundID , "ETH: Answer is not for last known round!");
        if (answer <= 0)
            revert Errors.NegativePrice(address(0), address(ethUsdPriceFeed));

        return uint(answer);
    }
