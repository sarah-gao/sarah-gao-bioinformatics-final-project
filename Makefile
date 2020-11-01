DATA_ANALYSIS_DIR	:=	/data/sars_vcf_analysis
FASTQ_DIR		:=	$(DATA_ANALYSIS_DIR)/01_raw_fastq
FASTQ_FILES		:=	$(FASTQ_DIR)/$(wildcard *.fastq)
GENOME_REF		:=	$(DATA_ANALYSIS_DIR)/02_genome_reference/sars_refgenome.fasta
GENOME_REF_IDX		:=	$(DATA_ANALYSIS_DIR)/02_genome_reference/sars_refgenome.idx
FASTQC_DIR		:=	$(DATA_ANALYSIS_DIR)/03_fastqc_output
FASTQC_FILES		:=	$(FASTQC_DIR)/$(wildcard *)
TRIMMED_DIR		:=	$(DATA_ANALYSIS_DIR)/04_trimmed_fastq
TRIMMED_FILES		:=	$(TRIMMED_DIR)/$(wildcard *.trim.fastq)
MAPPED_SAM_DIR		:=	$(DATA_ANALYSIS_DIR)/05_mapped_sam
MAPPED_SAM_FILES	:=	$(MAPPED_SAM_DIR)/$(wildcard *.sam)
MAPPED_BAM_DIR		:=	$(DATA_ANALYSIS_DIR)/06_mapped_bam
MAPPED_BAM_FILES	:=	$(MAPPED_BAM_DIR)/$(wildcard *.bam)
MAP_SORTED_BAM_DIR	:=	$(DATA_ANALYSIS_DIR)/07_mapped_sorted_bam
MAP_SORTED_BAM_FILES	:=	$(MAP_SORTED_BAM_DIR)/$(wildcard *.bam)
FLAGSTATS_DIR		:=	$(DATA_ANALYSIS_DIR)/08_flagstats
FLAGSTATS_FILES		:=	$(FLAGSTATS_DIR)/$(wildcard *.txt)
BCF_VAR_DIR		:=	$(DATA_ANALYSIS_DIR)/09_bcf_variants
BCF_VAR_FILES		:=	$(BCF_VAR_DIR)/$(wildcard *.bcf)
VCF_DIR			:=	$(DATA_ANALYSIS_DIR)/10_vcf_called
VCF_FILES		:=	$(VCF_DIR)/$(wildcard *.vcf)

# note these are in repo not in root /data
RUNTABLE_DIR		:=	data/00_sra_runtable
SRA_RUNTABLE		:=	$(RUNTABLE_DIR)/SraRunTable_PRJNA656695_short.txt
VCF_FOR_R_DIR		:=	data/11_vcf_output_for_R
VCF_FOR_R_FILES		:=	$(VCF_FOR_R_DIR)/$(wildcard *.vcf)

all: $(VCF_FOR_R_FILES) $(FLAGSTATS_FILES) $(FASTQC_FILES)

$(VCF_FOR_R_FILES): code/12_filter_vcf.sh $(VCF_FILES)
	bash code/12_filter_vcf.sh $(VCF_DIR)/*.vcf

$(VCF_FILES): code/11_create_vcf.sh $(BCF_VAR_FILES)
	bash code/11_create_vcf.sh $(BCF_VAR_DIR)/*.bcf

$(BCF_VAR_FILES): code/10_bcftools_mpileup.sh $(MAP_SORTED_BAM_FILES) $(GENOME_REF_FASTA) $(GENOME_REF_INDEX)
	bash code/10_bcftools_mpileup.sh $(MAP_SORTED_BAM_DIR)/*.bam

$(FLAGSTATS_FILES): code/09_flagstat.sh $(MAP_SORTED_BAM_FILES)
	bash code/09_flagstat.sh $(MAP_SORTED_BAM_DIR)/*.bam

$(MAP_SORTED_BAM_FILES): code/08_sort_bam.sh $(MAPPED_BAM_FILES)
	bash code/08_sort_bam.sh $(MAPPED_BAM_DIR)/*.bam

$(MAPPED_BAM_FILES): code/07_sam_to_bam.sh $(MAPPED_SAM_FILES)
	bash code/07_sam_to_bam.sh $(MAPPED_SAM_DIR)/*.sam

$(MAPPED_SAM_FILES): code/06_run_bwa.sh $(TRIMMED_FILES) $(GENOME_REF_FASTA) $(GENOME_REF_INDEX)
	bash code/06_run_bwa.sh $(TRIMMED_DIR)/*.trim.fastq

$(GENOME_REF_IDX): code/05_bwa_index.sh $(GENOME_REF)
	bash code/05_bwa_index.sh

$(TRIMMED_FILES): code/04_trim.sh $(FASTQ_FILES)
	bash code/04_trim.sh $(FASTQ_DIR)/*.fastq

$(FASTQC_FILES): code/03_fastqc.sh $(FASTQ_FILES)
	bash code/03_fastqc.sh $(FASTQ_DIR)/*.fastq

$(GENOME_REF): code/02_download_reference.sh
	bash code/02_download_reference.sh

$(FASTQ_FILES): code/00_setup_directories.sh code/01_download_fastq.sh $(SRA_RUNTABLE)
	bash code/00_setup_directories.sh
	bash code/01_download_fastq.sh $(SRA_RUNTABLE)

clean:
	rm -vf $(VCF_FOR_R_DIR)/*.vcf
	rm -vfr $(DATA_ANALYSIS_DIR)

.SECONDARY: $(FASTQ_FILES) $(GENOME_REF_FASTA) $(FASTQC_FILES) $(TRIMMED_FILES) $(GENOME_REF_INDEX) $(MAPPED_SAM_FILES) $(MAPPED_BAM_FILES) $(MAP_SORTED_BAM_FILES) $(FLAGSTATS_FILES) $(BCF_VAR_FILES) $(VCF_FILES)

.PHONY: all clean
