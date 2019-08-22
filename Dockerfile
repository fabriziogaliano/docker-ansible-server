FROM ubuntu:16.04

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-get install ansible vim python-pip pssh gettext-base -y
RUN apt-get clean

RUN pip install requests google-auth

COPY ./docker /docker
RUN mv /docker/config/ansible.cfg /etc/ansible/ansible.cfg
COPY ./ssh /root/.ssh
