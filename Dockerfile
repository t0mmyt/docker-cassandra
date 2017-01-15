FROM t0mmyt/jre8:latest
MAINTAINER Tom Taylor <tom+dockerfiles@tomm.yt>

EXPOSE 9042 9160

ENV VER=3.9
ENV URL=http://mirror.ox.ac.uk/sites/rsync.apache.org/cassandra/${VER}/apache-cassandra-${VER}-bin.tar.gz
ENV DUMB_INIT=https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64
ENV CASSANDRA_HOME=/opt/apache-cassandra-${VER}/

RUN curl -Ls ${URL} | tar zx -C /opt && \
    curl -Ls ${DUMB_INIT} > /dumb-init && chmod 755 /dumb-init && \
    mkdir ${CASSANDRA_HOME}/data && \
    apt-get -yqq install gettext-base

COPY jvm.options cassandra.yaml.envsubst ${CASSANDRA_HOME}/conf/
COPY go.sh /

WORKDIR ${CASSANDRA_HOME}
ENTRYPOINT ["/dumb-init", "/go.sh"]
