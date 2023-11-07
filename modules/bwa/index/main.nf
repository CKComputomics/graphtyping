process BWA_INDEX {

    memory '2 GB'

    container "staphb/bwa:latest"
    containerOptions = "--user 1057:1001"

    input:
    path(graphfasta)

    output:
    path(bwa), emit: index

    script:
    def prefix = task.ext.prefix ?: "${graphfasta.baseName}"
    """
    mkdir bwa
    bwa index \\
        -p bwa/${prefix} \\
        ${graphfasta}
    """
}
