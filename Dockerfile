FROM rockylinux:9.3

ENV TZ=Asia/Tokyo

RUN yum update -y \
 && yum install -y \
    sudo \
    procps \
    net-tools \
    openssh-server \
    openssh-clients \
    which \
    git \
    python3 \
    python3-pip \
 && yum clean all \
 && rm -rf /var/cache/yum

RUN useradd -m -s /bin/bash ansible \
 && echo "ansible:password" | chpasswd \
 && usermod -aG wheel ansible

RUN ssh-keygen -A

RUN mkdir -p /learning_ansible
WORKDIR /learning_ansible
COPY . /learning_ansible/

RUN python3 -m venv /learning_ansible/venv \
 && /learning_ansible/venv/bin/pip install --upgrade pip \
 && /learning_ansible/venv/bin/pip install -r /learning_ansible/requirements.txt \
 && echo "source /learning_ansible/venv/bin/activate" >> /home/ansible/.bashrc

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]