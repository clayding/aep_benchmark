#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf
pod_file=$1

function create_pod(){
	kubectl apply -f pmem-CSI/deploy/kubernetes-1.14/pmem-storageclass-ext4.yaml
	kubectl create -f $pod_file
}

function clean_pod(){
	POD=$(kubectl get pod -l app=benchmark -o jsonpath="{.items[0].metadata.name}")
	echo "$POD"
	if [ ! -z "$POD" ]; then
		echo "delete po $POD"
		kubectl delete po $POD
	fi
	kubectl delete pvc pmem-csi-pvc-ext4
}

clean_pod
create_pod
