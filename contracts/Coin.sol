// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Coin {

    // 1. state 변수
    address public minter; // 발행자 
    mapping (address => uint) public balances;  // mapping (key:value)

    // 2. event 정의
    event Sent (address from, address to, uint amount);

    // 3. 생성자
    constructor() { 
        minter = msg.sender;
    }  

    // 4. 발행 method
    function mint(address receiver, uint amount) public { 
        require(msg.sender == minter);   // MGR 권한
        balances[receiver] += amount;
    }

    // 5. 에러 정의
    error InsufficientBalance(uint requested, uint available);

    function send(address receiver, uint amount) public {
        // 6. 잔액 오류
        if(amount > balances[msg.sender])  
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        // 7. send method 
        balances[msg.sender] -= amount; 
        balances[receiver] += amount; 
        emit Sent(msg.sender, receiver, amount);
    }
}

    // NFT는 주로 mapping(address => uint) public collections; 
    // value 값은 id
