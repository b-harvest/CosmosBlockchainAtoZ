
# CONFIGURATION
WORK_DIR=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/private-testnet/
CONFIG=$WORK_DIR/config-private.toml
MNENOMIC=$WORK_DIR//CosmosBlockchainAtoZ/ibc-relayer-operations/private-testnet/RELAYER_MNEMONIC

KEY_A=crescent
CHAIN_A=local-mooncat
KEY_FILE_A=$WORK_DIR/relayer-local-mooncat.key

KEY_B=gaia
CHAIN_B=local-gaia
KEY_FILE_B=$WORK_DIR/relayer-local-gaia.key

# Add keys 
hermes --config $CONFIG keys add --file $KEY_FILE_A --name $KEY_A $CHAIN_A 
hermes --config $CONFIG keys add --file $KEY_FILE_B --name $KEY_B $CHAIN_B

ls $HOME/.hermes/keys


# Start hermes in Terminal 1
WORK_DIR=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/private-testnet/
CONFIG=$WORK_DIR/config-private.toml
hermes --config $CONFIG start


# Create new channel (with client and connection - automatically created)
#  hermes create channel [OPTIONS] --port-a <PORT_A> --port-b <PORT_B> <CHAIN_A> [CONNECTION_A]
hermes --config $CONFIG create channel --port-a transfer --port-b transfer --order unordered --new-client-connection $CHAIN_A --chain-b $CHAIN_B


# Check ibc client list
hermes --config $CONFIG query clients $CHAIN_A --src-chain-id $CHAIN_B
hermes --config $CONFIG query clients $CHAIN_B --src-chain-id $CHAIN_A


# Listen chain ibc events
hermes --config $CONFIG listen  $CHAIN_A
hermes --config $CONFIG listen  $CHAIN_B


# Check client status and counterparty chain

CLIENT_A=0
hermes --config $CONFIG query client state $CHAIN_A 07-tendermint-$CLIENT_A

CLIENT_B=0
hermes --config $CONFIG query client state $CHAIN_B 07-tendermint-$CLIENT_B


# Get details of channel ends
CHAIN=$CHAIN_A
CLIENT=$CLIENT_A
CONN=$(hermes --config $CONFIG query client connections $CHAIN 07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
echo $CONN
CHAN=$(hermes --config $CONFIG query connection channels $CHAIN  connection-$CONN | grep - | sed 's/[^0-9]//g')
echo $CHAN
hermes --config $CONFIG query channel ends $CHAIN  transfer channel-$CHAN


# get counterparty client, connection
CONN=$(hermes --config $CONFIG query client connections $CHAIN 07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
hermes --config $CONFIG query connection end $CHAIN connection-$CONN


# get channel
CONN=$(hermes --config $CONFIG query client connections $CHAIN07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
hermes --config $CONFIG query connection channels $CHAIN connection-$CONN


# Get Pending Packets
CHAN=0
hermes --config $CONFIG query packet pending $CHAIN transfer channel-$CHAN
hermes --config $CONFIG query packet commitments $CHAIN transfer channel-$CHAN

SEQ=7
hermes --config $CONFIG query packet commitment $CHAIN transfer channel-$CHAN $SEQ
hermes --config $CONFIG query packet acks $CHAIN transfer channel-$CHAN
hermes --config $CONFIG query packet ack $CHAIN transfer channel-$CHAN $SEQ

hermes --config $CONFIG query packet pending-sends $CHAIN transfer channel-$CHAN
hermes --config $CONFIG query packet pending-acks $CHAIN transfer channel-$CHAN


# Update Client
hermes --config $CONFIG update client $CHAIN_A 07-tendermint-$CLIENT_A
hermes --config $CONFIG update client $CHAIN_B 07-tendermint-$CLIENT_B


# Clear Packet
## CRESCENT
CHANNEL_A=channel-0
hermes --config $CONFIG clear packets $CHAIN_A transfer $CHANNEL_A

## GAIA
CHANNEL_A=channel-0
hermes --config $CONFIG clear packets $CHAIN_B transfer $CHANNEL_A

