require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({path:".env"});
const QuickNode = process.env.QuickNodeGateAway;
const Key = process.env.MyKey;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks:{
    goerli:{
      url: QuickNode,
      accounts:  [Key],
    },
  },
};
