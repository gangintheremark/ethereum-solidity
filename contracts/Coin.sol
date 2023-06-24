// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Coin {
    address public minter; // 발행자
    mapping (address => uint) public balances;  // mapping (key:value)

    // NFT는 주로 mapping(address => uint) public collections; 
    // value 값은 id

    event Sent (address from, address to, uint amount);

    constructor() { //생성자
        minter = msg.sender;
    }  

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);   // 검증
        balances[receiver] += amount;
    }

    error InsufficientBalance(uint requested, uint available);

    function send(address receiver, uint amount) public {
        if(amount > balances[msg.sender])  // 계좌에 있는 coin보다 보낼 coin 이 크면 error
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        balances[msg.sender] -= amount; // 계좌에서 coin 빠져나감
        balances[receiver] += amount; // 계좌에 coin 들어옴
        emit Sent(msg.sender, receiver, amount);
    }
}