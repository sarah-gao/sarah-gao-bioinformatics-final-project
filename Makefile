$(DATA_ANALYSIS_DIR)	:=	/data/sars_vcf_analysis
$(FASTERQ_TEMP)			:=	$(DATA_ANALYSIS_DIR)/00_fasterq_temp
$(FASTQ_DIR)			:=	$(DATA_ANALYSIS_DIR)/01_raw_fastq
$(GENOME_REF_DIR)		:=	$(DATA_ANALYSIS_DIR)/02_genome_reference
$(FASTQC_DIR)			:=	$(DATA_ANALYSIS_DIR)/03_fastqc_output
$(TRIMMED_DIR)			:=	$(DATA_ANALYSIS_DIR)/04_trimmed_fastq
$(MAPPED_SAM_DIR)		:=	$(DATA_ANALYSIS_DIR)/05_mapped_sam
$(MAPPED_BAM_DIR)		:=	$(DATA_ANALYSIS_DIR)/06_mapped_bam
$(MAP_SORTED_BAM_DIR)	:=	$(DATA_ANALYSIS_DIR)/07_mapped_sorted_bam
$(FLAGSTATS_DIR)		:=	$(DATA_ANALYSIS_DIR)/08_flagstats
$(BCF_VAR_DIR)			:=	$(DATA_ANALYSIS_DIR)/09_bcf_variants
$(VCF_DIR)				:=	$(DATA_ANALYSIS_DIR)/10_vcf_called

# note these are in repo not in root /data
$(RUNTABLE_DIR)			:=	data/00_sra_runtable
$(SRA_RUNTABLE)			:=	$(RUNTABLE_DIR)/SraRunTable_PRJNA656695_short.txt
$(VCF_FOR_R_DIR)		:=	data/11_vcf_output_for_R

all : $(VCF_FOR_R_DIR)/%.vcf 

$(VCF_FOR_R_DIR)/%.vcf : code/12_filter_vcf.sh $(VCF_DIR)/%.vcf
	bash code/12_filter_vcf.sh $(DATA_ANALYSIS_DIR)/10_vcf_called/*.vcf

$(VCF_DIR)/%.vcf : code/11_create_vcf.sh $(BCF_VAR_DIR)/%.bcf
	bash code/11_create_vcf.sh $(DATA_ANALYSIS_DIR)/09_bcf_variants/*.bcf

$(BCF_VAR_DIR)/%.bcf : code/10_bcftools_mpileup.sh $(MAP_SORTED_BAM_DIR)/%.bam
	bash code/10_bcftools_mpileup.sh $(DATA_ANALYSIS_DIR)/07_mapped_sorted_bam/*.bam

$(FLAGSTATS_DIR)/%.txt : code/09_flagstat.sh $(MAP_SORTED_BAM_DIR)/%.bam
	bash code/09_flagstat.sh $(DATA_ANALYSIS_DIR)/07_mapped_sorted_bam/*.bam

$(MAP_SORTED_BAM_DIR)/%.bam : code/08_sort_bam.sh $(MAPPED_BAM_DIR)/%.bam
	bash code/08_sort_bam.sh $(DATA_ANALYSIS_DIR)/06_mapped_bam/*.bam

$(MAPPED_BAM_DIR)/%.bam : code/07_sam_to_bam.sh $(MAPPED_SAM_DIR)/%.sam
	bash code/07_sam_to_bam.sh $(DATA_ANALYSIS_DIR)/05_mapped_sam/*.sam

$(MAPPED_SAM_DIR)/%.sam : code/06_run_bwa.sh $(TRIMMED_DIR)/%.trim.fastq
	bash code/06_run_bwa.sh $(DATA_ANALYSIS_DIR)/04_trimmed_fastq/*.trim.fastq

$(GENOME_REF_DIR)/%.idx : code/05_bwa_index.sh $(GENOME_REF_DIR)/%.fasta
	bash code/05_bwa_index.sh

$(TRIMMED_DIR)/%.trim.fastq : code/04_trim.sh $(FASTQ_DIR)/%.fastq
	bash code/04_trim.sh $(DATA_ANALYSIS_DIR)/01_raw_fastq/*.fastq

$(FASTQC_DIR)/% : code/03_fastqc.sh $(FASTQ_DIR)/%.fastq
	bash code/03_fastqc.sh $(DATA_ANALYSIS_DIR)/01_raw_fastq/*.fastq

$(GENOME_REF_DIR)/%.fasta : code/02_download_reference.sh makedirs
	bash code/02_download_reference.sh

$(FASTQ_DIR)/%.fastq :  code/01_download_fastq.sh $(SRA_RUNTABLE) makedirs
	bash code/01_download_fastq.sh $(SRA_RUNTABLE)

makedirs :
	bash code/00_setup_directories.sh

clean :
	rm -fv $(VCF_FOR_R_DIR)/%.vcf
	rm -fvr $(DATA_ANALYSIS_DIR) 

.PHONY : all clean makedirs
