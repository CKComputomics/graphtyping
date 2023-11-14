process BWA_MEM {
    tag "$meta.id"

    memory = '10.GB'
    cpus = 12

    container "staphb/bwa:latest" 
    containerOptions = "--user 1057:1001"

    input:
    tuple val(meta), path(reads)
    path(index)

    output:
    tuple val(meta), path("*.sam"), emit: sam

    script:
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    INDEX=`find -L ./ -name "*.amb" | sed 's/\\.amb\$//'`

    bwa mem \\
        -t 12 \\
        \$INDEX \\
        $reads \\
        > ${prefix}.sam
    """
}
