# Genesis.json generator

This repository contains a script to generate a genesis.json file and obtain the block hash and send root hash necessary to create an Arbitrum chain with a set of predeployed contracts at genesis.

## Pre-deployed contracts

This section lists the contracts that are pre-deployed (i.e., loaded into state at genesis).

- [GnosisSafe v1.3.0](#gnosissafe-v130-canonical)
- [GnosisSafeL2 v1.3.0](#gnosissafel2-v130-canonical)
- Safe Singleton Factory 0x914d7Fec6aaC8cd542e72Bca78B30650d45643d7
- MultiSend 0x998739BFdAAdde7C933B942a68053933098f9EDa
- MultiSendCallOnly 0xA1dabEF33b3B82c7814B6D82A79e50F4AC44102B
- Multicall3 0xcA11bde05977b3631167028862bE2a173976CA11
- create2Deployer 0x13b0D85CcB8bf860b6b79AF3029fCA081AE9beF2
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

Deployed at `0xd9Db270c1B5E3Bd161E8c8503c55cEABeE709552`

Source code available at https://github.com/safe-global/safe-smart-account/blob/v1.3.0/contracts/GnosisSafe.sol

Note: there are 2 addresses where this Safe can be deployed to:

- `0x69f4D1788e39c87893C980c06EdF4b7f686e2938`: when using EIP-155 (including the chain id in the transaction)
- `0xd9Db270c1B5E3Bd161E8c8503c55cEABeE709552`: when using the canonical version (without the chain id)

Since we don’t know the chain id beforehand, we use the bytecode of the canonical version

#### How to verify the creation bytecode

Follow the building instructions of the repository and obtain the creation bytecode in the artifacts json file.

### GnosisSafeL2 v1.3.0 (canonical)

Deployed at `0x3e5c63644e683549055b9be8653de26e0b4cd36e`

Source code available at https://github.com/safe-global/safe-smart-account/blob/v1.3.0/contracts/GnosisSafeL2.sol

Note: there are 2 addresses where this Safe can be deployed to:

- `0xfb1bffC9d739B8D520DaF37dF666da4C687191EA`: when using EIP-155 (including the chain id in the transaction)
- `0x3e5c63644e683549055b9be8653de26e0b4cd36e`: when using the canonical version (without the chain id)

Since we don’t know the chain id beforehand, we use the bytecode of the canonical version

#### How to verify the creation bytecode

Follow the build instructions of the repository and obtain the creation bytecode in the artifacts json file.

