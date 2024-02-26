/* eslint-disable no-undef */
const staking_dapp = artifacts.require('StakingDapp');

module.exports = async function (callback) {
    let dapp = await staking_dapp.deployed();
    await dapp.sendRewards();

    console.log("Incentive Tokens destributed.");
    callback();
}