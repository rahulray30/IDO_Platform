// SPDX-License-Identifier: UNLICENSED




// pragma solidity ^0.8.11;

// import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// import "./Staking.sol";
// import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
// import "./interfaces/IAdmin.sol";
// import "./interfaces/IAirdrops.sol";
// import "./interfaces/IERC20D.sol";
// import "./interfaces/ITokenSale.sol";
// import "./interfaces/IVesting.sol";

// abstract contract Vesting is Initializable, IVesting{
//     using SafeERC20 for IERC20D;

//     uint64 constant PCT_BASE = 1 ether;
//     uint64 constant ORACLE_MUL = 1e10;
//     uint64 constant POINT_BASE = 1000;


//     IStaking stakingContract;
//     IAdmin admin;
//     IERC20D token;
//     ITokenSale tokenSale;
//     Params params;

//     // mapping(address => mapping(address => VestingDetails)) public vesting;
    
//     function initialize(address _stakingContract,address _admin) external initializer 
//     {
//     stakingContract = IStaking(_stakingContract);
//     admin = IAdmin(_admin);
//     }

//     function claim(address _tokenSale, address _staking) external {
//     tokenSale = ITokenSale(_tokenSale);
//     tokenSale.checkingEpoch();
//     require(uint8(tokenSale.epoch()) > 1 && !admin.blockClaim(address(this)),
//     "incorrect time"
//     );
       
//         address sender = msg.sender;
//         require(!claimed()[sender],"Claimed");
//         Staked storage s = tokenSale.stakes[sender];
//         require(s.amount != 0, "No Deposit");
//         /** @nEtice An investor can withdraw no more tokens than they bought or than allowed by their tier */
//         uint256 value;
//         uint256 left;
//         if (s.share == 0) {
//             (s.share, left) = _claim(s);
//     }
//         (int8 newPoint, uint256 pct) = _canPct(block.timestamp, s.point);
//         require(pct > 0 || left > 0, "All claimed");
//         value = (s.share * pct) / tokenSale.POINT_BASE;
//         s.point = newPoint;
//         s.claim += value;
//         tokenSale.claimed[sender] = newPoint == -1 || value == 0 ? true : false; //share == 0?
//         if (value > 0) {
//             tokenSale.token.safeTransfer(sender, tokenSale._shift(value));
//         }
//         emit Claim(sender, tokenSale._shift(value), left);
//         if (left > 0) {
//             (bool success, ) = sender.call{value: left}("");
//             require(success);
//         }
//     }

//     function _claim(Staked memory _s) internal view returns (uint256, uint256) {
//         uint256 supply = tokenSale.amountForSale();
//         if (tokenSale.state.totalPrivateSold > supply) {
//             uint256 rate;
//             if (supply > tokenSale.state.freePrivateSold && !_s.free) {
//                 rate =
//                     ((supply - tokenSale.state.freePrivateSold) * tokenSale.PCT_BASE) /
//                     (tokenSale.state.totalPrivateSold - tokenSale.state.freePrivateSold);
//             } else if (supply <= tokenSale.state.freePrivateSold && _s.free) {
//                 rate = (supply * tokenSale.PCT_BASE) / tokenSale.state.freePrivateSold;
//             } else {
//                 rate = tokenSale.PCT_BASE;
//             }
//             _s.share = rate > 0
//                 ? (_s.amount * rate) / tokenSale.PCT_BASE
//                 : rate == tokenSale.PCT_BASE
//                 ? _s.amount
//                 : 0;
//             return (
//                 _s.share,
//                 ((_s.amount - _s.share) * tokenSale.privatePrice) / tokenSale.PCT_BASE
//             );
//         } else {
//             return (_s.amount, 0);
//         }
//     }

//     function canClaim(address _user) external view returns (uint256, uint256) {
//         return _claim(tokenSale.stakes[_user]);
//     }

//     function _canPct(uint256 _now, int8 _curPoint)
//         internal
//         view
//         returns (int8 _newPoint, uint256 _pct)
//     {
//         _newPoint = _curPoint;
//         for (uint8 i = 0; i <= uint8(_curPoint); i++) {
//             if (_now >= tokenSale.params.vestingPoints[i][0]) {
//                 _newPoint = int8(i) - 1;
//                 for (uint8 j = i; j <= uint8(_curPoint); j++) {
//                     _pct = _pct + tokenSale.params.vestingPoints[j][1];
//                 }
//                 break;
//             }
//         }
//     }
// }
