#!/bin/bash

ip=$1
prefix=$2
for data_size in 32 128 256 512 1024; do
	for i in {1..5}; do
		memtier_benchmark -s $ip  -p 6379 -R -d $data_size --key-maximum=1000000 -n 10000  --ratio=1:0 | grep Totals>>${prefix}_${data_size}
	done
	sleep 1
done
