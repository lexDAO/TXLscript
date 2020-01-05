pragma solidity 0.5.11;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract tknBatch {
    using SafeMath for uint256;
 
    function distributeTkn(uint256[] memory tknSum, IERC20 tknAddress, address[] memory recipients)  public {
        for (uint256 i = 0; i < recipients.length; i++) {
		tknAddress.transferFrom(msg.sender, recipients[i], tknSum[i]);
        }
    }
}
