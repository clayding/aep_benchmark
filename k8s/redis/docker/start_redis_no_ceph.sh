#!/bin/bash

pba=$1

redis_run() {
        conf_file=/etc/redis/redis.conf

	sed -i "s/^protected-mode.*/protected-mode no/g" $conf_file
	sed -i "s/^bind.*/#&/g" $conf_file
	sed -i "s/^dir.*/&$port\//g" $conf_file
	sed -i "/nvm/d;/pointer/d" $conf_file
        if [ "$pba" = "yes" ] || [ "$pba" = "no" ]; then 
		sed -i "s/^appendonly.*/appendonly yes/g" $conf_file
		sed -i "s/^appendfsync.*/appendfsync always/g" $conf_file
        fi
	
	if [ "$pba" == "yes" ]; then
		sed -i '$a\nvm-maxcapacity 1' $conf_file
		sed -i '$a\nvm-dir \/data' $conf_file
		sed -i '$a\nvm-threshold 64' $conf_file
		sed -i '$a\pointer-based-aof yes' $conf_file
		touch /data/redis-port-6379-1GB-AEP
		dd if=/dev/zero of=/data/redis-port-6379-1GB-AEP bs=1024k count=1024 >/dev/null 2>&1
	fi
	/usr/local/bin/redis-server /etc/redis/redis.conf
}

redis_run
