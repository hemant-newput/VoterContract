const MyContract = artifacts.require("MyContract")

contract("MyContract", accounts => {

    it("contructor should set the message correctly",async()=>{
        let instance = await MyContract.deployed();
        let message = await instance.message();
        assert(message, "Hemant Shrivastava");
    })

    it("owner should be accounts[0]", async()=>{
        let instance = await MyContract.deployed();
        let owner = await instance.owner();
        assert(owner,accounts[0]);
    })
    
})
