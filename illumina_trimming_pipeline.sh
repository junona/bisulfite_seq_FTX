#!/bin/bash

# Define the sample names and paths
samples=(V350045437_L01_1 V350045437_L01_2 V350045437_L01_3 V350045437_L01_4)
path_to_samples="../"

# Loop through the samples
for sample in "${samples[@]}"; do
    java -jar ../hypothesis_mgi/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
        -threads 8 \
        -phred33 \
        "${path_to_samples}/${sample}_1.fq.gz" "${path_to_samples}/${sample}_2.fq.gz" \
        "${sample}_trimmed_R1_final.fastq.gz" "${sample}_trimmed_R1_final_unpaired.fastq.gz" \
        "${sample}_trimmed_R2_final.fastq.gz" "${sample}_trimmed_R2_final_unpaired.fastq.gz" \
        ILLUMINACLIP:Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
        LEADING:3 \
        TRAILING:3 \
        SLIDINGWINDOW:4:15 \
        ILLUMINACLIP:../hypothesis_mgi/Trimmomatic-0.39/adapters/Sequencing_adaptors.fasta:2:30:10

    # Run FastQC on the final trimmed files
    fastqc "${sample}_trimmed_R1_final.fastq.gz" "${sample}_trimmed_R2_final.fastq.gz"

    # Store the FastQC output in a separate directory
    mkdir -p fastqc_output
    mv "${sample}_trimmed_R1_final_fastqc.zip" "${sample}_trimmed_R2_final_fastqc.zip" fastqc_output/
done

# Run MultiQC on all the FastQC output
multiqc fastqc_output/ -o multiqc_output/
