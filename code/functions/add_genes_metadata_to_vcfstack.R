# This function adds gene names to SNP locations and it also appends
# metadata from an SRA RunTable file using the Run ID to match on

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# it takes three parameters
# the first is the output from the parse_tidy_and_stack_vcfs() function, which
# is a data frame of stacked VCF data
# the second is a path to an SRA RunTable file with extra metadata; this file
# is generally downloaded directly from NCBI
# the third is a data frame containing the start and end and names of genes in
# the genome of interest

# this script uses the assign_gene() function to assign a gene name based on
# a genome position

source("code/functions/assign_gene.R")

add_genes_metadata_to_vcfstack <- function(stacked_vcf,
                                           sra_runtable_path,
                                           cleaned_genes_table) {
  # check inputs
  stopifnot(is.data.frame(stacked_vcf))
  stopifnot(is.character(sra_runtable_path))
  stopifnot(is.data.frame(cleaned_genes_table))

  # read in RunTable
  sra_runtable <- readr::read_csv(sra_runtable_path)

  # merge the data sources together, matching on the Sample and Run columns
  # which should contain the SRR ids
  merged_vcf <- stacked_vcf %>%
    dplyr::rowwise() %>% # key because the function is running on each row
    dplyr::mutate(gene = assign_gene(pos, cleaned_genes_table)) %>%
    dplyr::left_join(sra_runtable, by = c("sample" = "Run"))

  return(merged_vcf)
}
