# This function pull out names genes and their locations from a gff genome
# annotation file so that they can more easily be used in other contexts

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# Takes a single argument, which is an annotation object (a data frame) that
# was read in by the function read_gff()

extract_genes_from_gff <- function(annotation_object) {

  # check input
  stopifnot(is.data.frame(annotation_object))

  # find the lines in the file that have the type "Gene"
  just_genes <- annotation_object[grepl("gbkey=Gene",
                                        annotation_object$attribute), ]

  # pull out the name of the gene from the more convoluted gff syntax
  just_genes_cleaned <- just_genes %>%
    dplyr::filter(feature == "gene") %>%
    dplyr::mutate(gene_name = sub(".*gene=(.+?);.*", # find gene name
                           "\\1",
                           attribute,
                           perl = TRUE)) %>%
    dplyr::select(start, end, gene_name) # just take the columns we want

  return(just_genes_cleaned)
}
