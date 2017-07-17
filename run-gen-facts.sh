#!/bin/bash
source tpcds-env.sh

# Check SSH Config settings from tpcds-env.sh

echo "SSH_KEY env variable is set to $SSH_KEY"

if [ "$SSH_KEY" = "False" ]; then
  echo "SSH keyless access between nodes is assumed to be enabled. SSH config will be ignored."
else
  echo "SSH key required for node access. Using SSH config from tpcds-env.sh."
fi

# Run gen-facts.sh on each data node specified in dn.txt
# TODO: make sure you have set up dn.txt with your DataNode hostnames, 1 per line

cat dn.txt | while read h
do
  if [ "$SSH_KEY" = "False" ]; then
    echo "ssh $h 'cd $HOME/impala-tpcds-kit; ./gen-facts.sh' < /dev/null &"
    ssh $h "cd $HOME/impala-tpcds-kit; ./gen-facts.sh" < /dev/null &
  else
    echo "ssh -i $HOME/.ssh/$SSH_KEYNAME $h 'cd $HOME/impala-tpcds-kit; ./gen-facts.sh' < /dev/null &"
    ssh -i $HOME/.ssh/$SSH_KEYNAME $h "cd $HOME/impala-tpcds-kit; ./gen-facts.sh" < /dev/null &
  fi
done
