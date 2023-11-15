process CHECK_SAMPLESHEET {
    tag "$samplesheet"

    memory = '1.GB'
    cpus = 12
    
    container "quay.io/biocontainers/python:3.8.3"

    input:
    path(samplesheet)

    output:
    path('*.csv') , emit: csv

    script: // currently place holder - check nf-core cheipseq pipeline
    """
    ls -alh
    #cp $samplesheet samplesheet.valid.csv
    """
}
