FROM ubuntu:20.04

RUN apt-get update
# RUN DEBIAN_FRONTEND=noninteractive apt install -yqq \
#                     software-properties-common
RUN DEBIAN_FRONTEND=noninteractive apt install -yqq \
                    ansible=2.9.6+dfsg-1 \
                    vim \
                    python3-pip \
                    pssh \
                    gettext-base \
                    curl \
                    mariadb-client-10.3

# install GCP SDK and Kubectl
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get install apt-transport-https ca-certificates gnupg -y
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN pip install --upgrade pip
RUN pip install PyMySQL
RUN apt-get update && apt-get install google-cloud-sdk kubectl -y
RUN apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}

#RUN pip install requests google-auth

COPY ./docker /docker
RUN mv /docker/config/ansible.cfg /etc/ansible/ansible.cfg
COPY ./ssh /root/.ssh

### ADDON Andible
RUN ansible-galaxy collection install community.mysql
