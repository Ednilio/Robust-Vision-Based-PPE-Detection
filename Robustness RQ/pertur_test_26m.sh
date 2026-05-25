#!/bin/bash
#SBATCH --job-name=yolov26m_eval_robustness
#SBATCH --partition=GPU
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

echo "Starting YOLOv26m robustness evaluation"

# -------------------------
# Conda activation
# -------------------------
if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/usr/local/anaconda3/bin:$PATH"
fi

conda activate YOLOenv

# -------------------------
# Paths
# -------------------------
BASE_DIR="/home/u928808/Thesis"
DATA_DIR="$BASE_DIR/data_for_yolo"
MODEL_PATH="runs/detect/experiments/baseline_yolov26_sh17/yolov26m/weights/best.pt"
PROJECT_DIR="experiments/perturbation_eval_yolov26_sh17"

cd "$BASE_DIR" || exit 1

# -------------------------
# Robustness conditions
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

    yolo detect val \
        model="$MODEL_PATH" \
        data="$DATA_DIR/sh17_${CONDITION}.yaml" \
        split=test \
        imgsz=640 \
        batch=32 \
        device=0 \
        project="$PROJECT_DIR" \
        name="yolov26m_${CONDITION}" \
        exist_ok=True

    echo "Finished evaluation for $CONDITION"
done

echo "All YOLOv26m robustness evaluations completed"