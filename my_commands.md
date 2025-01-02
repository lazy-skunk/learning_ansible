# Frequently Used Commands

## Docker
```
$ docker-compose build --no-cache
$ docker-compose up -d

$ docker-compose stop
$ docker-compose down --rmi all

$ docker volume prune
$ docker volume ls
```

## Python
``` python
$ python3 -m venv venv
$ source venv/bin/activate
```

## sh
``` sh
$ ssh ansible@localhost -p 2222
$ ssh ansible@localhost -p 2223
$ ssh ansible@localhost -p 2224

$ ssh-keygen -t rsa -b 4096 -C "ansible@ansible_control_node"
```

## Ansible
```
ansible-inventory -i inventory.ini --list
ansible myhosts -m ping -i inventory.ini
ansible-playbook -i inventory.ini playbook.yaml
```