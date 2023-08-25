// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract USDCWithSixDecimal is ERC20 {
    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {
        _mint(msg.sender, 120000 * 10**decimals());
    }

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function mint(address _to, uint _amount) external {
        
        _mint(_to, _amount);
    }
}
