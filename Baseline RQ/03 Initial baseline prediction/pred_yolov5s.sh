#!/bin/bash
#SBATCH --job-name=yolov5s_predict_test
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv5s prediction on SH17 test set"

# Conda activation
if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/usr/local/anaconda3/bin:$PATH"
fi

conda activate YOLOenv5

cd /home/u928808/yolov5 || exit 1

python detect.py \
    --weights experiments/baseline_yolov5_sh17/yolov5s/weights/best.pt \
    --source /home/u928808/Thesis/data_for_yolo/images/test \
    --img 640 \
    --conf 0.25 \
    --device 0 \
    --save-txt \
    --save-conf \
    --project experiments/predictions \
    --name yolov5s_test_preds

echo "Prediction finished for YOLOv5s on SH17 test set"