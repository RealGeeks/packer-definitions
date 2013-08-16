PUPPET_SUMMARY=/var/lib/puppet/state/last_run_summary.yaml

if  sudo grep 'changed: 0' $PUPPET_SUMMARY ; then
    echo "PUPPET DIDNT DO ANYTHING"
    exit 2
fi

if ! sudo grep 'failed: 0' $PUPPET_SUMMARY ; then
    echo "PUPPET FAILURES OCCURED"
    exit 2
fi


