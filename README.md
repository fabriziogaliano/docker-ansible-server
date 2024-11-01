# docker-ansible-server
[![](https://images.microbadger.com/badges/version/fabriziogaliano/ansible-server.svg)](https://microbadger.com/images/fabriziogaliano/ansible-server "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/fabriziogaliano/ansible-server.svg)](https://microbadger.com/images/fabriziogaliano/ansible-server "Get your own image badge on microbadger.com")

Docker image based on ubuntu 20.04 with Ansible Server preinstalled


## Version

```
v1.4.0 = ansible 2.16.3-0ubuntu2
     - Python3.12
     - Google Cloud SDK 498.0.0
       - alpha 2024.10.18
       - beta 2024.10.18
       - bq 2.1.9
       - core 2024.10.18
       - gcloud-crc32c 1.0.0
       - gsutil 5.31
       - istioctl 1.20.47
     - kubectl 1.30.5

v1.3.1 = ansible-galaxy community.mysql

v1.3 = ansible 2.9.6+dfsg-1
     - Google Cloud SDK 407.0.0
       - alpha 2022.10.21
       - beta 2022.10.21
       - bq 2.0.79
       - bundled-python3-unix 3.9.12
       - core 2022.10.21
       - gcloud-crc32c 1.0.0
       - gsutil 5.15
     - kubectl 1.25.3
     - kustomize 4.5.7

v1.2 = ansible 2.9.17
     - google-cloud-sdk  326.0.0
     - kubectl 1.20.2

v1.1 = ansible 2.8.4
     - google-cloud-sdk null
     - kubectl null
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

#Script tested on Ubuntu 20.04

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
