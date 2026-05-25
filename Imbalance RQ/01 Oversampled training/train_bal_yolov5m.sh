#!/bin/bash
#SBATCH --job-name=yolov5m_sh17_bal
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=30:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv5m SH17 oversampled training"

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
MODEL=yolov5m.pt
NAME=yolov5m
BATCH=32
PROJECT=experiments/oversampled_yolov5_sh17

# ------------------------
# Training
# ------------------------
python train.py \
    --weights $MODEL \
    --data /home/u928808/Thesis/data_for_yolo/sh17_over.yaml \
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
