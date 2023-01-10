# Fresh Rust Installation
# https://www.rust-lang.org/tools/install
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install hermes
## UBUNTU
VERSION=v1.2.0
wget https://github.com/informalsystems/hermes/releases/download/$VERSION/hermes-$VERSION-x86_64-unknown-linux-gnu.zip
sudo apt install unzip
unzip hermes-$VERSION-x86_64-unknown-linux-gnu.zip

echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list
sudo apt-get update && sudo apt-get install libssl1.1

BINARY_PATH=/usr/local/bin
sudo mv hermes $BINARY_PATH
hermes version

# hermes healthcheck for chain
CONFIG=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/config-public.toml
hermes --config $CONFIG health-check


## MACOS
cd $HOME
VERSION=v1.2.0
wget https://github.com/informalsystems/hermes/releases/download/$VERSION/hermes-$VERSION-x86_64-apple-darwin.zip
unzip hermes-$VERSION-x86_64-apple-darwin.zip

chmod +x hermes
BINARY_PATH=/usr/local/bin
mv hermes $BINARY_PATH
hermes version

# hermes healthcheck for chain
CONFIG=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/private-testnet/config-private.toml
hermes --config $CONFIG health-check
