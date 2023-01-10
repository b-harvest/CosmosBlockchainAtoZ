
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


# git clone hands-on repo to $HOME directory
cd $HOME
git clone https://github.com/b-harvest/CosmosBlockchainAtoZ.git


# get an wallet address for Crescent and its mnemonic
cd $HOME/CosmosBlockchainAtoZ/local-testnet
cat MNEMONIC_RELAYER | crescentd keys add relayer --keyring-backend test --output json 

## Example
## Crescent Wallet : cre1e2r48kgec2twyp5t3yc6lr6ad9mrzy9yx6wl0e
## Relayer Mnemonic : need vanish business stereo beyond promote boat badge tilt frozen soul drive hero medal gown regular adapt mass auction traffic between speed neither exotic
## vi $HOME/crescent.key
## {"name":"relayer","type":"local","address":"cre1e2r48kgec2twyp5t3yc6lr6ad9mrzy9yx6wl0e","pubkey":"{\"@type\":\"/cosmos.crypto.secp256k1.PubKey\",\"key\":\"Al6KfGn/lmQRdQE1mW9A1XexaETY+0h4pm9BRr9QJAOI\"}","mnemonic":"need vanish business stereo beyond promote boat badge tilt frozen soul drive hero medal gown regular adapt mass auction traffic between speed neither exotic"}


# get a wallet address for Cosmso with the mnemonic above (the one you created, NOT the example)
cat MNEMONIC_RELAYER | gaiad keys add relayer --keyring-backend test --output json --recover

## Example
## Cosmos Wallet : cosmos16wvs22rq5lg4vktxdte3zvqerswf5m6597m5k8
## Relayer Mnemonic : need vanish business stereo beyond promote boat badge tilt frozen soul drive hero medal gown regular adapt mass auction traffic between speed neither exotic
## vi gaia.key
## {"name":"relayer","type":"local","address":"cosmos1e2r48kgec2twyp5t3yc6lr6ad9mrzy9yzja665","pubkey":"{\"@type\":\"/cosmos.crypto.secp256k1.PubKey\",\"key\":\"Al6KfGn/lmQRdQE1mW9A1XexaETY+0h4pm9BRr9QJAOI\"}","mnemonic":"need vanish business stereo beyond promote boat badge tilt frozen soul drive hero medal gown regular adapt mass auction traffic between speed neither exotic"}
