# Configuration
CONFIG=$HOME/CosmosBlockchainAtoZ/local-testnet/config-private.toml
MNENOMIC=$HOME/CosmosBlockchainAtoZ/local-testnet/MNEMONIC_RELAYER

KEY_A=local-mooncat
CHAIN_A=local-mooncat

KEY_B=local-gaia
CHAIN_B=local-gaia



# Send token : Crescent -> Cosmos
CRE_NODE=tcp://127.0.0.1:11157
GAIA_NODE=tcp://127.0.0.1:11257

COSMOS_ADDRESS=cosmos16wvs22rq5lg4vktxdte3zvqerswf5m6597m5k8
AMOUNT=1000ucre
FEE=25ucre
CHANNEL=channel-0
SENDER_CHAIN=$CHAIN_A
WALLET=relayer

crescentd tx ibc-transfer transfer transfer $CHANNEL $COSMOS_ADDRESS $AMOUNT --from $WALLET --keyring-backend test --chain-id $SENDER_CHAIN --gas auto --fees $FEE --node $CRE_NODE -y 

gaiad q bank balances cosmos16wvs22rq5lg4vktxdte3zvqerswf5m6597m5k8 --node $GAIA_NODE 
## Example
## crescentd q tx --type=hash <hash of above tx> --node $CRE_NODE 
## crescentd q tx --type=hash 8E8673184015DC37D61CCCA4E53B02B834723153227B8C20391DF6E5021E8019 --node $CRE_NODE 
## gaiad q bank balances cosmos16wvs22rq5lg4vktxdte3zvqerswf5m6597m5k8 --node $GAIA_NODE 


# Send token : Cosmos -> Crescent
CRESCENT_ADDRESS=cre16wvs22rq5lg4vktxdte3zvqerswf5m65pkg3r2
AMOUNT=1000uatom
FEE=250uatom
CHANNEL=channel-0
SENDER_CHAIN=$CHAIN_B
WALLET=relayer

gaiad tx ibc-transfer transfer transfer $CHANNEL $CRESCENT_ADDRESS $AMOUNT --from $WALLET --keyring-backend test --chain-id $SENDER_CHAIN --fees $FEE --gas auto --node $GAIA_NODE -y

crescentd q bank balances cre16wvs22rq5lg4vktxdte3zvqerswf5m65pkg3r2 --node $CRE_NODE 
## Example
## gaiad q tx --type=hash <hash of above tx> --node $GAIA_NODE
## gaiad q tx --type=hash 32673D68CB64FCE081080A4DCBC9EB43468C8314F66266501B81A1E65EB79999 --node $GAIA_NODE
## crescentd q bank balances cre16wvs22rq5lg4vktxdte3zvqerswf5m65pkg3r2 --node $CRE_NODE 


