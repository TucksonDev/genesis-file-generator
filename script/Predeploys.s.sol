// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "forge-std/StdJson.sol";
import "src/PredeployConstants.sol";

contract Predeploys is Script {
    using stdJson for string;

    /// @notice Main deployer account (for CREATE2 deployments)
    address deployer = makeAddr("deployer");

    /// @notice Output path for the generated JSON file
    string jsonOutPath = "out/genesis.json";

    function setUp() public {
        // Deal funds to deployer accounts
        vm.deal(deployer, 1 ether);
        vm.deal(Multicall3Deployer, 1 ether);
        vm.deal(ArachnidsDeployer, 1 ether);
    }

    /// @notice Adds predeploy information to a JSON object
    /// @param predeploy The address of the predeploy
    /// @param code The runtime bytecode of the predeploy
    /// @param storageSlots The storage slots that were written during deployment
    /// @return predeployJson The JSON object as a string
    function addPredeployInformationToJson(address predeploy, bytes memory code, bytes32[] memory storageSlots) public returns (string memory) {
        string memory predeployJson = "predeployJson";
        vm.serializeString(predeployJson, "balance", "");
        vm.serializeString(predeployJson, "nonce", "");
        vm.serializeBytes(predeployJson, "code", code);

        // Storage changes
        string memory predeployStorageJson = "predeployStorageJson";
        if (storageSlots.length > 0) {
            for (uint i = 0; i < storageSlots.length - 1; i++) {
                bytes32 value = vm.load(predeploy, storageSlots[i]);
                vm.serializeBytes32(predeployStorageJson, vm.toString(storageSlots[i]), value);
            }

            // Last entry, we obtain the json object
            predeployStorageJson = vm.serializeBytes32(predeployStorageJson, vm.toString(storageSlots[storageSlots.length - 1]), vm.load(predeploy, storageSlots[storageSlots.length - 1]));
        } else {
            predeployStorageJson = "{}";
        }
        predeployJson = vm.serializeString(predeployJson, "storage", predeployStorageJson);

        return predeployJson;
    }

    /// @notice Deploys a contract's bytecode using CREATE2
    /// @param bytecode The bytecode to deploy
    /// @param salt The salt to use for CREATE2
    /// @param expectedAddr The expected address of the deployed contract
    /// @return code The runtime bytecode of the deployed contract
    function deployContractViaCreate2(bytes memory bytecode, bytes32 salt, address expectedAddr) public returns (bytes memory code, bytes32[] memory writeSlots) {
        address addr;
        vm.record();
        assembly {
            addr := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        }
        vm.stopRecord();

        // Verify that the contract was deployed
        require(addr != address(0), "CREATE2 failed");

        // Verify that the contract was deployed to the expected address
        require(addr == expectedAddr, "Contract deployed to incorrect address");
        
        // Return the runtime bytecode of the deployed contract and the written storage slots
        code = expectedAddr.code;
        (, writeSlots) = vm.accesses(expectedAddr);
    }

    /// @notice Deploys a contract using a signed transaction
    /// @param txData The signed transaction data
    /// @param expectedAddr The expected address of the deployed contract
    /// @return code The runtime bytecode of the deployed contract
    function deployContractViaSignedTransaction(bytes memory txData, address expectedAddr) public returns (bytes memory code, bytes32[] memory writeSlots) {
        vm.record();
        vm.broadcastRawTransaction(txData);
        vm.stopRecord();

        // Verify that there's code at the expected address
        uint256 size;
        assembly {
            size := extcodesize(expectedAddr)
        }
        require(size > 0, "No code at the expected address");
        
        // Return the runtime bytecode of the deployed contract and the written storage slots
        code = expectedAddr.code;
        (, writeSlots) = vm.accesses(expectedAddr);
    }

    /// @notice Sets the runtime bytecode of a contract directly
    /// @param target The address of the contract to set the bytecode for
    /// @param runtimeBytecode The runtime bytecode to set
    /// @return code The runtime bytecode of the contract after setting it
    function setContractRuntimeBytecode(address target, bytes memory runtimeBytecode) public returns (bytes memory code, bytes32[] memory writeSlots) {
        vm.etch(target, runtimeBytecode);
        code = target.code;
        writeSlots = new bytes32[](0);
    }

    function run() public {
        // Initialize JSON output
        string memory genesisJson = "genesisJson";

        vm.startBroadcast();

        // ---------------------
        // Safe1.3 (via CREATE2)
        // ---------------------
        console.log("Deploying Safe 1.3");
        (bytes memory safe1_3Code, bytes32[] memory safe1_3WriteSlots) = deployContractViaCreate2(Safe1_3CreationBytecode, Safe1_3Salt, Safe1_3Address);
        console.log("Safe 1.3 deployed at:", Safe1_3Address);
        string memory safe1_3Json = addPredeployInformationToJson(Safe1_3Address, safe1_3Code, safe1_3WriteSlots);
        vm.serializeString(genesisJson, vm.toString(Safe1_3Address), safe1_3Json);

        // -----------------------------------
        // Multicall3 (via signed transaction)
        // -----------------------------------
        console.log("Deploying Multicall3");
        (bytes memory multicall3Code, bytes32[] memory multicall3WriteSlots) = deployContractViaSignedTransaction(MultiCall3Tx, MultiCall3Address);
        console.log("MultiCall3 deployed at:", MultiCall3Address);
        string memory multicall3Json = addPredeployInformationToJson(MultiCall3Address, multicall3Code, multicall3WriteSlots);
        vm.serializeString(genesisJson, vm.toString(MultiCall3Address), multicall3Json);

        // ---------------------
        // Permit2 (via CREATE2)
        // ---------------------
        console.log("Deploying Permit2");
        (bytes memory permit2Code, bytes32[] memory permit2WriteSlots) = deployContractViaCreate2(Permit2CreationBytecode, Permit2Salt, Permit2Address);
        console.log("Permit2 deployed at:", Permit2Address);
        string memory permit2Json = addPredeployInformationToJson(Permit2Address, permit2Code, permit2WriteSlots);
        vm.serializeString(genesisJson, vm.toString(Permit2Address), permit2Json);

        // -------------------------------------------------------------------
        // Arachnid's Deterministic Deployment Proxy (via signed transaction)
        // -------------------------------------------------------------------
        // Note: By default, this proxy is already deployed in foundry's local chains

        // ---------------------------------------------------------
        // Safe Singleton Factory (via setting the runtime bytecode)
        // ---------------------------------------------------------
        console.log("Deploying Safe Singleton Factory");
        (bytes memory safeSingletonFactoryCode, bytes32[] memory safeSingletonFactoryWriteSlots) = setContractRuntimeBytecode(SafeSingletonFactoryAddress, SafeSingletonFactoryRuntimeBytecode);
        console.log("Safe Singleton Factory deployed at:", SafeSingletonFactoryAddress);
        string memory safeSingletonFactoryJson = addPredeployInformationToJson(SafeSingletonFactoryAddress, safeSingletonFactoryCode, safeSingletonFactoryWriteSlots);
        genesisJson = vm.serializeString(genesisJson, vm.toString(SafeSingletonFactoryAddress), safeSingletonFactoryJson);

        vm.stopBroadcast();
        
        // Write the JSON output to file
        genesisJson.write(jsonOutPath);
        console.log("Wrote runtime bytecode to", jsonOutPath);
    }
}
