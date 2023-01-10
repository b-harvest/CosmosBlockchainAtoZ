# VARIABLES
VALIDATOR_2_MNEMONIC=$(cat $HOME/CosmosBlockchainAtoZ/local-testnet/MNEMONIC_VALIDATOR_2)

CHAIN_ID=local-mooncat
CHAIN_CODE=12

VHOME=$HOME/local-mooncat2
BINARY=$(which crescentd)
MONIKER=cobla-${CHAIN_ID}


# Initialize chain config
rm -rf $VHOME
$BINARY init $MONIKER --chain-id $CHAIN_ID --home $VHOME

$BINARY config node tcp://localhost:1${CHAIN_CODE}57 --home $VHOME
$BINARY config chain-id $CHAIN_ID --home $VHOME
$BINARY config keyring-backend test --home $VHOME
$BINARY config output json --home $VHOME

# copy genesis
cp $HOME/local-mooncat/config/genesis.json $VHOME/config/genesis.json

# Change other options and ports
sed -i.bak -e "s/^enable = false/enable = true/" $VHOME/config/app.toml
sed -i.bak -e "s/^swagger = false/swagger = true/" $VHOME/config/app.toml
sed -i.bak -e "s/^enabled-unsafe-cors = false/enabled-unsafe-cors = true/" $VHOME/config/app.toml
sed -i.bak -e "s/^cors_allowed_origins = \[\]/cors_allowed_origins = \[\"*\"\]/" $VHOME/config/config.toml

sed -i.bak -e "s/^address = \"tcp:\/\/0.0.0.0:1317\"/address = \"tcp:\/\/0.0.0.0:1${CHAIN_CODE}17\"/" $VHOME/config/app.toml
sed -i.bak -e "s/^address = \":8080\"/address = \":1${CHAIN_CODE}80\"/" $VHOME/config/app.toml
sed -i.bak -e "s/^address = \"0.0.0.0:9090\"/address = \"0.0.0.0:1${CHAIN_CODE}90\"/" $VHOME/config/app.toml
sed -i.bak -e "s/^address = \"0.0.0.0:9091\"/address = \"0.0.0.0:1${CHAIN_CODE}91\"/" $VHOME/config/app.toml

sed -i.bak -e "s/^proxy_app = \"tcp:\/\/127.0.0.1:26658\"/proxy_app = \"tcp:\/\/127.0.0.1:1${CHAIN_CODE}58\"/" $VHOME/config/config.toml
sed -i.bak -e "s/^laddr = \"tcp:\/\/127.0.0.1:26657\"/laddr = \"tcp:\/\/0.0.0.0:1${CHAIN_CODE}57\"/" $VHOME/config/config.toml
sed -i.bak -e "s/^pprof_laddr = \"localhost:6060\"/pprof_laddr = \"localhost:1${CHAIN_CODE}66\"/" $VHOME/config/config.toml
sed -i.bak -e "s/^laddr = \"tcp:\/\/0.0.0.0:26656\"/laddr = \"tcp:\/\/0.0.0.0:1${CHAIN_CODE}56\"/" $VHOME/config/config.toml
sed -i.bak -e "s/^prometheus_listen_addr = \":26660\"/prometheus_listen_addr = \":1${CHAIN_CODE}60\"/" $VHOME/config/config.toml

NODEID=$(11st | grep \"id\" | awk -F"\"" '{print $4}')
sed -i.bak -e "s/^persistent_peers = \".*\"/persistent_peers = \"${NODEID}@127.0.0.1:11156\"/" $VHOME/config/config.toml



## Add aliases for shortcut

alias ${CHAIN_CODE}st='$BINARY status --node tcp://127.0.0.1:1${CHAIN_CODE}57 2>&1 | jq'
alias ${CHAIN_CODE}info='curl -sS http://127.0.0.1:1${CHAIN_CODE}57/net_info | egrep "n_peers|moniker"'


# Terminal 2 : Use other terminal to make the process run 
VHOME=$HOME/local-mooncat2
BINARY=$(which crescentd)

$BINARY start --home $VHOME


# Create keys of validator and relayer
VALIDATOR_2=$(echo "$VALIDATOR_2_MNEMONIC" | $BINARY keys add validator --recover --keyring-backend test --output json --home $VHOME 2>&1| jq -r '.address')

# Add new valiadtor into genesis.json
AMOUNT=1000000ucre
$BINARY tx staking create-validator $AMOUNT \
	--keyring-backend test \
    --moniker $MONIKER \
    --chain-id $CHAIN_ID \
    --amount $AMOUNT \
    --commission-max-change-rate 0.1 \
    --commission-max-rate 1.0  \
    --commission-rate 0.1 \
    --min-self-delegation 1 \
    --pubkey=$($BINARY tendermint show-validator --home $VHOME)  \
    --from validator \
    --home $VHOME


# Terminal 1 : Test bank send tx
VHOME=$HOME/local-mooncat2
BINARY=$(which crescentd)

$BINARY keys list --home $VHOME --keyring-backend test
RELAYER_WALLET=cre1e2r48kgec2twyp5t3yc6lr6ad9mrzy9yx6wl0e
VALIDATOR_1_WALLET=cre1jputs32a6c5m6f572tp9cpk0n7pvnk4rdfwhvs
VALIDATOR_2_WALLET=cre1856zhx99w9a0xtdxlgp36j7jyuw30hshm44nj6
CRE_NODE=tcp://127.0.0.1:11257

$BINARY q bank balances $RELAYER_WALLET --node $CRE_NODE
$BINARY q bank balances $VALIDATOR_1_WALLET --node $CRE_NODE
$BINARY q bank balances $VALIDATOR_2_WALLET --node $CRE_NODE
