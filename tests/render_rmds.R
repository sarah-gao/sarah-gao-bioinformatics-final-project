# call rmarkdown on all .Rmd files
f <- list.files(recursive = TRUE)

rmds <- f[grepl(".Rmd$", f)]
r_scripts <- f[grepl(".R$", f)]

lapply(rmds, rmarkdown::render)


# output lints
for (rfile in r_scripts) {
  print(lintr::lint(rfile))
}

# expect no lints
for (rfile in r_scripts) {
  lintr::expect_lint(checks = NULL, file = rfile)
}


# output lints
for (rmdfile in rmds) {
  print(lintr::lint(rmdfile))
}

# expect no lints
for (rmdfile in rmds) {
  lintr::expect_lint(checks = NULL, file = rmdfile)
}
