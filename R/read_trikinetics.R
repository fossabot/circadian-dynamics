#' Import data from a Trikinetics tsv
#' @param file a path to a Trikinetics file. If no path is supplied, a GUI will open and help with file selection.
#' @export
#'
#' @examples
#' trikinetics_data <- read_trikinetics()
#'
read_trikinetics <- function(file = NULL){

##### Flow Control #####
  #Allow for using a GUI to choose the file, if one is not supplied
  if (is.null(file)) {
  file <- file.choose()
  }

# Import the file
  df <- read_tsv(file,col_names = FALSE)
  df <- df[,-c(1,4:9)]
  df <- unite(df, "datetime", c(1:2), sep = " ") %>% mutate(datetime = parse_date_time(datetime, orders = "d m y H:M:S"))
  names(df) <- c("datetime", "dd", paste0("IND ",1:(ncol(df)-2)))
  return(df)
}
