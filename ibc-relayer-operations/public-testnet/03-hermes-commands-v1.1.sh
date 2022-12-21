
# CONFIGURATION
CONFIG=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/config-public.toml
MNENOMIC=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/RELAYER_MNEMONIC

KEY_A=crescent
CHAIN_A=mooncat-2-external

KEY_B=gaia
CHAIN_B=theta-testnet-001


# Add keys 
hermes --config $CONFIG keys add --chain $CHAIN_A --mnemonic-file $MNENOMIC --key-name $KEY_A
hermes --config $CONFIG keys add --chain $CHAIN_B --mnemonic-file $MNENOMIC --key-name $KEY_B
ls $HOME/.hermes/keys



# Start hermes in Terminal 1
CONFIG=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/config-public.toml
hermes --config $CONFIG start


# Open Terminal 2 to test the commands below
# Listen chain ibc events
hermes --config $CONFIG listen  --chain $CHAIN_A
hermes --config $CONFIG listen  --chain $CHAIN_B


# Check ibc client list
hermes --config $CONFIG query clients --host-chain $CHAIN_A --reference-chain $CHAIN_B


# Check client status and counterparty chain
CLIENT_A=28
hermes --config $CONFIG query client state --chain $CHAIN_A --client 07-tendermint-$CLIENT_A

CLIENT_B=1410
hermes --config $CONFIG query client state --chain $CHAIN_B --client 07-tendermint-$CLIENT_B


# Get details of channel ends
CHAIN=$CHAIN_A
CLIENT=$CLIENT_A
CONN=$(hermes --config $CONFIG query client connections --chain $CHAIN --client 07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
echo $CONN
CHAN=$(hermes --config $CONFIG query connection channels --chain $CHAIN --connection connection-$CONN | grep - | sed 's/[^0-9]//g')
echo $CHAN
hermes --config $CONFIG query channel ends --chain $CHAIN --port transfer --channel channel-$CHAN


# Get counterparty client, connection
CONN=$(hermes --config $CONFIG query client connections --chain $CHAIN --client 07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
hermes --config $CONFIG query connection end --chain $CHAIN --connection connection-$CONN


# Get channels
CONN=$(hermes --config $CONFIG query client connections --chain $CHAIN --client 07-tendermint-$CLIENT | grep - | sed 's/[^0-9]//g')
hermes --config $CONFIG query connection channels --chain $CHAIN --connection connection-$CONN


# Get Pending Packets
CHAN=25
hermes --config $CONFIG query packet pending --chain $CHAIN --port transfer --channel channel-$CHAN
hermes --config $CONFIG query packet commitments --chain $CHAIN --port transfer --channel channel-$CHAN

SEQ=1
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
CHANNEL_A=channel-25
hermes --config $CONFIG clear packets --chain $CHAIN_A --port transfer --channel $CHANNEL_A

## GAIA
CHANNEL_A=channel-1286
hermes --config $CONFIG clear packets --chain $CHAIN_B --port transfer --channel $CHANNEL_A
