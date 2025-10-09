# Genesis.json generator

This repository contains a script to generate a genesis.json file and obtain the block hash and send root hash necessary to create an Arbitrum chain with a set of predeployed contracts at genesis.

## How to use this repository

Clone the repository

```shell
git clone https://github.com/OffchainLabs/genesis-file-generator.git
```

Make a copy of the environment variable and set the necessary values

```shell
cp .env.example .env
```

> [!NOTE]
> Make sure you set the correct values of the environment variables for your chain

Run the script

```shell
./generate.sh
```

The script will output two artifacts:

- A genesis.json file in `out/genesis.json`
- The genesis blockhash and sendRoot in the output of the script. For example:
    ```shell
    BlockHash: 0xf889f684a78849b0f073f584c9b04503441032a1404fca1f8813c16517f3a7af, SendRoot: 0x17f2d1f75de0d8fb0d1e1f2cf8c6a279ed05933e551ede30f74ae3a05b1a3df2
    ```

## Pre-deployed contracts

This section lists the contracts that are pre-deployed (i.e., loaded into state at genesis).

- [GnosisSafe v1.3.0](#gnosissafe-v130-canonical)
- [GnosisSafeL2 v1.3.0](#gnosissafel2-v130-canonical)
- [MultiSend v1.3.0](#multisend-v130-canonical)
- [MultiSendCallOnly v1.3.0](#multisendcallonly-v130-canonical)
- [Safe Singleton Factory](#safesingletonfactory-v1043)
- [Multicall3](#multicall3)
- [Create2Deployer](#create2deployer)

- CreateX	0xba5Ed099633D3B313e4D5F7bdc1305d3c28ba5Ed
- Arachnid's Deterministic Deployment Proxy 0x4e59b44847b379578588920cA78FbF26c0B4956C
- Permit2 0x000000000022D473030F116dDEE9F6B43aC78BA3
- ERC-4337 v0.6.0 EntryPoint 0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789
- SenderCreator dependency @ 0x7fc98430eAEdbb6070B35B39D798725049088348 on ETH mainnet
- ERC-4337 v0.6.0 SenderCreator	0x7fc98430eAEdbb6070B35B39D798725049088348
- ERC-4337 v0.7.0 EntryPoint	0x0000000071727De22E5E9d8BAf0edAc6f37da032
- SenderCreator dependency @ 0xEFC2c1444eBCC4Db75e7613d20C6a62fF67A167C on ETH mainnet
- ERC-4337 v0.8.0 EntryPoint 0x4337084d9e255ff0702461cf8895ce9e3b5ff108
- ERC-4337 v0.7.0 SenderCreator
- ERC-4337 Safe Module Setup 0x2dd68b007B46fBe91B9A7c3EDa5A7a1063cB5b47
- ERC-4337 Safe Module 0x75cf11467937ce3F2f357CE24ffc3DBF8fD5c226
- EAS 0x4200000000000000000000000000000000000021
- Kernel v3.3 0xd6CEDDe84be40893d153Be9d467CD6aD37875b28
- KernelFactory v3.3 0x2577507b78c2008Ff367261CB6285d44ba5eF2E9
- Meta Factory v3.0 0xd703aaE79538628d27099B8c4f621bE4CCd142d5
- ECDSA Validator v3.1 0x845ADb2C711129d4f3966735eD98a9F09fC4cE57

### GnosisSafe v1.3.0 (canonical)

Deployed at `0xd9Db270c1B5E3Bd161E8c8503c55cEABeE709552` using CREATE2.

Source code available at https://github.com/safe-global/safe-smart-account/blob/v1.3.0/contracts/GnosisSafe.sol

Note: there are 2 addresses where this Safe can be deployed to:

- `0x69f4D1788e39c87893C980c06EdF4b7f686e2938`: when using EIP-155 (including the chain id in the transaction)
- `0xd9Db270c1B5E3Bd161E8c8503c55cEABeE709552`: when using the canonical version (without the chain id)

Since we don’t know the chain id beforehand, we use the bytecode of the canonical version

#### How to verify the creation bytecode

Follow the building instructions of the repository and obtain the creation bytecode in the artifacts json file.

### GnosisSafeL2 v1.3.0 (canonical)

Deployed at `0x3e5c63644e683549055b9be8653de26e0b4cd36e` using CREATE2.

Source code available at https://github.com/safe-global/safe-smart-account/blob/v1.3.0/contracts/GnosisSafeL2.sol

Note: there are 2 addresses where this Safe can be deployed to:

- `0xfb1bffC9d739B8D520DaF37dF666da4C687191EA`: when using EIP-155 (including the chain id in the transaction)
- `0x3e5c63644e683549055b9be8653de26e0b4cd36e`: when using the canonical version (without the chain id)

Since we don’t know the chain id beforehand, we use the bytecode of the canonical version

#### How to verify the creation bytecode

Follow the build instructions of the repository and obtain the creation bytecode in the artifacts json file.

### MultiSend v1.3.0 (canonical)

Deployed at `0xa238cbeb142c10ef7ad8442c6d1f9e89e07e7761` using CREATE2.

Source code available at https://github.com/safe-global/safe-smart-account/blob/v1.3.0/contracts/libraries/MultiSend.sol

Note: there are 2 addresses where this contract can be deployed to:

- `0x998739BFdAAdde7C933B942a68053933098f9EDa`: when using EIP-155 (including the chain id in the transaction)
- `0xa238cbeb142c10ef7ad8442c6d1f9e89e07e7761`: when using the canonical version (without the chain id)

Since we don’t know the chain id beforehand, we use the bytecode of the canonical version

#### How to verify the creation bytecode

Follow the build instructions of the repository and obtain the creation bytecode in the artifacts json file.

### MultiSendCallOnly v1.3.0 (canonical)

Deployed at `0x40a2accbd92bca938b02010e17a5b8929b49130d` using CREATE2.

Source code available at https://github.com/safe-global/safe-smart-account/blob/v1.3.0/contracts/libraries/MultiSendCallOnly.sol

Note: there are 2 addresses where this contract can be deployed to:

- `0xA1dabEF33b3B82c7814B6D82A79e50F4AC44102B`: when using EIP-155 (including the chain id in the transaction)
- `0x40a2accbd92bca938b02010e17a5b8929b49130d`: when using the canonical version (without the chain id)

Since we don’t know the chain id beforehand, we use the bytecode of the canonical version

#### How to verify the creation bytecode

Follow the build instructions of the repository and obtain the creation bytecode in the artifacts json file.

### SafeSingletonFactory v1.0.43

Deployed at `0x914d7Fec6aaC8cd542e72Bca78B30650d45643d7` using CREATE2.

Source code available at https://github.com/safe-global/safe-singleton-factory/blob/v1.0.43/source/deterministic-deployment-proxy.yul

This contract is a replica of Arachnid's Deterministic Deployment Proxy, that is deployed using a key controlled by the Safe team.

Since we don't have access to that key, to have this contract available as a pre-deploy in the expected address, we can just `etch` the bytecode to the expected address.

#### How to verify the runtime bytecode

This contract is compiled with a very old version of solc. To obtain the bytecode, run the following command:

```
docker run -v .:/sources --rm ethereum/solc:0.5.8 --strict-assembly /sources/source/deterministic-deployment-proxy.yul --optimize-yul
```

Bytecode:

```
0x604580600e600039806000f350fe7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe03601600081602082378035828234f58015156039578182fd5b8082525050506014600cf3
```

Removing the creation component, `0x604580600e600039806000f350fe`, we are left with the runtime bytecode.

```
0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe03601600081602082378035828234f58015156039578182fd5b8082525050506014600cf3
```

Alternative, the runtime bytecode can be verified in any block explorer, for example, in [Arbiscan](https://arbiscan.io/address/0x914d7Fec6aaC8cd542e72Bca78B30650d45643d7#code).

### Multicall3

Deployed at `0xcA11bde05977b3631167028862bE2a173976CA11` using a pre-signed transactions.

Source code available at https://github.com/mds1/multicall3/blob/v3.1.0/src/Multicall3.sol

#### How to verify the pre-signed transaction and the runtime bytecode

The pre-signed transaction for this contract is available at [its repository](https://github.com/mds1/multicall3#new-deployments).

And the runtime bytecode can be verified by following the build instructions of the repository and obtaining the runtime bytecode in the artifacts json file.

Note that compiling the contract in the repository yields the same bytecode with the exception of the final IPFS metadata hash, which is different than the one that is deployed.

Alternative, the runtime bytecode can be verified in any block explorer, for example, in [Arbiscan](https://arbiscan.io/address/0xcA11bde05977b3631167028862bE2a173976CA11#code).

### Create2Deployer

Deployed at `0x13b0D85CcB8bf860b6b79AF3029fCA081AE9beF2` using CREATE from the address `0x554282Cf65b42fc8fddc6041eb24ce5E8A0632Ad` and nonce 0.

Source code available at https://github.com/pcaversaccio/create2deployer/blob/c7b353935fd9a55110e75fba93bad936db998957/contracts/Create2Deployer.sol

To deploy this contract, we need to act as the deployer address and deploy the creation bytecode.

#### How to verify the creation bytecode

Follow the build instructions of the repository and obtain the creation bytecode in the artifacts json file.

Note: when comparing bytecodes with deployed instances, keep in mind that the contracts deployed on Ethereum, Arbitrum One, or OPStack chains are different, since they are the deprecated versions of the contract (for Ethereum and Arbitrum One), or the version that doesn't inherit from Ownable and Pausable (for OPStack chains). The pre-deployed contract used here is compiled with the latest version of the code, and can be verified with one of the recent deployments, for example the one on [Gravity](https://explorer.gravity.xyz/address/0x13b0D85CcB8bf860b6b79AF3029fCA081AE9beF2).

