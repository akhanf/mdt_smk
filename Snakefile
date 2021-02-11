configfile: 'config.yml'

rule all:
    input:    
        expand('results/sub-{subject}/{model}',subject=config['subjects'],model=config['model'])

rule create_protocol:
    input:
        bval = config['in_dwi_bval'],
        bvec = config['in_dwi_bvec']
    params:
        opts = config['create_protocol_opts']
    output:
        protocol = 'results/sub-{subject}/dwi.prtcl'
    container: '/project/6050199/akhanf/singularity/bids-apps/khanlab_mdt-bids_v0.1.sif'
    shell: 'mdt-create-protocol {input.bvec} {input.bval} -o {output.protocol} {params.opts}'

rule model_fit:
    input:
        protocol = 'results/sub-{subject}/dwi.prtcl',
        dwi = config['in_dwi_nii'],
        mask = config['in_mask_nii']
    params:
        opts = config['model_fit_opts']
    output:
        out_folder = directory('results/sub-{subject}/{model}')
    container: '/project/6050199/akhanf/singularity/bids-apps/khanlab_mdt-bids_v0.1.sif'
    shell: 'mdt-model-fit {wildcards.model} {input.dwi} {input.protocol} {input.mask} -o {output.out_folder} {params.opts}'
