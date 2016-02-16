#! /bin/bash
#
# bootstrap.sh
# Copyright (C) 2016 czesiek <czesiek@czystek>
#
# Distributed under terms of the MIT license.
#

RASPI_USERNAME="pi"
RASPI_HOST="10.0.0.10"
SSH_OPTS="-o PreferredAuthentications=password -o PubkeyAuthentication=no"

ssh-keygen -t rsa -N "" -f ./raspi_ssh_key
echo "Enter RaspberryPi user password"
echo "Hint: default password is 'raspberry'"
ssh-copy-id -i ./raspi_ssh_key.pub \
    -o PreferredAuthentications=password -o PubkeyAuthentication=no \
    ${RASPI_USERNAME}@${RASPI_HOST}

ssh \ #-i ./raspi_ssh_key  \
    ${RASPI_USERNAME}@${RASPI_HOST} \
    mkdir /tmp/raspi_bootstrap
scp \ #-i ./raspi_ssh_key \
    ./dnl-mpg321 \
    ${RASPI_USERNAME}@${RASPI_HOST}:/tmp/raspi_bootstrap/
scp \ #-i ./raspi_ssh_key \
    ./dnl-python-dev \
    ${RASPI_USERNAME}@${RASPI_HOST}:/tmp/raspi_bootstrap/
scp \ #-i ./raspi_ssh_key \
    ./dnl-python-pygame \
    ${RASPI_USERNAME}@${RASPI_HOST}:/tmp/raspi_bootstrap/
ssh \ #-i ./raspi_ssh_key \
    ${RASPI_USERNAME}@${RASPI_HOST} \
    'sudo cp -r /tmp/raspi_bootstrap/* /var/cache/apt/archives/'
ssh \ #-i ./raspi_ssh_key \
    ${RASPI_USERNAME}@${RASPI_HOST} \
    sudo apt-get install \
    mpg321 python-dev python-pygame
# TODO: automate with --print-uris, download on the host
# TODO: or fix routing, maybe?

#copy evdev tarball 
# sudo python setup.py install
# TODO: `pip install --download /dir/` on host and `pip install --no-index --find-links /dir/` on RasPi

#rm ./raspi_ssh_key ./raspi_ssh_key.pub
