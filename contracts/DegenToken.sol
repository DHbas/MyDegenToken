// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount); 
    }

    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function transferTokens(address _receiver, uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        _transfer(msg.sender, _receiver, _value);
    }

    function burnTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        _burn(msg.sender, _value);
    }

    function redeemTokens(uint8 _userChoice) external payable returns (bool) {
        if (_userChoice == 1) {
            require(balanceOf(msg.sender) >= 10, "You do not have enough Degen Tokens");
            _transfer(msg.sender, owner(), 10);
            console.log("Redeemed 10 Degen Tokens");
            return true;
        } else if (_userChoice == 2) {
            require(balanceOf(msg.sender) >= 5, "You do not have enough Degen Tokens");
            _transfer(msg.sender, owner(), 5);
            console.log("Redeemed 5 Degen Tokens");
            return true;
        } else {
            console.log("That is not a valid choice");
            return false;
        }
    }
}
