FROM centos:centos8

ARG http_proxy
ARG https_proxy

# Require for CHE
# Change permissions to let any arbitrary user
ENV HOME=/home/theia
RUN mkdir /projects ${HOME} && \
    for f in "${HOME}" "/etc/passwd" "/projects"; do \
      echo "Changing permissions on ${f}" && chgrp -R 0 ${f} && \
      chmod -R g+rwX ${f}; \
    done
ADD etc/entrypoint.sh /entrypoint.sh
    
# Ruby
RUN \
    yum -y install ruby

# Clean image
RUN \
    yum clean all &&\
    rm -rf /tmp/*

WORKDIR "/projects"

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ${PLUGIN_REMOTE_ENDPOINT_EXECUTABLE}
