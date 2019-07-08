# VirFinder_parrallel_eval
Pipeline for VirFinder use on dataset. Parallelized for HPC use.

The complete pipeline will run VirFinder on all submitted files.

## Requirements

### VirFinder
VirFinder is an R package available at https://github.com/jessieren/VirFinder

## Quick start

### Edit scripts/config.sh file

please modify the following attributes

  - DATASET_DIR: path to the directory where the data is store
  - MOD : path to VirFinder model to use. If set to "default", the built-in VirFinder model will be used
  - RESULT_DIR : path to the output directory

  - OUTNAME  : indicate here the name to use for the output files
  - MAIL_USER : indicate here your arizona.edu email
  - GROUP : indicate here your group affiliation

You can also modify

  - BIN = change for your own bin directory.
  - MAIL_TYPE = change the mail type option. By default set to "bea".
  - QUEUE = change the submission queue. By default set to "standard".
  
  ### Run pipeline
  
  Run 
  ```bash
  ./run.sh
  ```
  This command will place one job in queue.
  
