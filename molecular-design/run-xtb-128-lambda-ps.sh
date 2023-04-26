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
# --simulate-ps-backend zmq \
# --infer-ps-backend endpoint \
# --train-ps-backend endpoint \
# --simulate-ps-backend redis \

ulimit -n 2048

python run.py \
       --redishost 10.236.1.190 \
       --redisport 7486 \
       --training-set $data_dir/training-data.json \
       --mpnn-model-path $mpnn_file \
       --model-count 8 \
       --num-epochs 128 \
       --search-space $search_space \
       --ps-globus-config globus_config.json \
       --ps-endpoints eed2ac9a-6dbd-4a12-8e58-25be0f6eec2d 4bad5404-f003-4d9a-b19f-b482b8004f80 \
       --num-qc-workers 2048 \
       --retrain-frequency 1 \
       --molecules-per-ml-task 50000 \
       --search-size 8192 \
       --ps-threshold 10000 \
       --use-parsl
