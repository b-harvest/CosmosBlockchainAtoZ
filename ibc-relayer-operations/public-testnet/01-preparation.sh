# git clone hands-on repo to $HOME directory
cd $HOME
git clone https://github.com/b-harvest/CosmosBlockchainAtoZ.git


# get an wallet address for Crescent and its mnemonic
crescentd keys add relayer --keyring-backend test 

## Example
## > Crescent Wallet : cre16wvs22rq5lg4vktxdte3zvqerswf5m65pkg3r2
## > Relayer Mnemonic : extend caution mushroom hobby yard pelican couple scout broccoli shiver emotion once recycle able picture tiny illegal aunt wine demise target video canvas find



# get a wallet address for Cosmso with the mnemonic above (the one you created, NOT the example)
gaiad keys add relayer --keyring-backend test --recover

## Example
## > Cosmos Wallet : cosmos16wvs22rq5lg4vktxdte3zvqerswf5m6597m5k8



# Save the relayer mnemonic to RELAYER_MNEMONIC file
echo "<the relayer mnemonic - 24 words>" > RELAYER_MNEMONIC

## Example
## > echo "extend caution mushroom hobby yard pelican couple scout broccoli shiver emotion once recycle able picture tiny illegal aunt wine demise target video canvas find" > RELAYER_MNEMONIC



# Use the faucet to receive coins 

## Crescent Testent
## Faucet : https://testnet-faucet.crescent.network
## > crescentd tx bank send <wallet-name> <receiver-address> 1000000ucre  --node tcp://51.195.63.75:16657
## > crescentd q bank balances  <your crescent realyer address>  --node tcp://51.195.63.75:16657
## > crescentd q bank balances  cre16wvs22rq5lg4vktxdte3zvqerswf5m65pkg3r2  --node tcp://51.195.63.75:16657

## Cosmos Testnet
## Faucet : #testnet-faucet  - https://discord.com/invite/cosmosnetwork
## > gaiad tx bank send <wallet-name> <receiver-address> 1000000uatom  --node tcp://51.195.63.75:26657 --keyring-backend test --chain-id theta-testnet-001
## > gaiad q bank balances  <your crescent realyer address>  --node tcp://51.195.63.75:26657
## > gaiad q bank balances  cre16wvs22rq5lg4vktxdte3zvqerswf5m65pkg3r2  --node tcp://51.195.63.75:26657


