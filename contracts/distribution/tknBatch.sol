pragma solidity 0.5.11;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract tknBatch {
    using SafeMath for uint256;
 
    function distributeTkn(address[] memory recipients, uint256 tknSum, IERC20 tknAddress)  public {
        for (uint256 i = 0; i < recipients.length; i++) {
		      tknAddress.transferFrom(msg.sender, recipients[i], tknSum);
        }
    }
}
