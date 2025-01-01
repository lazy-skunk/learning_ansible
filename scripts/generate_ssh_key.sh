USERNAME=$(whoami)
HOSTNAME=$(hostname)
COMMENT="${USERNAME}@${HOSTNAME}"

ssh-keygen -t rsa -b 4096 -C "${COMMENT}"