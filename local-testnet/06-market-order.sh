crescentd query liquidity orders --pair-id 1 | jq . | grep \"id\"

crescentd q  liquidity order-books 1 --num-ticks=2 | jq .


cre1pjelxr9745772tfpma4jzllvrw4xqx9j704j6l

crescentd query liquidity pairs  | jq .
crescentd query liquidity pools  | jq .
crescentd query liquidity params | jq .


crescentd tx liquidity mm-order [pair-id] [max-sell-price] [min-sell-price] [sell-amount] [max-buy-price] [min-buy-price] [buy-amount] [flags]

WALLET=relayer
crescentd tx liquidity mm-order 1 1.1 1.0 100000000 1.0 0.9 100000000 --home $VHOME --from $WALLET -y --gas auto --fees 2000ucre --order-lifespan=10m

crescentd query liquidity orders --pair-id=1 -o json | jq .
crescentd query liquidity orders --pair-id=1 -o json | jq . | grep \"id\"

crescentd tx liquidity mm-order 1 1.1 1.0 10000000 1.0 0.9 10000000 --home $VHOME --from $WALLET -y --gas auto --fees 2000ucre --order-lifespan=1m



# Tester
cd $HOME
git clone https://github.com/b-harvest/modules-test-tool.git
cd modules-test-tool
git checkout mm-order
make install

tester mm-order 1 1.05 0.99 10000000 1.01 0.95 10000000 10 20


http://3.38.23.155:8080/
http://3.39.12.247:8080/

go tool trace -http 0.0.0.0:8080 trace.out
go tool pprof -http 0.0.0.0:8080 goroutine.pprof
go tool pprof -http 0.0.0.0:8080 mem.pprof


sudo apt-get -y install graphviz


