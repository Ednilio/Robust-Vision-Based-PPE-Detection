#!/bin/bash
#SBATCH --job-name=yolov5m_eval_robustness
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv5m robustness evaluation"

# -------------------------
# Conda activation
# -------------------------
if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/usr/local/anaconda3/bin:$PATH"
fi

conda activate YOLOenv5

# -------------------------
# Paths
# -------------------------
YOLOV5_DIR="/home/u928808/yolov5"
DATA_DIR="/home/u928808/Thesis/data_for_yolo"
WEIGHTS="experiments/baseline_yolov5_sh17/yolov5m/weights/best.pt"
PROJECT_DIR="experiments/perturbation_eval_yolov5_sh17"

cd "$YOLOV5_DIR" || exit 1

# -------------------------
# Robustness test sets
# -------------------------
declare -a CONDITIONS=(
  "blur1"
  "blur2"
  "blur3"
  "light1"
  "light2"
  "light3"
  "occ1"
  "occ2"
  "occ3"
)

# -------------------------
# Loop over conditions
# -------------------------
for CONDITION in "${CONDITIONS[@]}"; do
    echo "========================================"
    echo "Evaluating condition: $CONDITION"
    echo "========================================"

    python val.py \
        --weights "$WEIGHTS" \
        --data "$DATA_DIR/sh17_${CONDITION}.yaml" \
        --img 640 \
        --batch-size 64 \
        --device 0 \
        --task test \
        --project "$PROJECT_DIR" \
        --name "yolov5m_${CONDITION}" \
        --exist-ok

    echo "Finished evaluation for $CONDITION"
done

echo "All robustness evaluations completed"
