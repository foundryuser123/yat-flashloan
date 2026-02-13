// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { FlashLoanSimpleReceiverBase } 
    from "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import { IPoolAddressesProvider } 
    from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import { IPool } 
    from "@aave/core-v3/contracts/interfaces/IPool.sol";
import { IERC20 } 
    from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { Ownable } 
    from "@openzeppelin/contracts/access/Ownable.sol";
import { ISwapRouter } 
    from "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import { INonfungiblePositionManager } 
    from "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";

contract FlashloanUniTest is FlashLoanSimpleReceiverBase, Ownable {
    ISwapRouter public swapRouter;
    INonfungiblePositionManager public positionManager;

    constructor(
        address _provider,
        address _router,
        address _positionManager
    )
        FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_provider))
        Ownable(msg.sender)
    {
        swapRouter = ISwapRouter(_router);
        positionManager = INonfungiblePositionManager(_positionManager);
    }

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        uint256 totalOwed = amount + premium;
        IERC20(asset).approve(address(POOL), totalOwed);
        return true;
    }
}

