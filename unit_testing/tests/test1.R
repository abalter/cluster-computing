# Tests for example.R

# Create dummy list
my.list <- list("Element.1" = c("A", "B", "C", "D", "E"), "Element.2" = c("AA", "BB"),
                "Element.3" = c("AAA", "BBB", "CCC"))
not.list.1 <- seq(1,5)
not.list.2 <- c("A", "B", "C")

# Error if input is not a list
expect_error(list_to_df(not.list.1))
expect_error(list_to_df(not.list.2))

# Ensure length to extend is an integer
expect_type(get_max_element_length(my.list), "integer")
expect_equal(length(get_max_element_length(my.list)), 1)

# Each list element should be a character vector
expect_type(extend_element(my.list[[1]], 5), "character")
expect_false(is.numeric(extend_element(my.list[[1]], 5)))

# Final data.frame nrow should equal maximum length of list element
expect_equal(length(list_to_df(my.list)[,1]), get_max_element_length(my.list))

# Final data.frame ncol should equal number of elements of list
expect_equal(length(list_to_df(my.list)[1,]), length(my.list))

