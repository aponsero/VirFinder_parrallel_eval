#!/bin/bash

#PBS -l select=1:ncpus=1:mem=6gb
#PBS -l walltime=04:00:00
#PBS -l place=free:shared

module load R
RUN="$WORKER_DIR/eval.r"

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

MODEL_FILE=${MOD##*/}
if [ "${MODEL_FILE}" = "VF.modEPV_k8.rda" ];then
    echo "MOD EPV"
    RUN="$WORKER_DIR/eval_modEPV.r"
    Rscript $RUN $MOD $FILE $OUT $MOD_NAME
else
    echo "USER MODEL"
    RUN="$WORKER_DIR/eval.r"
    Rscript $RUN $MOD $FILE $OUT $MOD_NAME
fi

echo "Finished `date`">>"$LOG"
