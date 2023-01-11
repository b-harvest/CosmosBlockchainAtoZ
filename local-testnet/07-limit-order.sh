crescentd config keyring-backend test

crescentd tx liquidity limit-order 1 buy 100000000ubcre ucre 0.91 19000000 --order-lifespan=10m --from relayer
crescentd tx liquidity limit-order 1 buy 100000000ubcre ucre 1.0 19000000 --order-lifespan=10m --from relayer
crescentd q tx <Txhash>
crescentd q liquidity orders --pair-id 1 


crescentd tx liquidity cancel-order 1 21 --from relayer
