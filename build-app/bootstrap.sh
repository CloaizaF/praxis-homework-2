#!/usr/bin/env bash
echo "Hello world!"
#Install Git
yum install git -y
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
#Install Node
yum install nodejs -y
#Install Vue
npm install -g @vue/cli
#Install Go
wget -c https://golang.org/dl/go1.15.2.linux-amd64.tar.gz
tar -C /usr/local -xvzf go1.15.2.linux-amd64.tar.gz
mkdir -p ~/go_projects/{bin,src,pkg}
echo 'export  PATH=$PATH:/usr/local/go/bin' >> /etc/profile
echo 'export GOPATH="$HOME/go_projects"' >> /home/vagrant/.bash_profile
echo 'export GOBIN="$GOPATH/bin"' >> /home/vagrant/.bash_profile
source /home/vagrant/.bash_profile
#Clone the repository
git clone https://github.com/jdmendozaa/vuego-demoapp.git
#Build the Go project
cd vuego-demoapp/server
go build
echo 'export PORT=4001' >> /etc/profile
#Move the Go artifact to the shared dir
cd /
cp /home/vagrant/vuego-demoapp/server/vuego-demoapp /shared/
#Build the Vue app
cd home/vagrant/vuego-demoapp/spa
sudo npm install 
sudo echo 'VUE_APP_API_ENDPOINT="http://10.0.0.8:4001/api"' >> .env.production
npm run build
#Zip the Vue app
tar -zcvf dist.tar.gz ./dist
#Move the Vue app to the shared dir
mv dist.tar.gz /shared/