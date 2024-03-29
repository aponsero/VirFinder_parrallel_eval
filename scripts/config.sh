export CWD=$PWD
# where programs are
export BIN_DIR="/rsgrps/bhurwitz/hurwitzlab/bin"
# where the dataset to prepare is
export DATASET_DIR="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/experiments/3-mock_community/mock1/mock1_500pb_10kcontigs" # Directory where the data is stored
### State the MOD="default" to run on the default model or provide path to a model
export MOD="default" 
export RESULT_DIR="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/experiments/3-mock_community/mock1/VirFinder/mock1_500pb_10kcontigs"
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers" 
# User informations
export QUEUE="standard"
export GROUP="bhurwitz"
export MAIL_USER="aponsero@email.arizona.edu"
export MAIL_TYPE="bea"

#
# --------------------------------------------------
function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function lc() {
    wc -l $1 | cut -d ' ' -f 1
}
