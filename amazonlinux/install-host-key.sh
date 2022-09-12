#!/bin/bash

docker cp ~/.ssh/id_rsa.pub ec2:/tmp
docker exec -t ec2 /bin/bash -c 'cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys'