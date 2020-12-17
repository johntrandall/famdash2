#!/bin/bash

# see pgsync.yml for configuration

set -e #Flag to stop execution on any bad return code

rake db:drop db:create db:structure:load
redis-cli FLUSHALL;

pgsync
#pgsync bootstrap --fail-fast
#for id in $@
#do
#  pgsync project:$id --fail-fast
#  pgsync project_data:$id --debug --fail-fast
#done

rails db:migrate db:test:prepare
