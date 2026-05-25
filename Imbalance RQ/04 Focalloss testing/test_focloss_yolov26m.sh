#!/bin/bash
#SBATCH --job-name=yolov26m_focalloss_eval_test
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv26m focal loss TEST evaluation"

# Conda activation
if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/usr/local/anaconda3/bin:$PATH"
fi

conda activate YOLOenv

cd /home/u928808/Thesis || exit 1

yolo detect val \
    model=runs/detect/experiments/oversampled_yolo26_sh17_focal/yolo26m_focal/weights/best.pt \
    data=data_for_yolo/sh17.yaml \
    split=test \
    imgsz=640 \
    batch=32 \
    device=0 \
    project=experiments/focal_eval_yolov26_sh17 \
    name=yolov26m_test

echo "Evaluation finished"