#!/bin/bash
#SBATCH --job-name=yolov26m_sh17_bal
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=36:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv26m SH17 oversampled training"

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
MODEL=yolo26m.pt
NAME=yolov26m
BATCH=32
PROJECT=experiments/oversampled_yolov26_sh17

# ------------------------
# Training
# ------------------------
yolo detect train \
    model=$MODEL \
    data=data_for_yolo/sh17_over.yaml \
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