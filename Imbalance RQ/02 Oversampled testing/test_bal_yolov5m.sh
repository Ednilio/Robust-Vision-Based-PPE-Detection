#!/bin/bash
#SBATCH --job-name=yolov5m_bal_eval_test
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv5m oversampled TEST evaluation"

# Conda activation
if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/usr/local/anaconda3/bin:$PATH"
fi

conda activate YOLOenv5

cd /home/u928808/yolov5 || exit 1

python val.py \
    --weights experiments/oversampled_yolov5_sh17/yolov5m/weights/best.pt \
    --data /home/u928808/Thesis/data_for_yolo/sh17_over.yaml \
    --img 640 \
    --batch-size 32 \
    --device 0 \
    --task test \
    --project experiments/oversampled_eval_yolov5_sh17 \
    --name yolov5m_test

echo "Evaluation finished for oversampled YOLOv5m"
