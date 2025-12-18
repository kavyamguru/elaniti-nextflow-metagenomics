nextflow.enable.dsl=2

// ----------------------
// Parameters
// ----------------------
params.samplesheet = params.samplesheet ?: 'test_data/samplesheet.tsv'
params.outdir      = params.outdir      ?: 'results'

// ----------------------
// Include modules
// ----------------------
include { METAPHLAN } from './modules/metaphlan'
include { HUMANN }    from './modules/humann'

// ----------------------
// Channels
// ----------------------
Channel
    .fromPath(params.samplesheet)
    .splitCsv(header: true, sep: '\t')
    .map { row ->
        tuple(
            row.sample_id,
            file(row.read1),
            file(row.read2)
        )
    }
    .set { samples_ch }

// ----------------------
// Workflow
// ----------------------
workflow {
    samples_ch | METAPHLAN | HUMANN
}

