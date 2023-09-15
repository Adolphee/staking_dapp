// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.4.22 <0.9.0;

contract Tether {
    string public name = "Fake USD";
    string public symbol = "USDF";
    uint public totalSupply = 100000000000000000;
    uint public decimal = 18;

    event Transfer(address _from, address _to, uint _value);
    event Approve(address _owner, address _spender, uint256 _value);

    mapping(address => uint256) public balances;
    mapping (address => mapping(address => uint256)) public allowances;

    constructor(){
        balances[msg.sender] = totalSupply;
    }


    function transfer(address _to, uint _value) public TransferGuard(_value) returns(bool success)  {
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    modifier TransferGuard (uint _value){
        require(balances[msg.sender] >= _value, "Insufficient balance.");
        _;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowances[msg.sender][_spender] = _value;
        emit Approve(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require((_value <= balances[_from]));
        require(_value <= allowances[_from][msg.sender]);
        balances[_from] -= _value;
        balances[_to] += _value;
        allowances[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}