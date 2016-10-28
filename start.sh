#!/bin/sh
rm -rf /var/lib/mongodb/mongod.lock
service mongodb start
service redis-server start

cd /var/lib/nodeclub
[ -f config.js ] || (cp config.default.js config.js && make install)

CMD="node app.js"
while :
do
    RESULT=`mongo --eval "1;"`
    echo $RESULT

    if [[ "${RESULT:-null}" == *Failed\ to\ connect* ]]
    then
        echo sleep for 1s...
        sleep 1
    else
        exec $CMD
        break;
    fi
done
