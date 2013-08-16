HOSTS=()

for role in $(server_config/rgenvs.py -roles)
do
    HOSTS+=($(server_config/rgenvs.py -hosts -role=$role -env=development))
done

UNIQUE_HOSTS=$(echo "${HOSTS[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')

for host in $UNIQUE_HOSTS
do
    packer build -var "hostname=$host" template/template.json
    mv output/tmp.box "output/$host.box"
done
