FROM ubuntu:20.04

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        build-essential \
        libssl-dev \
        libffi-dev \
        python-dev \
        python3-pip \
        git \
        wget \
        curl \
        tree \
        gawk \
        jq \
        iputils-ping \
        unzip \
        ssh \
        sshpass

# Install python packages for ansible
RUN pip3 install \
        paramiko \
        jmespath \
        pyvmomi

# Install ansible
ENV ANSIBLE_VERSION=6.3.0
RUN pip3 install ansible==${ANSIBLE_VERSION}

# Install ansible collection for cisco datacenter
RUN ansible-galaxy collection install \
        cisco.aci:==2.2.0 \ 
        cisco.dcnm:==2.1.1 \
        cisco.intersight:==1.0.19 \
        cisco.ios:==3.3.0 \
        cisco.iosxr:==3.3.0 \
        cisco.mso:==2.0.0 \
        cisco.nso:==1.0.3 \
        cisco.nxos:==3.1.0 \
        cisco.ucs:==1.8.0 \
        community.general:==5.5.0

        

# RUN echo "Installing common utils >>> " \
#     && apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends \
#         python3 python3-pip python3-setuptools \
#         wget curl tree git gawk jq iputils-ping unzip ssh sshpass \
#     && ln -s /usr/bin/python3 /usr/bin/python

# # MS Excel file handler - openpyxl, pandas
# # Ansible json_query - jmespath
# RUN echo "Installing python packages >>> " \ 
#     && pip3 install \
#         openpyxl pandas \
#         jmespath \
#         paramiko \
#         python-gitlab \
#         pyvmomi

ENV TERRAFORM_VERSION=1.2.8
RUN curl -sSL -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip 2>&1 \
    && unzip -d /usr/bin /tmp/terraform.zip \
    && chmod +x /usr/bin/terraform \
    && mkdir -p /root/.terraform.cache/plugin-cache \
    && rm -f /tmp/terraform.zip \
    && terraform -install-autocomplete

# ENV VERSION_ANSIBLE=5.6.0
# RUN echo "Installing Ansible ${VERSION_ANSIBLE} >>> " \
#     && pip3 install --no-cache-dir ansible==${VERSION_ANSIBLE}

# # Terraform Provider - CiscoDevNet/aci
# ENV VERSION_TF_PROVIDER_ACI=2.1.0
# RUN echo "Installing Terraform Provider: Cisco ACI ${VERSION_TF_PROVIDER_ACI} >>> " \
#     && curl -sSL -o /tmp/tf_aci.zip https://releases.hashicorp.com/terraform-provider-aci/${VERSION_TF_PROVIDER_ACI}/terraform-provider-aci_${VERSION_TF_PROVIDER_ACI}_linux_amd64.zip 2>&1 \
#     && mkdir -p /root/.terraform.d/plugins/registry.terraform.io/ciscodevnet/aci/${VERSION_TF_PROVIDER_ACI}/linux_amd64 \
#     && unzip -d /root/.terraform.d/plugins/registry.terraform.io/ciscodevnet/aci/${VERSION_TF_PROVIDER_ACI}/linux_amd64 /tmp/tf_aci.zip \
#     && rm -f /tmp/tf_aci.zip

# # Ansible Collections
# ENV VERSION_ANSIBLE_ACI=2.1.0
# RUN echo "Installing Ansible collections >>> " \ 
#     && ansible-galaxy collection install \
#         cisco.aci:==${VERSION_ANSIBLE_ACI} \
#         community.docker \
#         community.general  

# RUN mkdir /etc/ansible
# COPY files/ansible/ansible.cfg /etc/ansible/ansible.cfg
# COPY files/ansible/hosts /etc/ansible/hosts

# # kubuctl
# RUN echo "Installing kubectl >>> " \
#     && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
#     && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# # helm
# RUN echo "Installing Helm >>> " \
#     && apt-get install apt-transport-https gnupg --yes \
#     && curl https://baltocdn.com/helm/signing.asc | apt-key add - \
#     && echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
#     && apt-get update \
#     && apt-get install helm --yes

# # RUN ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
# # RUN echo "" > passwd 

# # RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/" /etc/ssh/sshd_config
# # RUN echo "Installing sshd --> " \
# #     && apt update \
# #     && apt-get install openssh-server --yes

# # ENV VAULT_VERSION=1.9.2
# # RUN wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -O /tmp/vault.zip \
# #     && unzip -d /usr/bin/ /tmp/vault.zip && rm -f /tmp/vault.zip && chmod +x /usr/bin/vault

# ENV VERSION_CONCOURSE=7.7.1
# RUN echo "Installing Concourse CLI - fly >>>" \ 
#     && curl -sSL -o - https://github.com/concourse/concourse/releases/download/v${VERSION_CONCOURSE}/fly-${VERSION_CONCOURSE}-linux-amd64.tgz 2>&1 | tar xvfz - -C /tmp \
#     && mv /tmp/fly /usr/bin/fly \
#     && chmod a+x /usr/bin/fly

# RUN mv /etc/ssl/openssl.cnf /etc/ssl/openssl.cnf.bak
# COPY files/openssl.cnf /etc/ssl/openssl.cnf