genome="/home/pospelova/bsseq/genome"

samples=(methylseq1 methylseq2 methylseq3 methylseq4)

for sample in "${samples[@]}"; do
    bismark_methylation_extractor \
    	-p \
        --bedGraph \
        --genome_folder "$genome" \
        --cytosine_report \
        --gzip \
        --parallel 8 \
        "${sample}_trimmed_R1_final_bismark_bt2_pe.deduplicated.bam"

    bismark2report

    bismark2summary \
        -o "${sample}_methylation_summary"
done
