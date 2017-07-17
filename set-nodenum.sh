#!/bin/bash
source tpcds-env.sh

# Check SSH Config settings from tpcds-env.sh

echo "SSH_KEY env variable is set to $SSH_KEY"

if [ "$SSH_KEY" = "False" ]; then
  echo "SSH keyless access between nodes is assumed to be enabled. SSH config will be ignored."
else
  echo "SSH key required for node access. Using SSH config from tpcds-env.sh."
fi

# Set node number for each data node specified in dn.txt
# TODO: make sure you have set up dn.txt with your DataNode hostnames, 1 per line

n=1
cat dn.txt | while read h
do
  echo "$h = $n"
  if [ "$SSH_KEY" = "False" ]; then
    echo "$h 'echo export NODENUM=${n} > $HOME/impala-tpcds-kit/nodenum.sh' < /dev/null"
    ssh $h "echo export NODENUM=${n} > $HOME/impala-tpcds-kit/nodenum.sh" < /dev/null
  else
    echo "ssh -i $HOME/.ssh/$SSH_KEYNAME $h 'echo export NODENUM=${n} > $HOME/impala-tpcds-kit/nodenum.sh' < /dev/null"
    ssh -i $HOME/.ssh/$SSH_KEYNAME $h "echo export NODENUM=${n} > $HOME/impala-tpcds-kit/nodenum.sh" < /dev/null
  fi
  ((n=n+1))
done