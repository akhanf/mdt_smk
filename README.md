# mdt_smk
Snakemake workflow for MDT

## Instructions for running on graham
1. clone the repo
```
git clone https://github.com/akhanf/mdt_smk
cd mdt_smk
```
2. edit the subjects.txt
3. do a dry run:
```
snakemake -np
```
4. submit jobs (install cc-slurm profile first https://github.com/khanlab/cc-slurm):
```
snakemake --profile cc-slurm
```
