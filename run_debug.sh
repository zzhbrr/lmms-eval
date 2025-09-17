# bash run.sh "/data1/zzh/huggingface/hub/models--google--gemma-3-4b-it/snapshots/093f9f388b31de276ce2de164bdc2081324b9767" "refcoco" "image"
CKPT_PATH=$1
TASK=$2
MODALITY=$3
TP_SIZE=$4
echo $TASK
TASK_SUFFIX="${TASK//,/_}"
echo $TASK_SUFFIX

python3 -m debugpy --listen 62481 --wait-for-client \
    ./lmms_eval/__main__.py \
    --model srt_api \
    --model_args modality=$MODALITY,model_version=$CKPT_PATH,tp=$TP_SIZE,host=127.0.0.1,port=30000 \
    --tasks $TASK \
    --batch_size 1 \
    --log_samples \
    --log_samples_suffix $TASK_SUFFIX \
    --output_path ./logs/ \
    --verbosity DEBUG

