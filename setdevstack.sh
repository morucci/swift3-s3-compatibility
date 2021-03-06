#!/usr/bin/env bash

# setdevstack.sh - installs devstack with swift3 and needed dependencies for the tests

#-- installing what's needed

sudo aptitude update && sudo aptitude install python-netaddr git

if [ ! -d ./devstack ]; then 
    echo "pulling devstack"
    echo "------------"
    git clone git://github.com/openstack-dev/devstack.git
    cd devstack
else
    echo "Unstacking and updating devstack"
    echo "------------"
    cd devstack && ./unstack.sh 
    git pull
fi

#-- adding a localrc to install the bare minimum

cat > localrc << "EOF"
ADMIN_PASSWORD=ADMIN
KEYSTONE_TOKEN_FORMAT=UUID
ENABLED_SERVICES=key,mysql,swift,swift3
LOGFILE=/tmp/devstack.log
MYSQL_PASSWORD=mysqlpassword
RABBIT_PASSWORD=8112166274b4f0198723
SCREEN_LOGDIR=/tmp/screen-logs
SERVICE_PASSWORD=ADMIN
SERVICE_TOKEN=7f00aa2752e42ff6eead
SWIFT_HASH=8519b430eb14d5983334
SWIFT_REPLICAS=1
EOF

./stack.sh
