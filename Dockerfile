FROM ubuntu:latest

ENV TZ=Asia/Tokyo

RUN apt-get update \
 && apt-get install -y \
    git \
    ssh \
    openssh-server \
    locales \
    python3 \
    python3-pip \
    python3.12-venv \
    sudo \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN useradd -m -s /bin/bash ansible \
 && echo "ansible:password" | chpasswd \
 && usermod -aG sudo ansible

RUN mkdir -p /var/run/sshd \
 && mkdir -p /home/ansible/.ssh \
 && chmod 700 /home/ansible/.ssh \
 && chown ansible:ansible /home/ansible/.ssh

RUN mkdir -p /learning_ansible
COPY . /learning_ansible/

RUN python3 -m venv /learning_ansible/venv \
 && /learning_ansible/venv/bin/pip install --upgrade pip \
 && /learning_ansible/venv/bin/pip install -r /learning_ansible/requirements.txt
RUN echo "source /learning_ansible/venv/bin/activate" >> /root/.bashrc \
 && echo "source /learning_ansible/venv/bin/activate" >> /home/ansible/.bashrc \
 && chown ansible:ansible /home/ansible/.bashrc

WORKDIR /learning_ansible

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]