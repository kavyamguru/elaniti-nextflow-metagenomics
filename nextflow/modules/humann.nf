process HUMANN {

    tag "${sample_id}"
    
    container 'biobakery/humann:latest'

    publishDir "${params.outdir}/humann", mode: 'copy'

    input:
    tuple val(sample_id), path(metaphlan_profile)

    output:
    path "${sample_id}_humann"

    script:
    """
    mkdir ${sample_id}_humann
    echo -e "gene\tabundance" > ${sample_id}_humann/${sample_id}_genefamilies.tsv
    """
}

