pragma solidity ^0.5.2;

contract lexDAOetherEscrow {
    
    address payable public buyer;
    address payable public seller;
    address payable public arbitrator = 0xE5579C0FAC49B7bC032B11D019AB98A614e49D34;
    uint256 public price;
    string public details;
    string public complaint;
    bool public disputed;
    bool public closed;
    
    event Released(uint256 indexed price);
    event Disputed(address indexed complainant);
    event Resolved(uint256 indexed buyerAward, uint256 indexed sellerAward);
    
    constructor(
        address payable _buyer,
        address payable _seller, 
        string memory _details) payable public {
        buyer = _buyer;
        seller = _seller;
        price = msg.value;
        details = _details;
    }
    
    function release() public {
        require(msg.sender == buyer);
        require(disputed == false);
        address(seller).transfer(price);
        closed = true;
        emit Released(price);
    }
    
    function dispute(string memory _complaint) public {
        require(msg.sender == buyer || msg.sender == seller);
        require(closed == false);
        disputed = true;
        complaint = _complaint;
        emit Disputed(msg.sender);
    }
    
    function resolve(uint256 buyerAward, uint256 sellerAward) public {
        require(msg.sender == arbitrator);
        require(disputed == true);
        uint256 arbFee = price / 20;
        require(buyerAward + sellerAward + arbFee == price);
        address(buyer).transfer(buyerAward);
        address(seller).transfer(sellerAward);
        address(arbitrator).transfer(arbFee);
        closed = true;
        emit Resolved(buyerAward, sellerAward);
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract lexDAOetherEscrowFactory {
    
    uint8 LEEversion = 1;
    
    lexDAOetherEscrow private LEE;
    
    address[] public escrows;
    
    event Deployed(
        address indexed lexDAOetherEscrow, 
        address indexed _buyer, 
        address indexed _seller);
    
    function newlexDAOetherEscrow(
        address payable _seller, 
        string memory _details) payable public {
           
        LEE = (new lexDAOetherEscrow).value(msg.value)(
            msg.sender,
            _seller,
            _details);
        
        escrows.push(address(LEE));
        
        emit Deployed(address(LEE), msg.sender, _seller);

    }
    
    function getEscrowCount() public view returns (uint256 escrowCount) {
        return escrows.length;
    }
    
    function getEscrowAddresses() public view returns (address[] memory) {
        return escrows;
    }
}
