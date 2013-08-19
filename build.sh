#!/bin/bash

containsElement () {
    for e in "${@:2}";
    do
        if [[ "$e" = "$1" ]] ; then
            return 0;
        fi
    done;
    return 1;
}

buildHost () {
    packer build -var "hostname=$1" template/template.json
    mv output/tmp.box "output/$1.box"
}

HOSTS=()

for role in $(server_config/rgenvs.py -roles)
do
    HOSTS+=($(server_config/rgenvs.py -hosts -role=$role -env=development))
done

UNIQUE_HOSTS=$(echo "${HOSTS[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')

if (( $# == 1 ))
then
    if containsElement "$1" $UNIQUE_HOSTS ; then
        buildHost $1
    else
        echo "Sorry, \"$1\" was not one of $UNIQUE_HOSTS"
    fi
else

    for host in $UNIQUE_HOSTS
    do
        buildHost $host
    done

fi
