
# CONFIGURATION
WORK_DIR=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/
CONFIG=$WORK_DIR/config-public.toml
MNENOMIC=$WORK_DIR/RELAYER_MNEMONIC

KEY_A=crescent
CHAIN_A=mooncat-2-external
KEY_FILE_A=$WORK_DIR/crescent.key

KEY_B=gaia
CHAIN_B=theta-testnet-001
KEY_FILE_B=$WORK_DIR/gaia.key

# Add keys 
hermes --config $CONFIG keys add --file $KEY_FILE_A --name $KEY_A $CHAIN_A 
hermes --config $CONFIG keys add --file $KEY_FILE_B --name $KEY_B $CHAIN_B

ls $HOME/.hermes/keys


# Start hermes in Terminal 1
CONFIG=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/config-public.toml
hermes --config $CONFIG start


# Open Terminal 2 to test the commands below
# Listen chain ibc events
hermes --config $CONFIG listen --chain $CHAIN_A
hermes --config $CONFIG listen --chain $CHAIN_B


# Check ibc client list
hermes --config $CONFIG query clients $CHAIN_A --src-chain-id $CHAIN_B


# Check client status and counterparty chain
CLIENT_A=28
hermes --config $CONFIG query client state $CHAIN_A 07-tendermint-$CLIENT_A

CLIENT_B=1410
hermes --config $CONFIG query client state $CHAIN_B 07-tendermint-$CLIENT_B



# Get details of channel ends
CHAIN=$CHAIN_A
CLIENT=$CLIENT_A
CONN=$(hermes --config $CONFIG query client connections $CHAIN 07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
echo $CONN
CHAN=$(hermes --config $CONFIG query connection channels $CHAIN connection-$CONN | grep - | sed 's/[^0-9]//g')
echo $CHAN
hermes --config $CONFIG query channel ends $CHAIN transfer channel-$CHAN


# Get counterparty client, connection
CONN=$(hermes --config $CONFIG query client connections $CHAIN 07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
hermes --config $CONFIG query connection end $CHAIN connection-$CONN



# Get channels
CONN=$(hermes --config $CONFIG query client connections $CHAIN 07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
hermes --config $CONFIG query connection channels  $CHAIN  connection-$CONN


# Get Pending Packets
CHAN=25
hermes --config $CONFIG query packet pending $CHAIN transfer channel-$CHAN
hermes --config $CONFIG query packet commitments $CHAIN transfer channel-$CHAN

SEQ=1
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
CHANNEL_A=channel-25
hermes --config $CONFIG clear packets $CHAIN_A transfer $CHANNEL_A

## GAIA
CHANNEL_A=channel-1286
hermes --config $CONFIG clear packets $CHAIN_B transfer $CHANNEL_A
