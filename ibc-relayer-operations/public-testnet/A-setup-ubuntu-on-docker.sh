## launch the container
docker run -d -it --platform linux/amd64 --name validator ubuntu:20.04

## get into docker container
docker exec -it validator /bin/bash

## pre-requisite
apt-get update --fix-missing
apt-get -yq dist-upgrade
apt-get install -yq --no-install-recommends make curl git vim build-essential jq wget net-tools sudo ca-certificates

groupadd -g 1000 ubuntu
useradd -m -s /bin/bash -N -u 1000 -g 1000 ubuntu

## nopassword on sudo command
sudo tee /etc/sudoers.d/myOverrides > /dev/null <<'EOF'
ubuntu ALL=(ALL) NOPASSWD:ALL

EOF

sudo passwd ubuntu
su - ubuntu
## increase possible open files
ulimit -n 65535
cat << EOF | sudo tee -a /etc/security/limits.conf
* soft nofile 65535
* hard nofile 65535
EOF


## Go install
GOVERSION=1.18.8
git config --global http.sslVerify false
sudo rm -rf /usr/local/go
wget https://go.dev/dl/go${GOVERSION}.linux-amd64.tar.gz --no-check-certificate

tar -xvf go${GOVERSION}.linux-amd64.tar.gz
sudo mv go /usr/local
mkdir -p ~/goApps/bin

cat << 'EOF' >> ~/.profile
export GOROOT=/usr/local/go
export GOPATH=$HOME/goApps
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
EOF

source ~/.profile
go version
