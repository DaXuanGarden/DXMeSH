#' Auxiliary function: Inserts text at a specific position in the string
#'
#' @description
#' This function takes a string and inserts a replacement string between the start and stop positions.
#' @name substr_replace
#' @param string The original string.
#' @param replacement The string to be inserted.
#' @param start The starting position for the replacement.
#' @param stop The ending position for the replacement.
#' @return Returns a modified string with the replacement text inserted.
#' @export
#' @examples
#' substr_replace("The quick brown fox", "happy ", 10, 10)

library(rmarkdown)
library(stringi)
# Auxiliary function: inserts text at a specific position in the string
substr_replace <- function(string, replacement, start, stop) {
  prefix <- substring(string, 1, start)
  suffix <- substring(string, stop + 1, nchar(string))
  return(paste0(prefix, replacement, suffix))
}
#' Read the Markdown file
#'
#' @description
#' This function reads the content of a markdown file and returns it as a single string.
#' @name read_markdown
#' @param file_path The path to the markdown file.
#' @return Returns the content of the markdown file as a single string.
#' @export
#' @examples
#' read_markdown("example.md")


# Read the Markdown file
read_markdown <- function(file_path) {
  lines <- readLines(file_path, warn = FALSE, encoding = "UTF-8")
  return(paste(lines, collapse = "\n"))
}

#' Write back to Markdown file
#'
#' @description
#' This function writes a string of text back to a markdown file.
#' @name write_markdown
#' @param text The text to be written to the file.
#' @param file_path The path where the markdown file will be saved.
#' @return This function does not return a value.
#' @export
#' @examples
#' write_markdown("# New Markdown Content", "example.md")
# Write back to Markdown file
write_markdown <- function(text, file_path) {
  writeLines(text, con = file_path, useBytes = TRUE)
}
#' Duplicate Brackets and Their Contents with Lines
#'
#' @description
#' This function finds all occurrences of non-empty brackets and their contents within the text, duplicates them, and adds empty lines for spacing. It also processes empty brackets to include additional formatting.
#' @name duplicate_brackets_and_contents_with_lines
#' @param text The text containing brackets for duplication and formatting.
#' @return Returns the modified text with duplicated bracket contents and additional lines.
#' @export
#' @examples
#' duplicate_brackets_and_contents_with_lines("This is a test.【Content】More text.")
duplicate_brackets_and_contents_with_lines <- function(text) {
  #First process non-empty [] and its content
  modified_text <- gsub("(【[^】]+】)", "\n\n\\1\n\n\\1\n\n", text)
  # Next, process the empty "" tag, copy and add a third-level header tag to the second one
  modified_text <- gsub("【】", "\n\n【】\n\n### 【】\n\n", modified_text)
  return(modified_text)
}

#' Add a Secondary Title After Identical Brackets Pair
#'
#' @description
#' For pairs of identical bracketed contents, this function adds a secondary title after each pair to improve document structure and readability.
#' @name add_heading_after_identical_brackets_pair
#' @param text The text in which to identify and enhance pairs of identical brackets.
#' @return Returns the text with added secondary titles after each pair of identical brackets.
#' @export
#' @examples
#' add_heading_after_identical_brackets_pair("Text before.【Same】Text in between.【Same】Text after.")
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

#' Add Mark to Second Bracket of Every Pair with Same Content
#'
#' @description
#' This function adds a specific mark (###) before the second bracket of every pair that has identical content within the text, aiding in the emphasis or distinction of repeated elements.
#' @name mark_even_occurrences
#' @param text The text in which to mark the second bracket of each pair with identical content.
#' @return Returns the modified text with marks added before the second bracket of every identical pair.
#' @export
#' @examples
#' mark_even_occurrences("Some introductory text 【Bracket Content】 followed by more text and then 【Bracket Content】 again.")
# Add a secondary title after pairs of identical brackets
# Define a function to process text by adding ### before the second bracket of every pair with the same content
# Define a function to mark the even occurrences of each repeated title
mark_even_occurrences <- function(text, mark = "### ") {
  # Split the text by lines
  lines <- unlist(strsplit(text, "\n", fixed = TRUE))
  # Initialize a hash table for title counts
  title_counts <- list()

  # Iterate over each line of text
  for (i in seq_along(lines)) {
    # Current line
    line <- lines[i]
    # Check if the line matches the title pattern
    if (grepl("^【.*】$", line) && !grepl("^【\\s*】$", line)) {
      # Extract the title from the line
      title <- line
      # Initialize count for the title if it appears for the first time
      if (!title %in% names(title_counts)) {
        title_counts[[title]] <- 0
      }
      # Increment the count
      title_counts[[title]] <- title_counts[[title]] + 1
      # Mark the line if this is an even occurrence of the title
      if ((title_counts[[title]] %% 2) == 0) {
        lines[i] <- paste(mark, line, sep = "")
      }
    }
  }
  # Recombine all lines into a single string to return
  return(paste(lines, collapse = "\n"))
}


#' Normalize brackets and add a marker to the second occurrence within the text
#'
#' @description
#' This function is designed to clean up text by removing newlines within brackets,
#' replacing them with a single space, and then adding a special mark before the
#' second occurrence of each bracketed phrase. It is useful for processing and
#' standardizing text data that may have inconsistent formatting within bracketed terms.
#'
#' @name normalize_brackets_and_add_mark
#' @param text A single string of text that may contain bracketed terms with newlines.
#'
#' @return A string of text where newlines within brackets have been replaced with spaces,
#' and a marker has been added before the second occurrence of each bracketed term.
#'
#' @export
#'
#' @examples
#' sample_text <- "This is a sample text with newline characters \\n within【brackets \\n that span \\n multiple lines】."
#' normalize_brackets_and_add_mark(sample_text)
normalize_brackets_and_add_mark <- function(text) {
  # Use a regular expression to replace newlines within brackets with a space
  text <- gsub("【([^】]*)(\r?\n)+([^】]*)】", "【\\1 \\3】", text)

  # Now call the previously defined function 'mark_even_occurrences'
  text <- mark_even_occurrences(text)

  return(text)
}


#' Main function to process the document and convert its format
#'
#' @description
#' This function processes an input document, applies text processing functions, and saves the results in markdown and Word formats.
#' @name get_Writing_materials
#' @param input_file The path to the input file which should be processed.
#' @return This function does not return a value but saves processed output in specified formats.
#' @export
#' @examples
#' get_Writing_materials("Introduction-1.docx")

# Main function to process the document and convert its format
get_Writing_materials <- function(input_file) {
  input_file='Figure legends-1.docx'
  #input_file='Methods-1.docx'
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
    # Assuming Pandoc can handle images, add options as needed
    rmarkdown::pandoc_convert(input = input_file, output = md_file, to = "markdown", options = c("--extract-media=.", "--standalone"))
    # Read the Markdown file
    md_text <- readLines(md_file)
    # Use regular expressions to replace all \[number\] or \[number, number\] in the text
    md_text <- gsub("\\\\\\[(.*?)\\\\\\]", "[\\1]", md_text)
    # Write back to the Markdown file
    write_markdown(md_text, md_file)

    # message the path
    message(paste("🔥Successfully generated Markdown file：", basename(md_file)))

    message("\n😍The writing materials are ready!🐣\n")

    input_file <- md_file
  } else if (file_ext != "md") {
    stop("😭Unsupported file type: ", file_ext)
  }


  # The following are the steps for text processing
  md_text <- read_markdown(input_file)
  message("\n🤩Start sorting out your writing materials!🌱\n")
  md_text <- duplicate_brackets_and_contents_with_lines(md_text)
  md_text <- add_heading_after_identical_brackets_pair(md_text)
  md_text <- normalize_brackets_and_add_mark(md_text)
  #md_text <- mark_even_occurrences(md_text)
  # Assume final_text is the processed text
  final_text <- md_text  # You should apply your processing functions here

  # Write back to the Markdown file
  md_output_file <- paste0(output_base_name, ".md")
  write_markdown(final_text, md_output_file)

  # Convert back to Word document with images
  # This step should automatically handle image references in the Markdown file
  docx_output_file <- paste0(output_base_name, ".docx")
  rmarkdown::render(md_output_file, output_format = "word_document", output_file = docx_output_file)

  # message successfully generated filename messages
  message(paste("🔥Successfully generated Markdown file：", basename(md_output_file)))
  message(paste("🔥Successfully generated Word document：", basename(docx_output_file)))
  # Get the current working directory
  current_dir <- getwd()

  # Build full paths to source and destination files
  source_file1 <- file.path(current_dir, docx_output_file)
  target_file1 <- gsub("2.1", "2.2", source_file1)

  # Check whether the source file exists
  if (!file.exists(source_file1)) {
    stop("😭Source file does not exist: ", source_file1)
  }

  #Perform file copy to allow overwriting of target files
  file_copy_result1 <- file.copy(source_file1, target_file1, overwrite = TRUE)

  # message successfully generated filename messages
  if (file_copy_result1) {
    message(paste("🔥Successfully replicated", basename(source_file1), "as", basename(target_file1)))
  } else {
    message("😭File copying failed.Please check the file path and permissions.")
  }

  # Build full paths to source and destination files
  source_file2 <- file.path(current_dir, md_output_file)
  target_file2 <- gsub("2.1", "2.2", source_file2)

  # Check whether the source file exists
  if (!file.exists(source_file2)) {
    stop("😭Source file does not exist: ", source_file2)
  }

  #Perform file copy to allow overwriting of target files
  file_copy_result <- file.copy(source_file2, target_file2, overwrite = TRUE)

  # message successfully generated filename messages
  if (file_copy_result) {
    message(paste("🔥Successfully replicated", basename(source_file2), "as", basename(target_file2)))
  } else {
    message("😭File copying failed.Please check the file path and permissions.")
  }



  # Assuming you have variables md_output_file and docx_output_file already set with the file paths
  # Create the file names for the new blank version 2.3
  md_blank_file <- sub("2.1", "2.3", md_output_file)
  docx_blank_file <- sub("2.1", "2.3", docx_output_file)

  # Create a blank Markdown file version 2.3
  file.create(md_blank_file)

  # Now, convert the blank Markdown file to a blank Word document version 2.3
  library(rmarkdown)

  # Convert Markdown to Word document
  rmarkdown::render(input = md_blank_file,
                    output_format = "word_document",
                    output_file = docx_blank_file,
                    quiet = TRUE) # quiet = TRUE to suppress messages



  # 打印成功生成的文件名消息
  message(paste("🔥Successfully generated Markdown file：", basename(md_blank_file)))
  message(paste("🔥Successfully generated Word document：", basename(docx_blank_file)))


  # message a friendly success message
  message("\n😊Congratulations! Your writing materials were successfully processed!🎉\n")
}
