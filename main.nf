#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

params.graphfasta = "/scratch/projects/Q2755-RTP-Pangenome-GEpipeline/00_raw/Wm82_ref/glyma.Wm82.gnm4.4PTR.genome_main.fna"
params.samplesheet = "/scratch/projects/Q2755-RTP-Pangenome-GEpipeline/9.0_CodeBase/genotyping/samplesheet.csv"

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