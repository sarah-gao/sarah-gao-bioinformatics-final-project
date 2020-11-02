extract_genes_from_gff <- function(annotation_object) {


  just_genes <- annotation_object[grepl("gbkey=Gene",
                                        annotation_object$attribute), ]


  just_genes_cleaned <- just_genes %>%
    dplyr::filter(feature == "gene") %>%
    dplyr::mutate(gene_name = sub(".*gene=(.+?);.*",
                           "\\1",
                           attribute,
                           perl = TRUE)) %>%
    dplyr::select(start, end, gene_name)

  return(just_genes_cleaned)
}
