process CHECK_SAMPLESHEET {
    tag "$samplesheet"

    memory = 0.5G

    container "quay.io/biocontainers/python:3.8.3"

    input:
    path(samplesheet)

    output:
    path('*.csv') , emit: csv

    script: // currently place holder - check nf-core cheipseq pipeline
    """
    cp $samplesheet samplesheet.valid.csv
    """
}
