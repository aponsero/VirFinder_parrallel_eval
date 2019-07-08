#!/bin/bash

#PBS -l select=1:ncpus=1:mem=6gb
#PBS -l walltime=48:00:00
#PBS -l place=free:shared

module load R
RUN="$WORKER_DIR/eval_default.r"

HOST=`hostname`
LOG="$STDOUT_DIR/${HOST}.log"
ERRORLOG="$STDERR_DIR/${HOST}.log"

if [ ! -f "$LOG" ] ; then
    touch "$LOG"
fi
echo "Started `date`">>"$LOG"
echo "Host `hostname`">>"$LOG"

export MYDATA=`head -n +${PBS_ARRAY_INDEX} $FILE_LIST | tail -n 1`
export FILENAME="${MYDATA:2}"
export FILE="$DATASET_DIR/$FILENAME"
export OUT="$RESULT_DIR/${FILENAME}.txt"

Rscript $RUN $FILE $OUT

echo "Finished `date`">>"$LOG"
