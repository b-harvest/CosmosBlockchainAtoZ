
# Configuration
CONFIG=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/config-public.toml
MNEMONIC=$HOME/CosmosBlockchainAtoZ/ibc-relayer-operations/public-testnet/RELAYER_MNEMONIC

KEY_A=crescent
CHAIN_A=mooncat-2-external

KEY_B=gaia
CHAIN_B=theta-testnet-001


# Send token : Crescent -> Cosmos
CRE_NODE=tcp://51.195.63.75:16657
GAIA_NODE=tcp://51.195.63.75:26657

COSMOS_ADDRESS=cosmos19whr7x3yppa79s0grhdfkhc4vrhejtchkkct44
AMOUNT=1000ucre
FEE=25ucre
CHANNEL=channel-25
SENDER_CHAIN=$CHAIN_A
WALLET=relayer

crescentd tx ibc-transfer transfer transfer $CHANNEL $COSMOS_ADDRESS $AMOUNT --from $WALLET --keyring-backend test --chain-id $SENDER_CHAIN --gas auto --fees $FEE --node $CRE_NODE -y 

## Example
## crescentd q tx --type=hash <hash of above tx> --node $CRE_NODE 
## crescentd q tx --type=hash 8E8673184015DC37D61CCCA4E53B02B834723153227B8C20391DF6E5021E8019 --node $CRE_NODE 
## gaiad q bank balances cosmos19whr7x3yppa79s0grhdfkhc4vrhejtchkkct44 --node $GAIA_NODE 
gaiad q bank balances $COSMOS_ADDRESS --node $GAIA_NODE 

# Send token : Cosmos -> Crescent
CRESCENT_ADDRESS=cre19whr7x3yppa79s0grhdfkhc4vrhejtchj7twqc
AMOUNT=1000uatom
FEE=250uatom
CHANNEL=channel-1286
SENDER_CHAIN=$CHAIN_B
WALLET=relayer

gaiad tx ibc-transfer transfer transfer $CHANNEL $CRESCENT_ADDRESS $AMOUNT --from $WALLET --keyring-backend test --chain-id $SENDER_CHAIN --fees $FEE --gas auto --node $GAIA_NODE -y

## Example
## gaiad q tx --type=hash <hash of above tx> --node $GAIA_NODE
## gaiad q tx --type=hash FA487D5B5AAB3B238FECA1AFA742056054A25C606ADEAE9A6B2ACFDA04D72CFF --node $GAIA_NODE
## crescentd q bank balances cre19whr7x3yppa79s0grhdfkhc4vrhejtchj7twqc --node $CRE_NODE 

