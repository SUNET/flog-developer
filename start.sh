#!/bin/sh

if [ ! -f flog-dev/compose.yml ]; then
    echo "Run $0 from the eduid-developer top level directory"
    exit 1
fi

#
# Set up entrys in /etc/hosts for the containers with externally accessible services
#
(printf "172.16.27.100\tnginx.flog_dev nginx.flog.docker\n
         172.16.27.150\tmemcached.flog_dev memcached.flog.docker\n;
         172.16.27.200\tdb.flog_dev db.flog.docker\n";
) \
    | while read line; do
    if ! grep -q "^${line}$" /etc/hosts; then
	echo "$0: Adding line '${line}' to /etc/hosts"
	if [ "x`whoami`" = "xroot" ]; then
	    echo "${line}" >> /etc/hosts
	else
	    echo "${line}" | sudo tee -a /etc/hosts
	fi
    else
	echo "Line '${line}' already in /etc/hosts"
    fi
done

./bin/docker-compose -f flog-dev/compose.yml rm -f --all
./bin/docker-compose -f flog-dev/compose.yml up $*
