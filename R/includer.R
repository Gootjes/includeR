
reinclude <- function(file) {
  if(!is.na(included(file))) {
    exclude(file)
  }
  include(file)
}

include <- function(file) {

  if(!is.na(included(file))) {
    stop("File already included")
  }

  e <- local({
    source(file, local = T)

    environment()
  })

  attach(e, name = paste0(
    "source:"
    ,file
  ))
}

included <- function(file) {
  n <- which(search() == paste0("source:", file))
  if(length(n)==0) NA
  else n
}

exclude <- function(file) {

  n <- included(file)

  if(is.na(n)) {
    stop("Not included")
  }

  detach(pos = n)

}

