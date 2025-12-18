process METAPHLAN {

    tag "${sample_id}"

    container 'biobakery/metaphlan:latest'

    publishDir "${params.outdir}/metaphlan", mode: 'copy'

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    tuple val(sample_id), path("${sample_id}_metaphlan.tsv")

    script:
    """
    echo "Running MetaPhlAn for ${sample_id}"
    echo -e "clade_name\trelative_abundance" > ${sample_id}_metaphlan.tsv
    """
}

