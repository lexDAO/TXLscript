pragma solidity ^0.5.2;

contract FDT_ERC20ExtensionFactory {
    // presented by OpenEsquire || lexDAO
    
    FDT_ERC20Extension private FDT;
    
    address[] public tokens;
    
    event Deployed(address indexed FDT, address indexed initialOwner);
    
    function newFDT(
        string memory name, 
		string memory symbol,
		IERC20 _fundsToken,
		uint256 initialAmount) public {
       
        FDT = new FDT_ERC20Extension(
            name, 
            symbol, 
            _fundsToken,
            msg.sender,
            initialAmount);
        
        tokens.push(address(FDT));
        
        emit Deployed(address(FDT), msg.sender);

    }
    
    function getTokenCount() public view returns (uint256 tokenCount) {
        return tokens.length;
    }
}
