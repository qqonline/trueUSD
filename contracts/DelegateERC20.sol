pragma solidity ^0.4.23;

import "./modularERC20/ModularStandardToken.sol";

/** @title DelegateERC20
Accept forwarding delegation calls from the old TrueUSD (V1) contract. THis way the all the ERC20
functions in the old contract still works (except Burn). 
*/
contract DelegateERC20 is ModularStandardToken {

    address public constant DELEGATE_FROM = 0x8dd5fbCe2F6a956C3022bA3663759011Dd51e73E;

    function delegateTotalSupply() public view returns (uint256) {
        return totalSupply();
    }

    function delegateBalanceOf(address who) public view returns (uint256) {
        return balanceOf(who);
    }

    function delegateTransfer(address to, uint256 value, address origSender) public returns (bool) {
        require(msg.sender == DELEGATE_FROM);
        transferAllArgs(origSender, to, value);
        return true;
    }

    function delegateAllowance(address owner, address spender) public view returns (uint256) {
        return allowance(owner, spender);
    }

    function delegateTransferFrom(address from, address to, uint256 value, address origSender) public returns (bool) {
        require(msg.sender == DELEGATE_FROM);
        transferFromAllArgs(from, to, value, origSender);
        return true;
    }

    function delegateApprove(address spender, uint256 value, address origSender) public returns (bool) {
        require(msg.sender == DELEGATE_FROM);
        approveAllArgs(spender, value, origSender);
        return true;
    }

    function delegateIncreaseApproval(address spender, uint addedValue, address origSender) public returns (bool) {
        require(msg.sender == DELEGATE_FROM);
        increaseApprovalAllArgs(spender, addedValue, origSender);
        return true;
    }

    function delegateDecreaseApproval(address spender, uint subtractedValue, address origSender) public returns (bool) {
        require(msg.sender == DELEGATE_FROM);
        decreaseApprovalAllArgs(spender, subtractedValue, origSender);
        return true;
    }
}