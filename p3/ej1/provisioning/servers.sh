#!/bin/bash

dnf clean all
dnf -y install epel-release python3-setuptools wget curl vim nano langpacks-es

passwd -d root
echo 'root:vagrant' | chpasswd -m
passwd -d vagrant
echo 'vagrant:vagrant' | chpasswd -m

# SSH config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/#KbdInteractiveAuthentication/KbdInteractiveAuthentication/' /etc/ssh/sshd_config
systemctl restart sshd

# Copy ssh public key
SSH_PUBLIC_KEY=/vagrant/provisioning/id_rsa.pub
USER_DIR=/home/vagrant/.ssh

if [ ! -f $SSH_PUBLIC_KEY ]; then
	echo "SSH public key does not exist"
	exit -1
fi

sed -i "/-aisi/d" $USER_DIR/authorized_keys >& /dev/null
cat $SSH_PUBLIC_KEY >> $USER_DIR/authorized_keys
chown vagrant:vagrant $USER_DIR/authorized_keys
chmod 0600 $USER_DIR/authorized_keys

# Configure firewalld for webapp server
if [[ "$HOSTNAME" == *"-web" ]]; then
	firewall-cmd --permanent --add-service=http
fi

# Configure firewalld for database server
if [[ "$HOSTNAME" == *"-db" ]]; then
	firewall-cmd --permanent --add-port=3306/tcp
fi

firewall-cmd --reload
