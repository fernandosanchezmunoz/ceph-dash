FROM ubuntu:xenial

USER root

#install dependencies including librados for python (experimental, downloaded - this forces to amd64 arch)
RUN apt-get update &&\
  apt-get install -y git nginx python python-flask librados2 python-ceph python-pip iputils-ping netcat dnsutils && \
  pip install --upgrade pip jsonschema flask
#RUN apt-get install -y python-influxdb #not working yet

#avoid werkzeug complaining about broken filesystem
ENV PYTHONIOENCODING="utf-8"

#clone the repo
RUN git clone http://github.com/fernandosanchezmunoz/ceph-dash

WORKDIR ceph-dash

#add spartan to resolv.conf to leverage DC/OS names
RUN echo "nameserver 198.51.100.1 > /etc/resolv.conf"

ADD run.sh run.sh

CMD ./run.sh
