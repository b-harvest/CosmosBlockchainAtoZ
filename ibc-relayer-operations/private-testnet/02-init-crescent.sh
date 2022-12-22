# VARIABLES
RELAYER_MNEMONIC=$(cat $HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/private-testnet/RELAYER_MNEMONIC)
VALIDATOR_MNEMONIC=$(cat $HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/private-testnet/VALIDATOR_MNEMONIC)

CHAIN_ID=local-mooncat
CHAIN_CODE=11

VHOME=$HOME/local-mooncat
BINARY=$(which crescentd)
MONIKER=cobla-${CHAIN_ID}


# Initialize chain config
rm -rf $VHOME
$BINARY init $MONIKER --chain-id $CHAIN_ID --home $VHOME

$BINARY config node tcp://localhost:1${CHAIN_CODE}57 --home $VHOME
$BINARY config chain-id $CHAIN_ID --home $VHOME
$BINARY config keyring-backend test --home $VHOME
$BINARY config output json --home $VHOME

# Change genesis parameters
sed -i.bak -e 's/minimum-gas-prices = \"\"/minimum-gas-prices = \"0ucre,0bcre\"/g' $VHOME/config/app.toml
sed -i.bak -e 's/"stake"/"ucre"/g' $VHOME/config/genesis.json
sed -i.bak -e 's/"bstake"/"ubcre"/g' $VHOME/config/genesis.json
sed -i.bak -e 's%"amount": "10000000"%"amount": "1"%g' $VHOME/config/genesis.json
sed -i.bak -e 's%"max_deposit_period": "172800s"%"max_deposit_period": "300s"%g' $VHOME/config/genesis.json
sed -i.bak -e 's%"voting_period": "172800s"%"voting_period": "300s"%g' $VHOME/config/genesis.json
sed -i.bak -e 's%"inflation": "0.130000000000000000",%"inflation": "0.500000000000000000",%g' $VHOME/config/genesis.json
sed -i.bak -e 's%"unbonding_time": "1814400s",%"unbonding_time": "300s",%g' $VHOME/config/genesis.json
sed -i.bak -e 's%"downtime_jail_duration": "600s",%"downtime_jail_duration": "60s",%g' $VHOME/config/genesis.json

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



## Add aliases for shortcut

alias ${CHAIN_CODE}st='$BINARY status --node tcp://127.0.0.1:1${CHAIN_CODE}57 2>&1 | jq'
alias ${CHAIN_CODE}info='curl -sS http://127.0.0.1:1${CHAIN_CODE}57/net_info | egrep "n_peers|moniker"'


# Create keys of validator and relayer
VALIDATOR=$(echo "$VALIDATOR_MNEMONIC" | $BINARY keys add validator --recover --keyring-backend test --output json --home $VHOME 2>&1| jq -r '.address')
RELAYER=$(echo "$RELAYER_MNEMONIC" | $BINARY keys add relayer --recover  --output json --home $VHOME 2>&1 | jq -r '.address')


# Fund wallets of validator and relayer in genesis.json
AMOUNT=100000000000ucre
$BINARY add-genesis-account $VALIDATOR $AMOUNT --home $VHOME
$BINARY add-genesis-account $RELAYER $AMOUNT --home $VHOME


# Add new valiadtor into genesis.json
AMOUNT=5000000000ucre
$BINARY gentx validator $AMOUNT \
	--keyring-backend test \
    --moniker $MONIKER \
    --chain-id $CHAIN_ID \
    --commission-max-change-rate 0.1 \
    --commission-max-rate 1.0  \
    --commission-rate 0.1 \
    --min-self-delegation 1 \
    --pubkey=$($BINARY tendermint show-validator --home $VHOME)  \
    --from validator \
    --home $VHOME
$BINARY collect-gentxs $VHOME/config/gentx --home $VHOME

$BINARY tendermint unsafe-reset-all --home $VHOME


# Terminal 2 : Use other terminal to make the process run 
VHOME=$HOME/local-mooncat
BINARY=$(which crescentd)

$BINARY start --home $VHOME


# Terminal 1 : Test bank send tx
VHOME=$HOME/local-mooncat
BINARY=$(which crescentd)

$BINARY keys list --home $VHOME --keyring-backend test
CRE_NODE=tcp://127.0.0.1:11157

$BINARY tx bank send relayer $VALIDATOR 1ucre --home $VHOME --node $CRE_NODE -y

$BINARY q bank balances $RELAYER --node $CRE_NODE
$BINARY q bank balances $VALIDATOR --node $CRE_NODE
