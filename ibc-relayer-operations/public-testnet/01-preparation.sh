
# CONFIGURATION - CRESCENT
export CRE_BRANCH=v3.0.0
export CRE_HOME=$HOME/local-mooncat
export CHAIN_ID=local-mooncat
export NODE_MONIKER=COBLA-CRESCENT

# Build crescentd
cd $HOME
git clone https://github.com/crescent-network/crescent
cd crescent
git checkout v3.0.0
make install


# CONFIGURATION - GAIA
export GAIA_BRANCH=v7.0.3
export GAIA_HOME=$HOME/local-gaia
export CHAIN_ID=local-gaia
export NODE_MONIKER=COBLA-GAIA

# Build gaiad
cd $HOME
git clone https://github.com/cosmos/gaia.git
cd gaia
git checkout $GAIA_BRANCH
make install


# get an wallet address for Crescent and its mnemonic
crescentd keys add relayer --keyring-backend test --output json 

## Example
## Crescent Wallet : cre1e2r48kgec2twyp5t3yc6lr6ad9mrzy9yx6wl0e
## Relayer Mnemonic : need vanish business stereo beyond promote boat badge tilt frozen soul drive hero medal gown regular adapt mass auction traffic between speed neither exotic
## vi $HOME/crescent.key
## {"name":"relayer","type":"local","address":"cre1e2r48kgec2twyp5t3yc6lr6ad9mrzy9yx6wl0e","pubkey":"{\"@type\":\"/cosmos.crypto.secp256k1.PubKey\",\"key\":\"Al6KfGn/lmQRdQE1mW9A1XexaETY+0h4pm9BRr9QJAOI\"}","mnemonic":"need vanish business stereo beyond promote boat badge tilt frozen soul drive hero medal gown regular adapt mass auction traffic between speed neither exotic"}


# get a wallet address for Cosmso with the mnemonic above (the one you created, NOT the example)
gaiad keys add relayer --keyring-backend test --output json --recover

## Example
## Cosmos Wallet : cosmos16wvs22rq5lg4vktxdte3zvqerswf5m6597m5k8
## Relayer Mnemonic : need vanish business stereo beyond promote boat badge tilt frozen soul drive hero medal gown regular adapt mass auction traffic between speed neither exotic
## vi gaia.key
## {"name":"relayer","type":"local","address":"cosmos1e2r48kgec2twyp5t3yc6lr6ad9mrzy9yzja665","pubkey":"{\"@type\":\"/cosmos.crypto.secp256k1.PubKey\",\"key\":\"Al6KfGn/lmQRdQE1mW9A1XexaETY+0h4pm9BRr9QJAOI\"}","mnemonic":"need vanish business stereo beyond promote boat badge tilt frozen soul drive hero medal gown regular adapt mass auction traffic between speed neither exotic"}


# git clone hands-on repo to $HOME directory
cd $HOME
git clone https://github.com/b-harvest/CosmosBlockchainAtoZ.git

# Save the relayer mnemonic to RELAYER_MNEMONIC file
cd $HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet
echo "<the relayer mnemonic - 24 words>" > RELAYER_MNEMONIC
echo "need vanish business stereo beyond promote boat badge tilt frozen soul drive hero medal gown regular adapt mass auction traffic between speed neither exotic"  > RELAYER_MNEMONIC
## Example
## > echo "extend caution mushroom hobby yard pelican couple scout broccoli shiver emotion once recycle able picture tiny illegal aunt wine demise target video canvas find" > RELAYER_MNEMONIC



# Use the faucet to receive coins 

## Crescent Testent
## Faucet : https://testnet-faucet.crescent.network
## > crescentd tx bank send <wallet-name> <receiver-address> 1000000ucre  --node tcp://51.195.63.75:16657
## > crescentd q bank balances  <your crescent realyer address>  --node tcp://51.195.63.75:16657
## > crescentd q bank balances  cre16wvs22rq5lg4vktxdte3zvqerswf5m65pkg3r2  --node tcp://51.195.63.75:16657

## Cosmos Testnet
## Faucet : #testnet-faucet  - https://discord.com/invite/cosmosnetwork
## > gaiad tx bank send <wallet-name> <receiver-address> 1000000uatom  --node tcp://51.195.63.75:26657 --keyring-backend test --chain-id theta-testnet-001
## > gaiad q bank balances  <your crescent realyer address>  --node tcp://51.195.63.75:26657
## > gaiad q bank balances  cosmos1e2r48kgec2twyp5t3yc6lr6ad9mrzy9yzja665  --node tcp://51.195.63.75:26657

