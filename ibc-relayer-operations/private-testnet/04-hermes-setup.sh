# Fresh Rust Installation
# https://www.rust-lang.org/tools/install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install hermes from source code
git clone https://github.com/informalsystems/hermes.git
cd hermes
git checkout v1.2.0
cargo build --release --bin hermes

BINARY_PATH=/usr/local/BINARY_PATH
mv ./target/release/hermes $BINARY_PATH
hermes version


# Install hermes binary
## UBUNTU 20.04 LTS
cd $HOME
VERSION=v1.1.0
wget https://github.com/informalsystems/hermes/releases/download/$VERSION/hermes-$VERSION-x86_64-unknown-linux-gnu.zip
sudo apt install unzip
unzip hermes-$VERSION-x86_64-unknown-linux-gnu.zip

# echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list
# sudo apt-get update && sudo apt-get install libssl1.1

BINARY_PATH=/usr/local/bin
sudo mv hermes $BINARY_PATH
hermes version

# hermes healthcheck for chain
CONFIG=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/config-public.toml
hermes --config $CONFIG health-check


## MACOS
### brew install wget
cd $HOME
VERSION=v1.2.0
wget https://github.com/informalsystems/hermes/releases/download/$VERSION/hermes-$VERSION-x86_64-apple-darwin.zip
unzip hermes-$VERSION-x86_64-apple-darwin.zip

chmod +x hermes
BINARY_PATH=/usr/local/bin
sudo mv hermes $BINARY_PATH
hermes version

# hermes healthcheck for chain
CONFIG=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/config-public.toml
hermes --config $CONFIG health-check
