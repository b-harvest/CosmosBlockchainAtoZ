
# CONFIGURATION
WORK_DIR=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/private-testnet/
CONFIG=$WORK_DIR/config-private.toml
MNENOMIC=$WORK_DIR/RELAYER_MNEMONIC

KEY_A=crescent
CHAIN_A=local-mooncat

KEY_B=gaia
CHAIN_B=local-gaia


# Add keys 
hermes --config $CONFIG keys add --chain $CHAIN_A --mnemonic-file $MNENOMIC --key-name $KEY_A
hermes --config $CONFIG keys add --chain $CHAIN_B --mnemonic-file $MNENOMIC --key-name $KEY_B
ls $HOME/.hermes/keys


# Terminal 1 : Start hermes in other terminal
CONFIG=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/private-testnet/config-private.toml
hermes --config $CONFIG start


# Create new channel (with client and connection - automatically created)
# This takes several mintues to complete
hermes --config $CONFIG create channel --a-chain $CHAIN_A --b-chain $CHAIN_B --a-port transfer --b-port transfer --order unordered --new-client-connection


# Check ibc client list
hermes --config $CONFIG query clients --host-chain $CHAIN_A --reference-chain $CHAIN_B
hermes --config $CONFIG query clients --host-chain $CHAIN_B --reference-chain $CHAIN_A


# Listen chain ibc events
hermes --config $CONFIG listen  --chain $CHAIN_A
hermes --config $CONFIG listen  --chain $CHAIN_B


# Check client status and counterparty chain

CLIENT_A=0
hermes --config $CONFIG query client state --chain $CHAIN_A --client 07-tendermint-$CLIENT_A

CLIENT_B=0
hermes --config $CONFIG query client state --chain $CHAIN_B --client 07-tendermint-$CLIENT_B


# Get details of channel ends
CHAIN=$CHAIN_A
CLIENT=$CLIENT_A
CONN=$(hermes --config $CONFIG query client connections --chain $CHAIN --client 07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
echo $CONN
CHAN=$(hermes --config $CONFIG query connection channels --chain $CHAIN --connection connection-$CONN | grep - | sed 's/[^0-9]//g')
echo $CHAN
hermes --config $CONFIG query channel ends --chain $CHAIN --port transfer --channel channel-$CHAN


# get counterparty client, connection
CONN=$(hermes --config $CONFIG query client connections --chain $CHAIN --client 07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
hermes --config $CONFIG query connection end --chain $CHAIN --connection connection-$CONN


# get channel
CONN=$(hermes --config $CONFIG query client connections --chain $CHAIN --client 07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
hermes --config $CONFIG query connection channels --chain $CHAIN --connection connection-$CONN


# Get Pending Packets
CHAN=0
hermes --config $CONFIG query packet pending --chain $CHAIN --port transfer --channel channel-$CHAN
hermes --config $CONFIG query packet commitments --chain $CHAIN --port transfer --channel channel-$CHAN

SEQ=7
hermes --config $CONFIG query packet commitment --chain $CHAIN --port transfer --channel channel-$CHAN --sequence $SEQ
hermes --config $CONFIG query packet acks --chain $CHAIN --port transfer --channel channel-$CHAN
hermes --config $CONFIG query packet ack --chain $CHAIN --port transfer --channel channel-$CHAN --sequence $SEQ

hermes --config $CONFIG query packet pending-sends --chain $CHAIN --port transfer --channel channel-$CHAN
hermes --config $CONFIG query packet pending-acks --chain $CHAIN --port transfer --channel channel-$CHAN


# Update Client
hermes --config $CONFIG update client --host-chain $CHAIN_A --client 07-tendermint-$CLIENT_A
hermes --config $CONFIG update client --host-chain $CHAIN_B --client 07-tendermint-$CLIENT_B


# Clear Packet
## CRESCENT
CHANNEL_A=channel-0
hermes --config $CONFIG clear packets --chain $CHAIN_A --port transfer --channel $CHANNEL_A

## GAIA
CHANNEL_A=channel-0
hermes --config $CONFIG clear packets --chain $CHAIN_B --port transfer --channel $CHANNEL_A

