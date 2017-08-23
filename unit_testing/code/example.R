### Convert a list to a data frame

# Input: object of class list
# Output: object of class data.frame

# Calculate length of longest element in a list
get_max_element_length <- function(input_list){
  max_entry <- max(unlist(lapply(input_list, length)))
  return(max_entry)
} # get_max_element_length(input_list)

# Extend a list element to a specified length
extend_element <- function(list_element, length_to_extend){
  # Calculate difference between current element length and length to extend
  difference <- length_to_extend - length(list_element)
  # Create string of NAs to append
  to_add <- rep(NA, times = difference)
  # Append to original element and return
  extended_element <- append(list_element, to_add)
  return(extended_element)
} # extend_element(list_element, length_to_extend)


list_to_df <- function(input_list){
  if (class(input_list) != "list"){
    stop("Input is not list")
  } # if
  # Get length of longest list element (should be numeric)
  max_entry <- get_max_element_length(input_list)
  
  # Apply element extension to each element of list
  extended_list <- lapply(input_list, function(x,y) extend_element(x, max_entry))
  
  # Convert to data.frame
  output_df <- as.data.frame(extended_list)
  return(output_df)
} # list_to_df(input_list)
