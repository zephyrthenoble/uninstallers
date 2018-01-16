#!/bin/bash
apt-get purge $(dpkg -l | grep postgres | cut -f2); sudo apt-get autoremove;
rm -r /etc/postgresql/
rm -r /etc/postgresql-common/
rm -r /var/lib/postgresql/
userdel -r postgres
groupdel postgres
