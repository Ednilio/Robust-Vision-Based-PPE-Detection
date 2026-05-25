#!/bin/bash
#SBATCH --job-name=yolov5n_eval_test
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv5n TEST evaluation"

# Conda activation
if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/usr/local/anaconda3/bin:$PATH"
fi

conda activate YOLOenv5

cd /home/u928808/yolov5 || exit 1

python val.py \
    --weights experiments/baseline_yolov5_sh17/yolov5n/weights/best.pt \
    --data /home/u928808/Thesis/data_for_yolo/sh17.yaml \
    --img 640 \
    --batch-size 64 \
    --device 0 \
    --task test \
    --project experiments/eval_yolov5_sh17 \
    --name yolov5n_test

echo "Evaluation finished for YOLOv5n"