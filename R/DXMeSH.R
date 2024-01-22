#' DXMeSH: Create Comprehensive and Accurate Search Queries Based on MeSH
#'
#' @description
#' This function reads a CSV file of MeSH terms and their corresponding entries,
#' creates a search query for each keyword and combines all queries with an AND operation.
#' The final search query is saved in a text file named "query.txt".
#' @name dx_mesh
#' @param csv_file A string that specifies the path of the CSV file containing MeSH terms and their corresponding entries.
#' @return The function does not return a value but creates a "query.txt" file containing the final search query.
#' @export
#'
#' @examples
#' dx_mesh("DXMeSH.csv")
get_mesh <- function(csv_file) {
  library(readr)
  library(stringr)
  library(purrr)

  # Load the preprocessed data
  load_mesh_data <- function() {
    data_file <- system.file("data", "processed_data.RData", package = "DXMeSH")
    load(data_file, envir = .GlobalEnv)
  }
  load_mesh_data()

  # Read CSV file, identify column names
  data <- read_csv(csv_file)

  extract_mesh_and_entry <- function(topics) {
    mh_list_local <- mh_list[topics]
    mh_list_local <- mh_list_local[!sapply(mh_list_local, is.null)]
    if(length(mh_list_local) == 0){
      return(list(NULL, NULL))
    }
    mh <- names(mh_list_local)
    entries <- unlist(mh_list_local)
    return(list(mh, entries))
  }

  create_search_query <- function(df) {
    topics <- unlist(df[2:length(df)])
    topics <- topics[!is.na(topics) & topics != ""]
    lists <- extract_mesh_and_entry(topics)
    # If MH is not found, use it as a keyword module
    if (length(lists[[1]]) == 0) {
      cat(paste("\nWarning: MH not found for keyword(s):", topics, "\n")) # 使用 cat() 并添加换行符
      # Remove the quotes and return directly to the subject
      return(paste0('(', topics, ')'))
    }

    mh_query <- lists[[1]]
    entry_query <- lists[[2]]

    mh_query <- paste0('("', mh_query, '"[Mesh])')
    # If no free words are found, the MH query is still retained, but the free words section is skipped
    if (length(entry_query) == 0) {
      return(mh_query)
    } else {
      entry_query <- paste0('(', entry_query, ')')
    }

    queries <- c(mh_query, entry_query)
    final_query <- Reduce(function(x, y) { paste0('(', x, ' OR ', y, ')') }, queries)

    return(final_query)
  }

  queries <- apply(data, 1, create_search_query)
  final_query <- Reduce(function(x, y) { paste0('(', x, ' AND ', y, ')') }, queries)

  writeLines(final_query, "DXMeSH_query.txt")

  # Print a congratulations message
  cat("Congratulations on crafting your MeSH query!🎉\n")

  # Inform the user that the web page will be opened
  cat("We will now redirect you to PubMed to run this search query.🔍\n")

  # Read the query from file and print it
  cat("\nYour MeSH query👋:\n")
  cat(readLines("DXMeSH_query.txt"), sep="\n")

  # Insert a function call to open the PubMed search or similar, if applicable.


  # Loading the HTTR package
  library(httr)

  # Set your search terms
  search_terms <- final_query

  # Build PubMed's search URL
  pubmed_url <- paste0("https://pubmed.ncbi.nlm.nih.gov/?term=", search_terms)

  # Open the search URL in the default total page browser
  browseURL(pubmed_url)
}


