#!/bin/bash
set -e

export LISTEN=$(hostname -I)
envsubst <${CASSANDRA_HOME}/conf/cassandra.yaml.envsubst \
  >${CASSANDRA_HOME}/conf/cassandra.yaml
exec bin/cassandra -f
