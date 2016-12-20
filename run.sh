#!/bin/sh
#add config and credentials
mkdir -p /etc/ceph
cp /mnt/mesos/sandbox/ceph.conf /etc/ceph/ceph.conf
cp /mnt/mesos/sandbox/ceph.client.admin.keyring /etc/ceph/ceph.client.admin.keyring
#cp /mnt/mesos/samdbox/ceph.mon.keyring /etc/ceph/ceph.mon.keyring

#remove files from sandbox so that they don't appear on UI
rm -f /mnt/mesos/sandbox/ceph.mon.keyring /mnt/mesos/sandbox/ceph.conf cp /mnt/mesos/sandbox/ceph.client.admin.keyring

#modify listening host and port - just needed if running on HOST mode. BRIDGE mode doesn't need it
#if there's a "vtep" interface we're in host mode.
TEST=$(ip a|grep vtep)
if [ -n "$TEST" ]; then
	sed -i 's/from app import app/from app import app; import os/g' ./ceph-dash.py
	sed -i 's/host='"'"'0.0.0.0'"'"',/host='"'"'0.0.0.0'"'"', port=int(os.environ["PORT0"]), /g' ./ceph-dash.py
fi

python ceph-dash.py
