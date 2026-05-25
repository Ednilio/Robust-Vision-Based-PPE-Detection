#!/bin/bash
#SBATCH --job-name=yolov5s_sh17
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=25:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv5s SH17 training"

# Conda activation
if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/usr/local/anaconda3/bin:$PATH"
fi

conda activate YOLOenv5

cd /home/u928808/yolov5 || exit 1

# ------------------------
# Configuration
# ------------------------
MODEL=yolov5s.pt
NAME=yolov5s
BATCH=64
PROJECT=experiments/baseline_yolov5_sh17

# ------------------------
# Training
# ------------------------
python train.py \
    --weights $MODEL \
    --data /home/u928808/Thesis/data_for_yolo/sh17.yaml \
    --epochs 200 \
    --img 640 \
    --batch $BATCH \
    --device 0 \
    --project $PROJECT \
    --name $NAME \
    --seed 42 \
    --patience 50 \
    --cache

echo "Training finished for $NAME"