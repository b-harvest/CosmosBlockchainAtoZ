# CONFIGURATION - CRESCENT
export CRE_BRANCH=v3.0.0
export CRE_HOME=/data/local-mooncat
export CHAIN_ID=local-mooncat
export NODE_MONIKER=COBLA-CRESCENT

# Build crescentd
git clone https://github.com/crescent-network/crescent
cd crescent
git checkout v3.0.0
make install


# CONFIGURATION - GAIA
export GAIA_BRANCH=v7.0.3
export GAIA_HOME=/data/local-gaia
export CHAIN_ID=local-gaia
export NODE_MONIKER=COBLA-GAIA

# Build gaiad
cd $HOME
git clone https://github.com/cosmos/gaia.git
cd gaia
git checkout $GAIA_BRANCH
make install

