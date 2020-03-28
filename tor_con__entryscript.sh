#!/bin/bash

echo "printing ip through tor every $tor_interval seconds"
external_ip=`curl -s ipinfo.io/ip`
echo "My external IP is: $external_ip"

init='false'
loop=1
max_loop=10

echo "Waiting for Tor server to initialize"

while [[ $init == 'false' && $loop -lt $max_loop ]]; do

    rc=`{ exec 3<>/dev/tcp/tor-socks-proxy/$PORT; } > /dev/null 2>&1`

    if [[ $? -eq 0 ]]; then
       init='true'
    else
       loop=$(($loop + 1))
       sleep 2
    fi

done

if [[ $init == 'false' ]]; then
    echo "Cannot connect to tor-socks-proxy on port ${PORT}, exiting..."
    exit 1
fi

end_time=$((SECONDS+120))
IP_ARR=''

while [ $SECONDS -lt $end_time ]; do

    ip=`curl -s --socks5-hostname tor-socks-proxy:$PORT https://ipinfo.io/ip`
    echo "IP through tor: $ip"
    grep -q $ip <<< ${IP_ARR}

    if [[ $? -eq 0 ]]; then
        echo "duplication of ip through tor found, exiting..."
        exit 1
    else
        IP_ARR=${IP_ARR}:${ip}
        sleep $tor_interval
    fi

done
echo "Ip change through tor every $tor_interval seconds ended successfully"

