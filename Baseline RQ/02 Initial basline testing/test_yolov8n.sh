#!/bin/bash
#SBATCH --job-name=yolov8n_eval_test
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv8n TEST evaluation"

# Conda activation
if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/usr/local/anaconda3/bin:$PATH"
fi

conda activate YOLOenv

cd /home/u928808/Thesis || exit 1

yolo detect val \
    model=runs/detect/experiments/baseline_yolov8_sh17/yolov8n/weights/best.pt \
    data=data_for_yolo/sh17.yaml \
    split=test \
    imgsz=640 \
    batch=64 \
    device=0 \
    project=experiments/eval_yolov8_sh17 \
    name=yolov8n_test

echo "Evaluation finished"