genome="/home/pospelova/bsseq/genome"

samples=(V350045437_L01_1 V350045437_L01_2 V350045437_L01_3 V350045437_L01_4)

for sample in "${samples[@]}"; do
    bismark_methylation_extractor \
	-p \
        --bedGraph \
        --genome_folder "$genome" \
        --cytosine_report \
        --gzip \
        --parallel 8 \
        "${sample}_trimmed_R1_final_bismark_bt2_pe.deduplicated.bam"

    bismark2report \
        --output "${sample}_methylation_report.html"

    bismark2summary \
        -o "${sample}_methylation_summary"
done
