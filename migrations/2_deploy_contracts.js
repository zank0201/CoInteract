//var CoToken = artifacts.require('./CoToken.sol')
var CoShoe = artifacts.require('./CoShoe.sol')
var CoToken = artifacts.require("./CoToken.sol")

module.exports = function (deployer) {
  deployer.deploy(CoShoe)
  deployer.deploy(CoToken)
}