go install github.com/go-delve/delve/cmd/dlv@latest
dlv attach $(pgrep crescentd) /home/ubuntu/goApps/bin/crescentd --headless --api-version=2 --listen=0.0.0.0:9000
