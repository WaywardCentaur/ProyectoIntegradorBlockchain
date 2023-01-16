var TokenMerito = artifacts.require("./TokenMerito.sol");
module.exports = function(deployer) {
  deployer.deploy(TokenMerito);
};