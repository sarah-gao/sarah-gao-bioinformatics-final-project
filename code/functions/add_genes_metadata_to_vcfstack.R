source("code/functions/assign_gene.R")

add_genes_metadata_to_vcfstack <- function(stacked_vcf,
                                           sra_runtable_path,
                                           cleaned_genes_table) {

  sra_runtable <- readr::read_csv(sra_runtable_path)

  merged_vcf <- stacked_vcf %>%
    dplyr::rowwise() %>%
    dplyr::mutate(gene = assign_gene(pos, cleaned_genes_table)) %>%
    dplyr::left_join(sra_runtable, by = c("sample" = "Run"))

  return(merged_vcf)
}
