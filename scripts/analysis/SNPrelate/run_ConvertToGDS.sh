#!/bin/bash

. /u/local/Modules/default/init/modules.sh
module load R

Rscript ConvertToGDS.Hoffman.R
