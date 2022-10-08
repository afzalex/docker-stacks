#!/bin/bash

echo "Installing host ssh keys in docker ec2"
docker cp ~/.ssh/id_rsa.pub ec2:/tmp
docker exec -it ec2 /bin/bash -c 'cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys'
docker exec -it ec2 touch FLAG_HOST_AUTHKEY_INSTALLED