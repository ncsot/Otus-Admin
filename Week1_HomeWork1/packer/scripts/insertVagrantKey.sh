#!/bin/bash
echo "********************************************"
echo "START PROVISIONS SCRIPT 'insertVagrantKey.sh'"
echo "********************************************"
# Install vagrant default key
mkdir -pm 700 /home/vagrant/.ssh || echo "mkdir FAILED $? is suppressed"
curl -sL https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -o /home/vagrant/.ssh/authorized_keys || echo "curl FAILED $?"
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh && ls -la /home/vagrant
echo "LS HOME DIRECTORY"
echo "********************************************"
echo "END PROVISIONS SCRIPT 'insertVagrantKey.sh'"
echo "********************************************"