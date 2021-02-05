#!/usr/bin/env bash
echo "Hello world!"
#Install Git
yum install git -y
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
yum install nodejs -y
npm install -g @vue/cli

wget -c https://golang.org/dl/go1.15.2.linux-amd64.tar.gz
tar -C /usr/local -xvzf go1.15.2.linux-amd64.tar.gz
mkdir -p ~/go_projects/{bin,src,pkg}
echo 'export  PATH=$PATH:/usr/local/go/bin' >> /etc/profile
echo 'export GOPATH="$HOME/go_projects"' >> /home/vagrant/.bash_profile
echo 'export GOBIN="$GOPATH/bin"' >> /home/vagrant/.bash_profile
source /home/vagrant/.bash_profile

git clone https://github.com/jdmendozaa/vuego-demoapp.git
cd vuego-demoapp/server
go build
echo 'export PORT=4001' >> /etc/profile

cd /
cp /home/vagrant/vuego-demoapp/server/vuego-demoapp /shared/

cd home/vagrant/vuego-demoapp/spa
sudo npm install 
sudo echo 'VUE_APP_API_ENDPOINT="http://10.0.0.8:4001/api"' >> .env.production
npm run build

tar -zcvf dist.tar.gz ./dist
mv dist.tar.gz /shared/
