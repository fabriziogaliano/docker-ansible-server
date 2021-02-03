# docker-ansible-server
[![](https://images.microbadger.com/badges/version/fabriziogaliano/ansible-server.svg)](https://microbadger.com/images/fabriziogaliano/ansible-server "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/fabriziogaliano/ansible-server.svg)](https://microbadger.com/images/fabriziogaliano/ansible-server "Get your own image badge on microbadger.com")

Docker image based on ubuntu 16.04 with Ansible Server preinstalled


## Version

```
v1.1 = ansible 2.8.4
     - google-cloud-sdk null
     - kubectl null

v1.2 = ansible 2.9.17
     - google-cloud-sdk  326.0.0
     - kubectl 1.20.2
```

## Example

```

docker run --rm -it \
-v "/home/to/docker-ansible-server/playbook:/etc/ansible/playbook" \
-v "/home/to/docker-ansible-server/hosts:/etc/ansible/hosts" \
fabriziogaliano/ansible-server \
bash

```

## Put your own RSA Key

```

Before use Ansible create your own RSA key and copy/mount/build it into container:

Generate RSA Keys pair: ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

Copy id_rsa.pub and id_rsa into container /root/.ssh folder and set the correct permissions:

chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa.pub /root/.ssh/id_rsa

```

## Authorize Ansible Target Host to accept Ansible Server connection

```

#Script tested on Ubuntu 16.04

#!/bin/bash
#Creation of Ansible User
sudo adduser --quiet --home /home/ansible --shell /bin/bash --disabled-password ansible
sudo mkdir -p /home/ansible/.ssh
sudo chmod 700 /home/ansible/.ssh

#Make Ansible User Sudoers
sudo usermod -aG sudo ansible
sudo echo "ansible   ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/000-ansible

#RSA Ansible key
sudo echo "YOUR Ansible RSA PUB KEY HERE" >> /home/ansible/.ssh/authorized_keys
sudo chmod 600 /home/ansible/.ssh/authorized_keys
sudo chown ansible.ansible /home/ansible/ -R

#Install prerequisites tools
sudo apt update && apt install python python-apt -y


```


## Populate your inventory file

```

vim /etc/ansible/hosts

Example: 

### start config file ###

[aws]

host1 ansible_ssh_port=22 ansible_ssh_user=ansible ansible_ssh_host=x.x.x.x

### end config file ###

```

## Execute your Playbook
You can find some playbook already created inside the repo

```

ansible-playbook test

```
