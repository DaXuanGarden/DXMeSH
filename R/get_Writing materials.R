library(rmarkdown)
library(stringi)

# Auxiliary function: inserts text at a specific position in the string
substr_replace <- function(string, replacement, start, stop) {
  prefix <- substring(string, 1, start)
  suffix <- substring(string, stop + 1, nchar(string))
  return(paste0(prefix, replacement, suffix))
}

# Read the Markdown file
read_markdown <- function(file_path) {
  lines <- readLines(file_path, warn = FALSE, encoding = "UTF-8")
  return(paste(lines, collapse = "\n"))
}

# Write back to Markdown file
write_markdown <- function(text, file_path) {
  writeLines(text, con = file_path, useBytes = TRUE)
}

duplicate_brackets_and_contents_with_lines <- function(text) {
  #First process non-empty [] and its content
  modified_text <- gsub("(【[^】]+】)", "\n\n\\1\n\n\\1\n\n", text)
  # Next, process the empty "" tag, copy and add a third-level header tag to the second one
  modified_text <- gsub("【】", "\n\n【】\n\n### 【】\n\n", modified_text)
  return(modified_text)
}

# Add a secondary title after pairs of identical brackets
add_heading_after_identical_brackets_pair <- function(text) {
  # Use regular expressions to match level-2 headings
  headings_matches <- gregexpr("(?m)^## .*", text, perl = TRUE)
  headings_list <- regmatches(text, headings_matches)[[1]]

  # Match any characters inside 【】 brackets
  brackets_matches <- gregexpr("【[^】]*】", text)
  brackets_list <- regmatches(text, brackets_matches)[[1]]

  # If there are fewer than two headings or bracket tags, return the original text
  if (length(headings_list) < 1 || length(brackets_list) < 2) {
    return(text)
  }

  # Initialize an empty list to store the insertion positions and text
  insertions <- list()

  # Iterate over bracket tags
  for (i in seq(from = 1, to = length(brackets_list)-1)) {
    # Check if there are identical consecutive tags
    if (brackets_list[i] == brackets_list[i + 1]) {
      # Find the heading closest to the front of this pair of tags
      heading_index <- max(which(headings_matches[[1]] < brackets_matches[[1]][i]))
      # Extract the heading text
      heading_text <- substr(text, headings_matches[[1]][heading_index], headings_matches[[1]][heading_index] + attr(headings_matches[[1]], "match.length")[heading_index] - 1)
      # Remove the "## " to match the format
      heading_text <- gsub("## ", "", heading_text)
      # Calculate the insertion position
      insert_position <- brackets_matches[[1]][i + 1] + attr(brackets_matches[[1]], "match.length")[i + 1]
      # Store the position and text in the list
      insertions[[length(insertions) + 1]] <- list(position = insert_position, text = heading_text)
    }
  }

  # Insert the heading text in reverse order and add empty lines before and after
  for (insertion in rev(insertions)) {
    text <- substr_replace(text, paste0("\n\n", insertion$text, "\n\n"), insertion$position, insertion$position)
  }

  # Remove any extra empty lines at the end of the text
  text <- gsub("(\n)+$", "", text)

  return(text)
}

# Define a function to process text by adding ### before the second bracket of every pair with the same content
add_mark_to_second_bracket <- function(text) {
  # Split text into lines
  lines <- unlist(stringi::stri_split_lines(text))
  # Store the contents of brackets that have been found
  seen_brackets <- list()
  # Iterate over lines and add a mark if necessary
  for (i in seq_along(lines)) {
    # Detect the format 【...】 with content inside the brackets
    if (stringi::stri_detect_regex(lines[i], "【.+?】")) {
      bracket_content <- stringi::stri_match_first_regex(lines[i], "【(.+?)】")[,2]
      # Check if this bracket content has been encountered before
      if (!(bracket_content %in% seen_brackets)) {
        # If not encountered, add it to the list
        seen_brackets <- c(seen_brackets, bracket_content)
      } else {
        # If encountered before, add ###
        lines[i] <- stringi::stri_replace_first_fixed(lines[i], "【", "### 【")
      }
    }
  }
  # Reassemble the text lines
  return(paste(lines, collapse = "\n"))
}

# Main function to process the document and convert its format
get_Writing_materials <- function(input_file) {
  # Obtain the base name of the file without the extension
  base_name <- tools::file_path_sans_ext(basename(input_file))

  # Use regular expressions to match numbers at the end
  match <- regexec("-(\\d+)(\\.\\d+)?$", base_name)
  matched_groups <- regmatches(base_name, match)

  # If a matching number is found
  if (length(matched_groups[[1]]) > 1) {
    # Extract the major version number
    major_num <- as.numeric(matched_groups[[1]][2])
    # Increment the major version number
    major_num <- major_num + 1
    # Set the minor version number to 1
    minor_num <- 1
    # Construct the new file name
    output_base_name <- gsub("-(\\d+)(\\.\\d+)?$", paste0("-", major_num, ".", minor_num), base_name)
  } else {
    # If no matching number, initialize the major version number as 1 and minor version number as 1
    output_base_name <- paste0(base_name, "-1.1")
  }

  # Get the file extension
  file_ext <- tools::file_ext(input_file)

  # Reconstruct the complete file name including the extension
  output_file <- paste0(output_base_name, ".", file_ext)

  if (file_ext == "docx") {
    # Convert DOCX to MD
    md_file <- paste0(base_name, ".md")
    system(paste("pandoc -o", shQuote(md_file), "-f docx -t markdown", shQuote(input_file)))
    # Read the Markdown file
    md_text <- readLines(md_file)
    # Use regular expressions to replace all \[number\] or \[number, number\] in the text
    md_text <- gsub("\\\\\\[(.*?)\\\\\\]", "[\\1]", md_text)
    # Write back to the Markdown file
    writeLines(md_text, md_file)
    # Print the path
    print(md_file)
    input_file <- md_file
  } else if (file_ext != "md") {
    stop("Unsupported file type: ", file_ext)
  }

  # The following are the steps for text processing
  md_text <- read_markdown(input_file)

  md_text <- duplicate_brackets_and_contents_with_lines(md_text)
  md_text <- add_heading_after_identical_brackets_pair(md_text)
  md_text <- add_mark_to_second_bracket(md_text)

  # Assume final_text is the processed text
  final_text <- md_text  # You should apply your processing functions here

  # Write back to the Markdown file
  md_output_file <- paste0(output_base_name, ".md")
  write_markdown(final_text, md_output_file)

  # Convert back to Word document
  docx_output_file <- paste0(output_base_name, ".docx")
  # Assume you're using rmarkdown's render function here to render the document
  render(md_output_file, output_format = "word_document", output_file = docx_output_file)
  # Print the path
  print(md_output_file)
  print(docx_output_file)

  # Now, let's create the file names for the new version 2.2 copies
  md_copy_file <- sub("2.1", "2.2", md_output_file)
  docx_copy_file <- sub("2.1", "2.2", docx_output_file)

  # Copy the markdown file to the new version 2.2
  file.copy(md_output_file, md_copy_file)

  # Copy the Word document file to the new version 2.2
  file.copy(docx_output_file, docx_copy_file)

  # Print the paths of the newly copied files
  print(md_copy_file)
  print(docx_copy_file)

  # Print a friendly success message
  message("\n😊Congratulations! Your writing material was successfully processed!🎉\n")
}

