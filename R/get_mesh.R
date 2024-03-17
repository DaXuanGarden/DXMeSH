#' get_mesh: Create Comprehensive and Accurate Search Queries Based on MeSH
#'
#' @description
#' This function reads a CSV file of MeSH terms and their corresponding entries,
#' creates a search query for each keyword and combines all queries with an AND operation.
#' The final search query is saved in a text file named "query.txt".
#' @name get_mesh
#' @param csv_file A string that specifies the path of the CSV file containing MeSH terms and their corresponding entries.
#' @return The function does not return a value but creates a "query.txt" file containing the final search query.
#' @export
#'
#' @examples
#' get_mesh("DXMeSH.csv")
#remotes::install_github("elizagrames/litsearchr",force = TRUE)
get_mesh <- function(topics) {
  #csv_file="DXMeSH_Lactate clock.csv"
  #topics <- c("Depression","Glycolysis","Inflammation")
  library(readr)
  library(stringr)
  library(purrr)

  # Load the preprocessed data
  load_mesh_data <- function() {
    data_file <- system.file("data", "processed_data.RData", package = "DXMeSH")
    load(data_file, envir = .GlobalEnv)
  }
  load_mesh_data()

  read_data <- function(input) {
    if (is.character(input) && length(input) == 1 && file.exists(input)) {
      # The input is a file path, try to read the CSV file
      data <- read_csv(input)
    } else if (is.vector(input)) {
      # The input is a vector, create a data frame
      data <- data.frame(Topics=input, stringsAsFactors = FALSE)
    } else {
      stop("Unsupported input type")
    }
    return(data)
  }

  # Since topics is a vector, it should go to the vector handling branch
  data <- read_data(topics)

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
    search_terms <- Reduce(function(x, y) { paste0('(', x, ' OR ', y, ')') }, queries)

    return(search_terms)
  }

  queries <- apply(data, 1, create_search_query)
  search_terms <- Reduce(function(x, y) { paste0('(', x, ' AND ', y, ')') }, queries)

  # Print a congratulations message
  cat("Congratulations on crafting your MeSH query!🎉\n")
  # Read the query from file and print it
  cat("\nYour MeSH query👋:\n")
  cat(search_terms, sep="\n")
  rm(mh_list, envir = .GlobalEnv)
  # Inform the user that the web page will be opened
  cat("We will now redirect you to PubMed to run this search query.🔍\n")
  # Build PubMed's search URL
  pubmed_url <- paste0("https://pubmed.ncbi.nlm.nih.gov/?term=", search_terms)

  open_url_decision <- function(pubmed_url) {
    decision <- readline(prompt="Do you want to open the URL in your default browser? [Y/N] 👀")

    if (toupper(decision) == 'Y') {
      browseURL(pubmed_url)
      cat("URL opened in browser.🎉\n")
    } else if (toupper(decision) == 'N') {
      cat("URL not opened.🐷\n")
    } else {
      cat("Invalid input. Please type 'Y' for Y or 'N' for No.😭\n")
      open_url_decision(pubmed_url)
    }
  }


  # 调用函数
  open_url_decision(pubmed_url)


  # 询问用户是否希望继续
  user_wants_to_continue <- readline(prompt = "Do you want to generate the PubMed results table? (Y/N): 👀")

  # 转换用户输入为小写，以便处理
  #user_wants_to_continue <- tolower(user_wants_to_continue)

  # 检查用户是否输入了'Y'，如果不是，立即停止脚本执行
  if (user_wants_to_continue != "Y") {
    cat("Operation aborted by the user.\n")
    stop("Script execution stopped.", call. = FALSE)
  }
  # Loading the HTTR package
  library(httr)
  cat("Generating the PubMed results table.🐷\n")
  folder_name <- paste0("DXMeSH_", format(Sys.time(), "%Y%m%d%H%M%S"))
  dir.create(folder_name)
  writeLines(search_terms, file.path(folder_name, "DXMeSH_query.txt"))
  pmid_list <- easyPubMed::get_pubmed_ids(search_terms)
  pm_xml <- easyPubMed::fetch_pubmed_data(pmid_list)
  Pubmed_results <- easyPubMed::table_articles_byAuth(pubmed_data = pm_xml,
                                                      included_authors = "first",
                                                      getKeywords = TRUE, max_chars = 500)
  library(writexl)
  write_xlsx(Pubmed_results, file.path(folder_name, "Pubmed_results.xlsx"))

  library(knitr)
  kable_data <- kable(Pubmed_results, format = "markdown")
  writeLines(kable_data, file.path(folder_name, "Pubmed_results.md"))

  cat("Files have been saved in the folder:", folder_name,"🤩")
  user_wants_term_analysis <- readline(prompt = "Do you want to perform term analysis? (Y/N): 👀")

  #user_wants_term_analysis <- tolower(user_wants_term_analysis)

  if (user_wants_term_analysis == "Y") {
    cat("Ongoing term analysis.🐷\n")
    ###Start drawing
    pm_terms_title <- litsearchr::extract_terms(text = Pubmed_results[,"title"],
                                                method = "fakerake", min_freq = 3, min_n = 2,
                                                stopwords = stopwords::data_stopwords_stopwordsiso$en)

    # Extract terms from keywords
    pm_terms_keywords <- litsearchr::extract_terms(keywords = trimws(unlist(strsplit(Pubmed_results[,"keywords"], ";"))),
                                                   method = "tagged", min_freq = 3, min_n = 1, max_n = 5)

    # Pool the extracted terms together
    pm_terms <- c(pm_terms_title, pm_terms_keywords)
    pm_terms <- pm_terms[!duplicated(pm_terms)]
    # Create Co-Occurrence Network
    pm_docs <- paste(Pubmed_results[, "title"], Pubmed_results[, "abstract"]) # we will consider title and abstract of each article to represent the article's "content"
    Pubmed_resultsm <- litsearchr::create_dfm(elements = pm_docs, features = pm_terms) # document-feature matrix
    pm_coocnet <- litsearchr::create_network(Pubmed_resultsm, min_studies = 3)

    library(ggplot2)
    library(ggraph)
    p1=ggraph::ggraph(pm_coocnet, layout = "stress") +
      coord_fixed() +
      expand_limits(x = c(-2, 2)) +
      geom_edge_link(aes(alpha = weight)) +
      geom_node_point(shape = "circle filled", fill = "white") +
      geom_node_text(aes(label = name), hjust = "outward", check_overlap = TRUE) +
      guides(edge_alpha = "none") +
      theme_void()
    # Prune the Network based on node strength
    pm_node_strength <- igraph::strength(pm_coocnet)
    pm_node_rankstrenght <- data.frame(term = names(pm_node_strength), strength = pm_node_strength, row.names = NULL)
    pm_node_rankstrenght$rank <- rank(pm_node_rankstrenght$strength, ties.method = "min")
    pm_node_rankstrenght <- pm_node_rankstrenght[order(pm_node_rankstrenght$rank),]

    pm_plot_strenght <-
      ggplot(pm_node_rankstrenght, aes(x = rank, y = strength, label = term)) +
      geom_line(lwd = 0.8) +
      geom_point() +
      ggrepel::geom_text_repel(size = 3, hjust = "right", nudge_y = 3, max.overlaps = 30) +
      theme_bw()
    #p2=pm_plot_strenght
    # Cumulatively - retain a certain proportion (e.g. 80%) of the total strength of the network of search terms
    pm_cutoff_cum <- litsearchr::find_cutoff(pm_coocnet, method = "cumulative", percent = 0.8)
    # Changepoints - certain points along the ranking of terms where the strength of the next strongest term is much greater than that of the previous one
    pm_cutoff_change <- litsearchr::find_cutoff(pm_coocnet, method = "changepoint", knot_num = 3)

    p2=pm_plot_strenght +
      geom_hline(yintercept = pm_cutoff_cum, color = "#f1707d", lwd = 0.7, linetype = "longdash", alpha = 0.6) +
      geom_hline(yintercept = pm_cutoff_change, color = "#F5D2A8", lwd = 0.7, linetype = "dashed", alpha = 0.6)
    #if (!requireNamespace("patchwork", quietly = TRUE)) install.packages("patchwork")
    library(patchwork)
    # 水平拼接
    p <- p1 + p2 + plot_layout(ncol = 2)
    p
    #p <- p1 / p2
    ggsave(file.path(folder_name, "Term_Analysis.png"), plot = p, width = 10, height = 5)
  } else {
    cat("Skipping term analysis.🐷\n")
  }
  #return(Pubmed_results)
  cat("Congratulations, you're done using DXMeSH.🎉\n")
}
