#! /bin/bash

data_dir=/lus/theta-fs0/projects/CSC249ADCD08/multi-site-campaigns/data/moldesign/

search_space=$data_dir/search-space/MOS-search.csv
# Get the MPNN models
mpnn_file=$data_dir/initial-model/networks/gpu_b16_n256_Rsum_cbd46e/model.h5


# Relevant endpoints
#  b9c5db67-cc17-4708-be97-5274443d789a: Debug queue, one node, flat memory
#  acdb2f41-fd86-4bc7-a1e5-e19c12d3350d: Lambda
#  de92a1ac-4118-48a2-90ac-f43a59298634: Venti
#       --ml-endpoint de92a1ac-4118-48a2-90ac-f43a59298634 \
#       --qc-endpoint b9c5db67-cc17-4708-be97-5274443d789a \

python run.py \
       --redisport 7486 \
       --training-set $data_dir/training-data.json \
       --mpnn-model-path $mpnn_file \
       --model-count 8 \
       --num-epochs 128 \
       --search-space $search_space \
       --infer-ps-backend redis \
       --train-ps-backend redis \
       --simulate-ps-backend file \
       --ps-file-dir proxy-store-scratch \
       --ps-globus-config globus_config.json \
       --num-qc-workers 8 \
       --retrain-frequency 1 \
       --molecules-per-ml-task 50000 \
       --search-size 512 \
       --ps-threshold 10000 \
       --use-parsl \
       --no-proxystore
