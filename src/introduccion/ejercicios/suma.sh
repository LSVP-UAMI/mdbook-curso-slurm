#!/bin/bash
#SBATCH --job-name=sumlist
#SBATCH --output=sumlist-%j.out
#SBATCH --partition=slims
#SBATCH --cpus-per-task=1
#SBATCH --mem=2300M
#SBATCH --time=00:10:00

echo "Job started on $(hostname)"
echo "Loading Python 3.9.5..."
module load Python/3.9.5

echo "Running Python script..."
python3 sum-large-list.py
