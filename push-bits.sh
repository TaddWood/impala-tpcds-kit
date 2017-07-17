#!/bin/bash
source tpcds-env.sh

# Check SSH Config settings from tpcds-env.sh

echo "SSH_KEY env variable is set to $SSH_KEY"

if [ "$SSH_KEY" = "False" ]; then
  echo "SSH keyless access between nodes is assumed to be enabled. SSH config will be ignored."
else
  echo "SSH key required for node access. Using SSH config from tpcds-env.sh."
fi

# Push tpcds kits (tpcds-kit, impala-tpcds-kit) to each data node specified in dn.txt
# TODO: make sure you have set up dn.txt with your DataNode hostnames, 1 per line

cat dn.txt | while read h
do
  if [ "$SSH_KEY" = "False" ]; then
    echo "scp -rp $HOME/tpcds-kit $h:$HOME"
    scp -rp $HOME/tpcds-kit $h:$HOME
    echo "scp -rp $HOME/impala-tpcds-kit $h:$HOME"
    scp -rp $HOME/impala-tpcds-kit $h:$HOME
  else
    echo "scp -i $HOME/.ssh/$SSH_KEYNAME -rp $HOME/tpcds-kit $h:$HOME"
    scp -i $HOME/.ssh/$SSH_KEYNAME -rp $HOME/tpcds-kit $h:$HOME
    echo "scp -i $HOME/.ssh/$SSH_KEYNAME -rp $HOME/impala-tpcds-kit $h:$HOME"
    scp -i $HOME/.ssh/$SSH_KEYNAME -rp $HOME/impala-tpcds-kit $h:$HOME
  fi
done
