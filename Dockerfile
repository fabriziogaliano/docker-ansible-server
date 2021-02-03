FROM ubuntu:16.04

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt-get update
RUN apt-get install software-properties-common curl -y
RUN apt-get install ansible vim python-pip pssh gettext-base -y

# install GCP SDK and Kubectl
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get install apt-transport-https ca-certificates gnupg -y
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN pip install --upgrade pip
RUN apt-get update && apt-get install google-cloud-sdk kubectl -y
RUN apt-get clean

#RUN pip install requests google-auth

COPY ./docker /docker
RUN mv /docker/config/ansible.cfg /etc/ansible/ansible.cfg
COPY ./ssh /root/.ssh
