# This function returns the name of a gene if a SNP location (given as a numeric
# position in the genome) falls after the start and before the end of a gene
# The locations and names of genes come from the gff annotation file.

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# Takes two arguments, a location (which should be numeric) and a data frame
# that should contain the start, end, and name of genes in the genome
# of interest

assign_gene <- function(location, gene_lookup_table) {

  # check inputs for proper type
  stopifnot(is.numeric(location))
  stopifnot(is.data.frame(gene_lookup_table))

  # initialize gene name with NA
  gene_name <- NA

  # check each of the gene intervals for a match
  for (row in seq_len(nrow(gene_lookup_table))) {

    # assign the gene name to variable if there is a match
    if ((location >= gene_lookup_table$start[row]) &&
        (location <= gene_lookup_table$end[row])) {
      gene_name <- gene_lookup_table$gene_name[row]
    }

  }
  return(gene_name)
}
