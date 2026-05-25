#!/bin/bash
#SBATCH --job-name=yolov8n_sh17
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=25:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv8n SH17 training"

# Conda activation
if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/usr/local/anaconda3/bin:$PATH"
fi

conda activate YOLOenv

cd /home/u928808/Thesis || exit 1

# ------------------------
# Configuration
# ------------------------
MODEL=yolov8n.pt
NAME=yolov8n
BATCH=64
PROJECT=experiments/baseline_yolov8_sh17

# ------------------------
# Training
# ------------------------
yolo detect train \
    model=$MODEL \
    data=data_for_yolo/sh17.yaml \
    epochs=200 \
    imgsz=640 \
    batch=$BATCH \
    device=0 \
    pretrained=True \
    patience=50 \
    seed=42 \
    project=$PROJECT \
    name=$NAME

echo "Training finished for $NAME"