#!/bin/bash

# Install ansible and other stuff
dnf clean all
dnf -y --enablerepo=powertools install epel-release wget curl lynx vim nano langpacks-es langpacks-en glibc-all-langpacks
dnf -y --enablerepo=powertools install python3-setuptools ansible
mkdir -p /etc/ansible
cp /vagrant/ansible.cfg /etc/ansible
cp /vagrant/ansible.inventory /etc/ansible/hosts
chmod 0644 /etc/ansible/ansible.cfg
chmod 0644 /etc/ansible/hosts

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

SSH_PUBLIC_KEY=/vagrant/provisioning/id_rsa.pub
USER_DIR=/home/vagrant/.ssh

if [ ! -f $USER_DIR/id_rsa.pub ]; then
	# Create ssh keys
	echo -e 'y\n' | sudo -u vagrant ssh-keygen -t rsa -f $USER_DIR/id_rsa -q -N ''
fi

if [ ! -f $USER_DIR/id_rsa.pub ]; then
	echo "SSH public key could not be created"
	exit -1
fi

chown vagrant:vagrant $USER_DIR/id_rsa*
cp $USER_DIR/id_rsa.pub /vagrant/provisioning

if [ ! -f $SSH_PUBLIC_KEY ]; then
	echo "SSH public key could not be copied"
	exit -1
fi
