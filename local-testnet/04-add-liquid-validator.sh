# 
VHOME=$HOME/local-mooncat2

# check current list of liquid validators
crescentd q liquidstaking liquid-validators


# write new whitelist validator info into json
NEW_LSV=$(crescentd keys show validator --bech=val -a --home $VHOME)

cat << EOF | sudo tee >> $HOME/add-liquid-validator.json
{
    "title": "WhitelistedValidators",
    "description": "WhitelistedValidators",
    "changes":
    [
        {
            "subspace": "liquidstaking",
            "key": "WhitelistedValidators",
            "value":
            [
                {
                    "validator_address": "${NEW_LSV}",
                    "target_weight": "1"
                }
            ]
        }
    ],
    "deposit": "500000000ucre"
}
EOF


# Submit proposal and vote
VHOME=$HOME/local-mooncat

crescentd tx gov submit-proposal param-change $HOME/add-liquid-validator.json --from validator --gas 1000000 --fees 10000ucre --home $VHOME -y

crescentd q gov proposals

crescentd tx gov vote 1  yes  --home $VHOME --from validator -y
## Vote then wait until the proposal has passed

# Liquid staking
WALLET=validator
WALLET=relayer
crescentd tx  liquidstaking  liquid-stake 100000000000ucre --from $WALLET --home $VHOME --gas 1000000 --fees 1000ucre -y

crescentd q bank balances $(crescentd keys show $WALLET -a --home $HOME/local-mooncat)

crescentd config node tcp://0.0.0.0:11157
crescentd config chain-id local-mooncat
crescentd config



