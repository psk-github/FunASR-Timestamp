#!/usr/bin/env bash

. ./path.sh || exit 1;
# Begin configuration section.
nj=32
cmd=./utils/run.pl
feats_dim=80

echo "$0 $@"

. utils/parse_options.sh || exit 1;

fbankdir=$1
logdir=$2

output_dir=${fbankdir}/cmvn/split_${nj};
split_scps=""
for n in $(seq $nj); do
    split_scps="$split_scps $output_dir/wav.$n.scp"
done
utils/split_scp.pl ${fbankdir}/wav.scp $split_scps || exit 1;

#$cmd JOB=1:$nj $logdir/cmvn.JOB.log \
#    python utils/compute_cmvn.py -d ${feats_dim} -a $fbankdir/ark -i JOB -o ${output_dir} \
#        || exit 1;
#
#python utils/combine_cmvn_file.py -d ${feats_dim} -c ${output_dir} -n $nj -o $fbankdir
#
#echo "$0: Succeeded compute global cmvn"
