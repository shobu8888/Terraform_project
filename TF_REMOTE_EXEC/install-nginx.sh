#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
    sleep 1
done

# install nginx
yum update -y
yum -y install nginx

# make sure nginx is started
systemctl start nginx