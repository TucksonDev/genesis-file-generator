#!/bin/bash

# Exits if sub-processes fail,
# or if an unset variable is attempted to be used,
# or if there's a pipe failure
set -euo pipefail

# Chain id
CHAIN_ID=42161

# Initial L1 base fee
# (you should set this to your estimate of the parent chain's gas price)
L1_BASE_FEE=1000000000  # 1 gwei

# Nitro node image
NITRO_NODE_IMAGE=offchainlabs/nitro-node:v3.7.3-e421729

# Run the script
forge script script/Predeploys.s.sol:Predeploys \
  --chain-id $CHAIN_ID

# Run the genesis generator on nitro
docker run -v $(pwd)/out:/data/genesisDir --entrypoint genesis-generator $NITRO_NODE_IMAGE --genesis-json-file /data/genesisDir/genesis.json --initial-l1-base-fee $L1_BASE_FEE

echo "Done!"