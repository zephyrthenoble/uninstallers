#!/bin/bash
## from https://stackoverflow.com/questions/13390775/how-can-i-reinstall-a-cassandra-on-ubuntu
# Stop services
/etc/init.d/cassandra stop
/etc/init.d/dse stop
/etc/init.d/opscenter-agent stop

# Remove packages
PACKAGES=(dsc dsc1.1 dsc12 dsc20 cassandra apache-cassandra1 dsc-demos \
dse dse-libhadoop-native dse-libhadoop dse-libcassandra dse-hive dse-libhive dse-pig \
dse-libpig dse-demos dse-libsqoop dse-libtomcat dse-liblog4j dse-libsolr dse-libmahout dse-full)
DEB_PACKAGES=(python-cql python-thrift-basic)
RPM_PACKAGES=(python26-cql python26-thrift)
if [ `which dpkg` ]; then
PLIST=(${PACKAGES[@]} ${DEB_PACKAGES[@]})
dpkg -P ${PLIST[*]}
rm -rf /etc/apt/sources.list.d/datastax.list
else
PLIST=(${PACKAGES[@]} ${RPM_PACKAGES[@]})
yum -y remove ${PLIST[*]}
rm -rf  /etc/yum.repos.d/datastax.repo
fi

# Cleanup log and configuration files
rm -rf /var/lib/cassandra/* /var/log/{cassandra,hadoop,hive,pig}/* /etc/{cassandra,dse}/* \
/usr/share/{dse,dse-demos} /etc/default/{dse,cassandra}
