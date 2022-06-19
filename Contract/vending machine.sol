// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.5.0 < 0.9.0;

contract VendingMachine{
    
        address public Owner;
        uint public DonutPrice;

    mapping(address=>uint) public DonutsAmount;
    
    // set the owner as the address that deployed the contract
    //set the price of one donut to 5 ether
    // set the initial vending machine donuts to 100
    
    constructor() {
        
        Owner=msg.sender;
        DonutPrice= 5 ether;
        DonutsAmount[address(this)]=100;
    
    }
    
    //used to allow only owner of contract to perform tasks

    modifier onlyOwner() {
        
        require(msg.sender==Owner,
        "Only owner is allowed to perform this function");
        _;
    
    }
    
    // only contract owner is allowed to update the price of donut
    
    function UpdateDonutPrice(
        uint _UpdatedPrice) 
        public onlyOwner{
        DonutPrice=_UpdatedPrice;
    
    }
    
    // this function get the no of donuts currently present in vending machine
    
    function getVendingMachineBalance() 
        public view returns(uint){
        return 
        DonutsAmount[address(this)];
    
    }
    
    // donuts are restocked here
    
    function RestockDonuts(
        uint _AddAmount) 
        public onlyOwner 
    {
        DonutsAmount[address(this)] += _AddAmount;
    
    }
    
    //here is the purchase function for donut
    //amount of donuts must be greater than or equal to the donuts present
    //price of donut paid by buyer must equal to or higher than the donut price
    //
    
    function PurchaseDonut(
        uint _PayAmount) 
        public payable
    {
        require(Owner != msg.sender,
        "owner must not be the purchase person");

        require(msg.value>=DonutPrice,
        "Not enough amount to purchase donut");
        
        require(DonutsAmount[address(this)] >= _PayAmount,
        "Currently donuts are out of stock wait for restock");

        DonutsAmount[address(this)] -= _PayAmount;
        
        DonutsAmount[msg.sender] += _PayAmount;
    
    }

}
