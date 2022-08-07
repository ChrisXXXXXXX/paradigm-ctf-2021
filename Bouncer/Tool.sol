// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
import "https://github.com/Arachnid/solidity-stringutils/blob/master/src/strings.sol";
import "./Bouncer.sol";



contract Tool {
    using strings for *;

    function TransferETHtoWho(address who) public payable{
        payable(who).transfer(msg.value);
    }   

    function WhoEtherBalance(address who) public view returns (uint256){
        return who.balance;
    }   

    function Encode(string memory FunSig, // payout(ERC20Like,address,uint256)
                    Bouncer bouncer) public pure returns (bytes memory){
        // abi.encodeWithSelector(ContractB.setTokenName.selector,”BoringToken”)
        // bytes4 private constant FUNC_SELECTOR = bytes4(keccak256("someFunc(address,uint256)"));
        bytes4 FUNC_SELECTOR = bytes4(keccak256(bytes(FunSig)));
        bytes memory data = abi.encodeWithSelector(FUNC_SELECTOR, bouncer);
        return data;
    } 
}

