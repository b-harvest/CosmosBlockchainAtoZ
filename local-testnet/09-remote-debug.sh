go install github.com/go-delve/delve/cmd/dlv@latest
dlv attach $(pgrep crescentd) $HOME/goApps/bin/crescentd --headless --api-version=2 --listen=0.0.0.0:12345

dlv debug . --headless --api-version=2 --listen=0.0.0.0:12345 -- start --home $HOME/local-mooncat 