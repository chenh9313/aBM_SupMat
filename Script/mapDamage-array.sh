#Author: Huan Chen
#Date: 10-2023

#!/bin/bash --login

#SBATCH --array=0-15                #500 array threads that will run in parallel
#SBATCH --time=12:00:00             # limit of wall clock time - how long the job will run (same as -t)
#SBATCH --nodes=1-5                  
#SBATCH --ntasks=5                  # number of tasks - how many tasks (nodes) that you require (same as -n)
#SBATCH --cpus-per-task=1           # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem-per-cpu=1G
#SBATCH --job-name mapDamage_array               # you can give your job a name for easier identification (same as -J)
#SBATCH --output=%x_%j.out # output (%x is the --job-name and %j is the job id); there will be 100 output files, one for each thread

########## Command Lines to Run ##########
REF=Reference Path

SAMPLE=( aBM_cobbam aBM_combbam_rm5nt aBM_combfq aBM_combfq_rm5nt Bolivian_Maize_1_ATCACG_L001 Bolivian_Maize_1_ATCACG_L001_rm5nt Bolivian_Maize_2_CGATGT_L001 Bolivian_Maize_2_CGATGT_L001_rm5nt Bolivian_Maize_3_TTAGGC_L001 Bolivian_Maize_3_TTAGGC_L001_rm5nt Bolivian_Maize_4_TGACCA_L001 Bolivian_Maize_4_TGACCA_L001_rm5nt Bolivian_Maize_5_ACAGTG_L001 Bolivian_Maize_5_ACAGTG_L001_rm5nt Bolivian_Maize_6_GCCAAT_L001 Bolivian_Maize_6_GCCAAT_L001_rm5nt )

echo "${SLURM_ARRAY_TASK_ID} ; ${SAMPLE[${SLURM_ARRAY_TASK_ID}]}" # iterate throught the list SAMPLE (length of 500 elements)

module load GCC/8.3.0 OpenMPI/3.1.4 R/4.0.2 #install.packages("RcppGSL");library(RcppGSL);install.packages("gam");library(gam)
module load GCCcore/6.4.0
module load Python/3.7.2
mapDamage -i ${SAMPLE[${SLURM_ARRAY_TASK_ID}]}.DR.bam -r ${REF}/GCF_902167145.1_Zm-B73-REFERENCE-NAM-5.0_genomic.fa

scontrol show job $SLURM_JOB_ID # information about the job and each thread
