FROM centos:centos8

ARG http_proxy
ARG https_proxy

ENV PUPPET_VERSION="5.5.21" \
    PATH=$PATH:/opt/puppetlabs/puppet/bin

# Required for che
ADD https://raw.githubusercontent.com/disaster37/che-scripts/master/centos.sh /tmp/centos.sh
RUN sh /tmp/centos.sh
    
# Ruby
RUN \
    yum -y install ruby

# Clean image
RUN \
    yum clean all &&\
    rm -rf /tmp/*

WORKDIR "/projects"

CMD ["sleep", "infinity"]
