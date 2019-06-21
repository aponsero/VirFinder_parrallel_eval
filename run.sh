#!/bin/sh
set -u
#
# Checking args
#

source scripts/config.sh

if [[ ! -d "$DATASET_DIR" ]]; then
    echo "$DATASET_DIR directory does not exist. Please provide a directory containing evaluation set files to process. Job terminated."
    exit 1
fi

export FILE_LIST="$DATASET_DIR/list.txt"
cd $DATASET_DIR
find . -type f -name "*.fasta"> $FILE_LIST
export NUM_FILES=$(wc -l < "$FILE_LIST")

if [[ $NUM_FILES -eq 0 ]]; then
  echo "No models found in $DATASET_DIR, please correct config file. Job terminated."
  exit 1
fi

if [[ ! -f "$MOD" ]]; then
    MOD="default"
    echo "Provided model does not exist. The job will be run using the default VirFinder model."
fi

if [[ ! -d "$RESULT_DIR" ]]; then
    echo "$RESULT_DIR does not exist. Directory created for pipeline output."
    mkdir -p "$RESULT_DIR"
fi

#
# Job submission
#

PREV_JOB_ID=""
ARGS="-q $QUEUE -W group_list=$GROUP -M $MAIL_USER -m $MAIL_TYPE"

#
## 01-run evals
#

PROG="01-run-evaluation"
export STDERR_DIR="$SCRIPT_DIR/err/$PROG"
export STDOUT_DIR="$SCRIPT_DIR/out/$PROG"
init_dir "$STDERR_DIR" "$STDOUT_DIR"

if [ "${MOD}" = "default" ]; then
    echo "launching $SCRIPT_DIR/run_default_analysis.sh "

    JOB_ID=`qsub $ARGS -v WORKER_DIR,FILE_LIST,DATASET_DIR,RESULT_DIR,STDERR_DIR,STDOUT_DIR -N run_evaluation -e "$STDERR_DIR" -o "$STDOUT_DIR" -J 1-$NUM_FILES $SCRIPT_DIR/run_default_analysis.sh`

    if [ "${JOB_ID}x" != "x" ]; then
         echo Job: \"$JOB_ID\"
        PREV_JOB_ID=$JOB_ID
    else
         echo Problem submitting job. Job terminated
    fi
    echo "job successfully submited"

else
    echo "launching $SCRIPT_DIR/run_analysis.sh "
           
    JOB_ID=`qsub $ARGS -v WORKER_DIR,FILE_LIST,MOD,DATASET_DIR,RESULT_DIR,STDERR_DIR,STDOUT_DIR -N run_evaluation -e "$STDERR_DIR" -o "$STDOUT_DIR" -J 1-$NUM_FILES $SCRIPT_DIR/run_analysis.sh`

    if [ "${JOB_ID}x" != "x" ]; then
         echo Job: \"$JOB_ID\"
        PREV_JOB_ID=$JOB_ID  
    else
         echo Problem submitting job. Job terminated
    fi
    echo "job successfully submited"
fi

