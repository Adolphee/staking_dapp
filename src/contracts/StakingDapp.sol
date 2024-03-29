// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.4.22 <0.9.0;
import "./IncentiveToken.sol";
import "./Tether.sol";

contract StakingDapp{
    string public name = "Staking dApp";
    address public owner;
    IncentiveToken public $inc;
    Tether public $usdf;

    address[] public stakers;
    mapping(address => uint256) public staking_balance;
    mapping(address => bool) public has_staked;
    mapping(address => bool) public is_staking;

    event UnstakeTokens(uint256 _amount);
    event Staketokens(address _staker, uint256 _amount);
    event UnstakeTokens(address _staker, uint256 _amount);

    constructor(IncentiveToken reward_token, Tether fake_usd) {
        $inc = reward_token;
        $usdf = fake_usd;
        owner = msg.sender;
    }

    function stakeTokens(uint256 _amount) public {
        require(_amount > 0, "No tokens provided.");
        $usdf.transferFrom(msg.sender, address(this), _amount);

        staking_balance[msg.sender] += _amount;

        if(!has_staked[msg.sender]){
            stakers.push(msg.sender);
        }

        is_staking[msg.sender] = true;
        has_staked[msg.sender] = true;
    }

    function unstakeTokens(uint256 _amount) public {
        require(is_staking[msg.sender], "Staking balance is zero.");
        uint256 balance = staking_balance[msg.sender];
        $usdf.transfer(msg.sender, balance);
        if(balance < _amount){
            balance = 0;
            is_staking[msg.sender] = false;
        } else balance -= _amount;
        emit UnstakeTokens(msg.sender, _amount);        
    }

    function SendRewards() public {
        require(msg.sender == owner, "Caller must be the owner of this function.");

        for(uint256 i = 0; i < stakers.length; i++) {
            if(is_staking[stakers[i]]){
                uint256 balance = staking_balance[stakers[i]];
                $inc.transfer(stakers[i], balance);
            }
        }
    }
}