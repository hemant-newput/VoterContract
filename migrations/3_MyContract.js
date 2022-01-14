const MyContract = artifacts.require("MyContract");
const MyContractPermanent = artifacts.require("MyContractPermanent");

module.exports = function (deployer) {
  deployer.deploy(MyContract, "Hemant Shrivastava").then(async () => {
    let instance = await MyContract.deployed();
    let message = instance.getMessage();
    return deployer.deploy(MyContractPermanent, message)
  });
};

