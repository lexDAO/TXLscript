pragma solidity 0.5.11;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract chaiBatch {
    using SafeMath for uint256;
    
    address public constant chaiContract = 0x06AF07097C9Eeb7fD685c692751D5C66dB49c215;
    IERC20 chai = IERC20(chaiContract);
    
    function distributeChai(address[] memory recipients, uint256 chaiSum)  public {
        for (uint256 i = 0; i < recipients.length; i++) {
		chai.transferFrom(msg.sender, recipients[i], chaiSum);
        }
    }
}
