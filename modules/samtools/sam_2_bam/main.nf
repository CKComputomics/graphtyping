process SAM_2_BAM {

    memory = 10.G

    container "staphb/samtools:latest"
    containerOptions = "--user 1057:1001"

    input:
    tuple val(meta), path(sam)

    output:
    tuple val(meta), path("*.bam"), emit: sam

    script:
    def prefix = task.ext.prefix ?: "${graphfasta.baseName}"
    """
    samtools view -bS ${sam} -o ${prefix}.bam
    """

}
