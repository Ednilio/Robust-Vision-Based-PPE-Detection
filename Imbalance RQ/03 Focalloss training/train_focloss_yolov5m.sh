#!/bin/bash
#SBATCH --job-name=yolov5m_sh17_focalloss
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=25:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv5m focal loss SH17 training"

# Conda activation
if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/usr/local/anaconda3/bin:$PATH"
fi

conda activate YOLOenv5

cd /home/u928808/yolov5 || exit 1

# ------------------------
# Training
# ------------------------
python train.py \
    --weights yolov5m.pt \
    --data /home/u928808/Thesis/data_for_yolo/sh17.yaml \
    --epochs 200 \
    --img 640 \
    --batch 32 \
    --device 0 \
    --project experiments/focal_yolov5_sh17 \
    --name yolov5m_focal_g2 \
    --hyp hyp.focal.yaml \
    --seed 42 \
    --patience 50 \
    --cache

echo "Training finished for yolov5m focal loss"

