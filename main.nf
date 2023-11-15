#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

params.graphfasta = "/scratch/playground/chriskub/graphtyping/data/Wm82_chr1.fasta"
params.samplesheet = "/scratch/playground/chriskub/graphtyping/data/samplesheet.csv"

include { INPUT_TEST } from './workflows/input_test.nf'

include { BWA_INDEX } from './modules/bwa/index'
include { BWA_MEM   } from './modules/bwa/mem'
include { SAM_2_BAM } from './modules/samtools/sam_2_bam'

workflow {

    INPUT_TEST ( file(params.samplesheet) )

    BWA_INDEX (params.graphfasta)

    BWA_MEM (
        INPUT_TEST.out.reads,
        BWA_INDEX.out.index
    )

    SAM_2_BAM (
        BWA_MEM.out.sam
    )

}