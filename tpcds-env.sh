# DATA SCALING CONFIG (REQUIRED)

# path to the tpcds-kit directory
export TPCDS_ROOT=$HOME/tpcds-kit

# top level directory for flat files in HDFS
export FLATFILE_HDFS_ROOT=/user/${USER}/tpcds

# scale factor in GB
# SF 3000 yields ~1TB for the store_sales table
export TPCDS_SCALE_FACTOR=3000

# this is used to determine the number of dsdgen processes to generate data
# usually set to one per physical CPU core
# example - 20 nodes @ 12 threads each
export DSDGEN_NODES=20
export DSDGEN_THREADS_PER_NODE=12
export DSDGEN_TOTAL_THREADS=$((DSDGEN_NODES * DSDGEN_THREADS_PER_NODE))

# the name for the tpcds database
export TPCDS_DBNAME=tpcds_parquet


# IMPALA PORT CONFIG (REQUIRED)
## NOTE: Default values for Impala port and Backends port may or may not need adjusting depending on your cluster setup.

export IMPALA_PORT=25000
export IMPALA_BACKENDS_PORT=22000


# SSH ACCESS CONFIG (OPTIONAL)
## Configure this section if you do not have keyless ssh access between nodes.
## NOTE: Default value is False since this code is based on the prerequisite that keyless ssh access exists between nodes.

export SSH_KEY=False
export SSH_KEYNAME=mykeyname