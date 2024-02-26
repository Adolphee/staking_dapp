/* eslint-disable no-undef */

const INC = artifacts.require("IncentiveToken");
const USDF = artifacts.require("Tether");
const DAPP = artifacts.require("StakingDapp");

module.exports = async function(deployer) {
  // deploy fake USD
  await deployer.deploy(USDF);
  const $staking_token = await USDF.deployed();
  
  // deploy incentive token
  await deployer.deploy(INC);
  const $reward_token = await INC.deployed();
  //console.log($staking_token);
  
  // deploy staking dApp smart contract
  await deployer.deploy(DAPP, USDF.address, INC.address);
  const dapp = await DAPP.deployed();

  // allocate 100 incentive tokens to the Staking dApp
  await $reward_token.transfer(dapp.address, $reward_token.totalSypply);

  // distribute 100 fake USD to the 2nd user on-chain
  await $staking_token.transfer(accounts[1], 10000);

  await dapp.stakeTokens(5000, {from: accounts[1]});
  console.log(dapp.staking_balance[accounts[1]]);
};
