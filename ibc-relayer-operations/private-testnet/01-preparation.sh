# git clone hands-on repo to $HOME directory
cd $HOME
git clone https://github.com/b-harvest/CosmosBlockchainAtoZ.git

# CONFIGURATION - CRESCENT
## Windows WSL Ubuntu : su - ubuntu
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
## MAC OS : make build
## MAC OS : sudo cp build/crescentd /usr/local/bin

crescentd version

# CONFIGURATION - GAIA
## Windows WSL Ubuntu : su - ubuntu
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
## MAC OS : make build
## MAC OS : sudo cp build/gaiad /usr/local/bin

