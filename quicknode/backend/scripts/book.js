const {ethers} = require("hardhat")
async function main(){
    //get the contract
    const BookContract = await ethers.getContractFactory("OnlineBookStore");
    //deploy the contract
    const BookContractDeploy = await BookContract.deploy();

    //await  deployment
    await BookContractDeploy.deployed();
    //console the address
    console.log("BookContractAddress",BookContractDeploy.address)
}
//call main
main().then(()=>process.exit(0)).catch((error)=>{
    console.log(error);
    process.exit(1);
})