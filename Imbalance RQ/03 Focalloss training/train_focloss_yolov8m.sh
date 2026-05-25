#!/bin/bash
#SBATCH --job-name=yolov8m_sh17_focal
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=36:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv8m SH17 training with Focal Loss"

# ------------------------
# Conda activation
# ------------------------
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
MODEL=yolov8m.pt
NAME=yolov8m_focal
BATCH=32
PROJECT=experiments/oversampled_yolov8_sh17_focal

# ------------------------
# Training (FOCAL LOSS VERSION)
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
    name=$NAME \
    cache=True

echo "Training finished for $NAME"