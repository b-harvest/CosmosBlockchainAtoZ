
VHOME=$HOME/local-mooncat

# Create a pair
BASE="ucre"
QUOTE="ubcre"
crescentd tx liquidity create-pair $BASE $QUOTE \
--from validator  \
--chain-id local-mooncat -b block \
--fees 3000ucre \
--home $VHOME -y

crescentd q liquidity pairs


# Create a pool 
BASE=10000000000ucre
QUOTE=10000000000ubcre

PAIRID=1
MINPRICE=0.9
MAXPRICE=1.1
INITPRICE=1
CHAINID=local-mooncat

crescentd tx liquidity create-ranged-pool $PAIRID $BASE,$QUOTE $MINPRICE $MAXPRICE $INITPRICE \
--from validator \
--chain-id $CHAINID -b block \
--fees 3000ucre --home $VHOME


# Deposit

BASE=10000000ucre
QUOTE=10000000ubcre
POOLID=1
CHAINID=local-mooncat

crescentd tx liquidity deposit $POOLID $BASE,$QUOTE \
--from validator \
--chain-id $CHAINID -b block \
--fees 3000ucre --home $CHOME -y


# Swap to initiate last price
PAIRID=1
DIRECTION=buy
OFFER_COIN=11000000ucre
DEMAND_COIN_DENOM=ubcre
PRICE=1.09
AMOUNT=9100000
WALLET=rly
FEE=2000ucre

crescentd tx liquidity limit-order $PAIRID $DIRECTION $OFFER_COIN $DEMAND_COIN_DENOM $PRICE $AMOUNT --from $WALLET --fees $FEE --home $CHOME -y   --order-lifespan=1m

crescentd query liquidity orders --pair-id 1 | jq . | grep \"id\"

crescentd q  liquidity order-books 1 --num-ticks=2 | jq .
