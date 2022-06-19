// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.5.0 < 0.9.0;

contract VendingMachine{
    
        address public Owner;
        uint public DonutPrice;

    mapping(address=>uint) public DonutsAmount;
    constructor() {
        
        Owner=msg.sender;
        DonutPrice= 5 ether;
        DonutsAmount[address(this)]=100;
    
    }

    modifier onlyOwner() {
        
        require(msg.sender==Owner,
        "Only owner is allowed to perform this function");
        _;
    
    }
    function UpdateDonutPrice(
        uint _UpdatedPrice) 
        public onlyOwner{
        DonutPrice=_UpdatedPrice;
    
    }
    function getVendingMachineBalance() 
        public view returns(uint){
        return 
        DonutsAmount[address(this)];
    
    }
    function RestockDonuts(
        uint _AddAmount) 
        public onlyOwner 
    {
        DonutsAmount[address(this)] += _AddAmount;
    
    }
    function PurchaseDonut(
        uint _PayAmount) 
        public payable
    {
        require(Owner != msg.sender,
        "owner must not be the purchase person");

        require(msg.value>=DonutPrice,
        "Not enough amount to purchase donut");
        
        require(DonutsAmount[address(this)] >= _PayAmount,"Currently donuts are out of stock wait for restock");

        DonutsAmount[address(this)] -= _PayAmount;
        
        DonutsAmount[msg.sender] += _PayAmount;
    
    }

}