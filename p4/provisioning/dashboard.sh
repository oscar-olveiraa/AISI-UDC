#!/bin/bash

try_forwarding() {
	killall kubectl &> /dev/null
	sleep 5
	nohup kubectl port-forward --address 0.0.0.0 -n kubernetes-dashboard svc/kubernetes-dashboard-kong-proxy 8443:443 > /vagrant/provisioning/dashboard.out 2>&1 &
	sleep 1
}

if [[ $HOSTNAME != *"-master" ]]; then
	sleep 1
	exit
fi

try_forwarding
PID=`pidof kubectl`

if [[ ! -z "$PID" ]]; then
    echo PID=$PID
else
    try_forwarding
    PID=`pidof kubectl`
    if [[ ! -z "$PID" ]]; then
        echo PID=$PID
    else
        echo "Port-forwarding failed"
    fi
fi

cat /vagrant/provisioning/dashboard.out
