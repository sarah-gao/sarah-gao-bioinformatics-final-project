# Function to parse a folder of VCF files, tidy, and stack them

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# See great tutorial and documentation for vcfR here:
# https://knausb.github.io/vcfR_documentation/index.html

# Knaus, Brian J., and Niklaus J. Grunwald. 2017.
# VCFR: a package to manipulate and visualize variant
# call format data in R. Molecular Ecology Resources
# 17(1):44-53. http://dx.doi.org/10.1111/1755-0998.12549.

# The function takes a single argument, a directory name that has VCF files
# in it. It will get all of them, tidy them into rectangular form, and then
# stack them all into a single file for easier analysis

parse_tidy_and_stack_vcfs <- function(vcf_dir_path) {

  # check input
  stopifnot(is.character(vcf_dir_path))

  # get the names of all files in the target directory
  my_vcf_files <- list.files(path = vcf_dir_path,
                             pattern = "\\.vcf",
                             full.names = TRUE)

  # Initialize a 9 column empty matrix to append files to. This is the start
  # of the 'stack'
  all_vcf <- matrix(NA, 0, 9)

  # Loop over files and append to bottom of matrix
  # Add value for strain ID to first column each time
  for (vcf_file in my_vcf_files) {

    # read vcf file using function from package "vcfR"
    my_vcf_in <- vcfR::read.vcfR(vcf_file,
                                 verbose = FALSE)

    tidied_vcf <- vcfR::vcfR2tidy(my_vcf_in)

    # Check for correct filenames in dataset
    # Checks if file contains a string that doesn't start with SRR, DRR, or ERR
    # and also accommodates for empty arrays for files with no variants
    if (!grepl(x = tidied_vcf$gt$Indiv[1], pattern = "[SED]RR[0-9]*") &&
        !is.na(tidied_vcf$gt$Indiv[1])) {
          stop("The files don't seem to be named with SRR/ERR/DRR ids.")
    }
    
    # Show a message in case of empty file but keep running
    if (!is.na(tidied_vcf$gt$Indiv[1])) {
      print(paste("FYI: The file", tools::file_path_sans_ext(basename(vcf_file)),
            "is empty."))
    }

    # Pull strain name out of first part of filename, assuming SRR ID
    sample_name <- stringr::str_extract(string = tidied_vcf$gt$Indiv[1],
                                        pattern = "[SED]RR[0-9]*")

    # Bind column of strain name to rest of data for that
    # strain, pulled out of @fix slot in vcf object
    all_this_vcf <- cbind(rep(sample_name,
                              nrow(my_vcf_in@fix)),
                          my_vcf_in@fix)

    # Add this newly labeled data to bottom of matrix
    all_vcf <- rbind(all_vcf, all_this_vcf)
  }

  # Give the strain name column a proper column name
  colnames(all_vcf)[1] <- "SAMPLE"

  # Convert to df for use by dplyr and clean up column names for lintr
  all_vcf <- janitor::clean_names(dat = as.data.frame(all_vcf))

  # convert positions to numeric for gene calling
  all_vcf$pos <- as.numeric(all_vcf$pos)

  return(all_vcf)
}
