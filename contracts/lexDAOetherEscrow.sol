pragma solidity ^0.5.0;

contract lexDAOetherEscrow {
    
    address payable public buyer;
    address payable public seller;
    address payable public arbitrator = 0x97103fda00a2b47EaC669568063C00e65866a633;
    uint256 public price;
    string public details;
    bool public disputed;
    
    constructor(address payable _seller, string memory _details) payable public {
        buyer = msg.sender;
        seller = _seller;
        price = msg.value;
        details = _details;
    }
    
    function dispute() public {
        require(msg.sender == buyer || msg.sender == seller);
        disputed == true;
    }
    
    function release() public {
        require(msg.sender == buyer);
        require(disputed = false);
        address(seller).transfer(price);
    }
    
    function resolve(uint256 buyerAward, uint256 sellerAward) public {
        require(msg.sender == arbitrator);
        require(disputed = true);
        uint256 arbFee = address(this).balance / 20;
        address(buyer).transfer(buyerAward);
        address(seller).transfer(sellerAward);
        address(arbitrator).transfer(arbFee);
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
