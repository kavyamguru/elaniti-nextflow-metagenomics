# Nextflow Metagenomics Pipeline (MetaPhlAn + HUMAnN)

This repository contains a modular, reproducible metagenomics analysis pipeline built using **Nextflow DSL2**.  
The pipeline is designed to demonstrate best practices in workflow engineering, containerised execution, and scalable deployment across local and HPC environments.

The workflow performs:
- **Taxonomic profiling** using MetaPhlAn  
- **Functional profiling** using HUMAnN  

This project focuses on **workflow design and engineering** rather than biological interpretation.  
Full-scale analyses using real databases and datasets were previously performed as part of an MSc Bioinformatics dissertation; this repository highlights reproducible and portable pipeline implementation.

---

## Key Features

- Modular **Nextflow DSL2** workflow design
- Parameterised inputs and outputs
- Per-process **Docker containerisation**
- Profile-based execution (local and Slurm/HPC)
- Clean separation of code, data, results, and execution artifacts
- Tested on real public soil metagenomics FASTQ data

---

## Repository Structure
```
nextflow/
├── main.nf                 # Main DSL2 workflow
├── modules/                # Process definitions
│   ├── metaphlan.nf
│   └── humann.nf
├── nextflow.config         # Parameters, Docker, and HPC profiles
├── README.md               # Documentation
├── test_data/              # Small public test dataset
│   ├── samplesheet.tsv
│   └── soil/
├── results/                # Example outputs from a test run
└── work/                   # Nextflow execution cache (not tracked)
```
---

## Input Data

### 1. Sample sheet

The pipeline expects a tab-separated sample sheet with the following columns:

```tsv
sample_id	read1	read2
SOIL_TEST_01	test_data/soil/SOIL_TEST_01_R1.fastq.gz	test_data/soil/SOIL_TEST_01_R2.fastq.gz
```
---

### 2. Sequencing Data

Paired-end metagenomic FASTQ files are used as input.

Example soil microbiome data is provided under:
test_data/soil/

The included dataset is a small public soil metagenomics sample intended for
demonstration and rapid testing of the workflow.

---

## Running the Pipeline

### Local Execution

Run the pipeline using default parameters and bundled test data:

```bash
nextflow run main.nf
```
---

### Custom Input and Output Paths

Custom sample sheets and output directories can be specified as follows:

```bash
nextflow run main.nf \
  --samplesheet test_data/samplesheet.tsv \
  --outdir results_run1
```
---

## Docker Support

Each process in the pipeline is containerised using official BioBakery Docker images:

- MetaPhlAn: biobakery/metaphlan
- HUMAnN: biobakery/humann

Docker support is enabled globally in nextflow.config, and containers are assigned
at the process level to ensure reproducible and portable execution independent of
the host environment.

---

## HPC / Slurm Execution

The pipeline includes a Slurm profile for execution on HPC systems.

```bash
nextflow run main.nf -profile slurm
```

The Slurm profile defines:
- Executor: slurm
- CPU, memory, and walltime requirements

This profile is configuration-only and is intended to demonstrate scalability to
production HPC environments.

---

## Outputs

Example outputs from a test run include:

results/metaphlan/
- Taxonomic profiles (TSV format)

results/humann/
- Functional gene family tables (TSV format)

Output locations are fully configurable via the --outdir parameter.

---

## Reproducibility

- Workflow execution is fully reproducible
- Software dependencies are isolated via Docker containers
- Intermediate files are managed by Nextflow in the work/ directory
- Clean re-runs can be performed by removing cached work directories

---

## Notes

This repository is intended as a workflow engineering demonstration project.
Biological interpretation of results is outside the scope of this pipeline.


