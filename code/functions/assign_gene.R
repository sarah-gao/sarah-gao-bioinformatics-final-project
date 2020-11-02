assign_gene <- function(location, gene_lookup_table) {

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
