#!/bin/bash
#SBATCH --job-name=yolov26s_predict_test
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv26s prediction on SH17 test set"

# Conda activation
if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/usr/local/anaconda3/bin:$PATH"
fi

conda activate YOLOenv

cd /home/u928808/Thesis || exit 1

yolo detect predict \
    model=runs/detect/experiments/baseline_yolov26_sh17/yolov26s/weights/best.pt \
    source=data_for_yolo/images/test \
    imgsz=640 \
    conf=0.25 \
    device=0 \
    save=True \
    save_txt=True \
    project=experiments/predictions \
    name=yolov26s_test_preds

echo "Prediction finished for YOLOv26s on SH17 test set"