require('dotenv').config();
require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("hardhat-deploy-ethers")
require('hardhat-abi-exporter');
// require("hardhat-gas-reporter");
require("@nomiclabs/hardhat-web3");
require("solidity-coverage");
require('hardhat-spdx-license-identifier');
require('hardhat-contract-sizer');
require('hardhat-deploy');


const privateKey = process.env.PRIVATE_KEY;
// const alchemyApi = process.env.ALCHEMY_API;




// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  gasReporter: {
    currency: 'CHF',
    gasPrice: 21
  },
  contractSizer: {
    alphaSort: true,
    disambiguatePaths: false,
    runOnCompile: true,
    strict: true,
    only: ["Admin", "TokenSale"],
  },
  solidity: "0.8.11",
  settings: {
    optimizer: {
      enabled: true,
      runs: 200,
    }
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
    staker: {
      default: 1,
    },
    alice: {
      default: 2,
    }
  },
  networks: {
    hardhat: {
      // forking: {
      //   url: `https://eth-mainnet.alchemyapi.io/v2/${alchemyApi}`,
      //   enabled: true,
      // }
    },
    bsctestnet: {
      url: 'https://data-seed-prebsc-2-s2.binance.org:8545',
      accounts: [`0x${privateKey}`],
    },
    rinkebytest:{
      url: 'https://rinkeby.infura.io/v3/204c5bcab7764350a6a937923dc68847',
      accounts: [`0x${privateKey}`],
    },
    ropsten:{
      gas: 9000000000000000000,
      url: 'https://ropsten.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
      accounts: [`0x${privateKey}`],
    },
    bscmainnet: {
      url: 'https://bsc-dataseed.binance.org/',
      accounts: [`0x${privateKey}`],
    },
    polygonmainnet:{
      url: 'https://polygon-rpc.com/',
      accounts: [`0x${privateKey}`]

    },
    mumbaitestnet:{
      url: 'https://rpc-mumbai.maticvigil.com/',
      accounts: [`0x${privateKey}`]
    },
    local: {
      url: 'http://127.0.0.1:8545/',
      allowUnlimitedContractSize: true,
      accounts: ['0xc13dc6ee0769c578ebdecff5b09cb1481b955d31bd41dbfa7c151026a0abf224'],
      blockGasLimit: 1200000000,
    }

    // buidlerevm: {
    //   gas: 900000000000,
    //   blockGasLimit: 0x1fffffffffffff,
    //   allowUnlimitedContractSize: true
    // }
  },

  spdxLicenseIdentifier: {
    overwrite: true,
    runOnCompile: true,
  },
  paths: {
    deploy: 'deploy',
    deployments: 'deployments',
    imports: 'imports'
  },
  etherscan: {
    apiKey: "U4H69A9Z3FE2BVJKRVAYYGZA8PF75FUKZ9"
  },
  mocha: {
    timeout: 100000
  }

};

