FROM ubuntu:24.04

RUN apt-get update
# RUN DEBIAN_FRONTEND=noninteractive apt install -yqq \
#                     software-properties-common
RUN DEBIAN_FRONTEND=noninteractive apt install -yqq \
                    ansible-core=2.16.3-0ubuntu2 \
                    vim \
                    python3-pip \
                    python3-full \
                    pssh \
                    gettext-base \
                    curl \
                    mariadb-client=1:10.11.8-0ubuntu0.24.04.1

# install GCP SDK and Kubectl
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get install apt-transport-https ca-certificates gnupg -y
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN python3 -m venv /home/ubuntu/python
RUN /home/ubuntu/python/bin/python3 /home/ubuntu/python/bin/pip3 install --upgrade pip
RUN /home/ubuntu/python/bin/python3 /home/ubuntu/python/bin/pip3 install PyMySQL
RUN apt-get update && apt-get install google-cloud-sdk kubectl -y
RUN apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}

COPY ./docker /docker
RUN mkdir /etc/ansible/
RUN mv /docker/config/ansible.cfg /etc/ansible/ansible.cfg
COPY ./ssh /root/.ssh

### ADDON Andible
RUN ansible-galaxy collection install community.mysql --force
