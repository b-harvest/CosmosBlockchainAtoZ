# Install hermes 
VERSION=v1.1.0
wget https://github.com/informalsystems/hermes/releases/download/$VERSION/hermes-$VERSION-x86_64-unknown-linux-gnu.zip
sudo apt install unzip
unzip hermes-$VERSION-x86_64-unknown-linux-gnu.zip

echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list
sudo apt-get update && sudo apt-get install libssl1.1

mv hermes $GOPATH/bin/
hermes version

# hermes healthcheck
CONFIG=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/config-public.toml
hermes --config $CONFIG health-check

# Start hermes service 
screen -S hermes
CONFIG=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/config-public.toml
hermes --config $CONFIG start
Ctrl + A,D

screen -ls
screen -R hermes
Ctrl + A,D 
