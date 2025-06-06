test_that("publication_year() works", {
  expect_equal(publication_year(iris_dataset), as.character(1935))
  expect_warning(publication_year(iris_dataset, overwrite = FALSE) <- 1934)
})


value <- 1936

test_that("publication_year() <- assignment works", {
  iris_dataset_2 <- iris_dataset
  publication_year(x = iris_dataset_2, overwrite = TRUE) <- 1936
  expect_equal(publication_year(iris_dataset_2), as.character(1936))
})

test_that("publication_year()<- NULL results in :unas", {
  iris_dataset_2 <- iris_dataset
  publication_year(x = iris_dataset_2, overwrite = TRUE) <- 1999
  expect_equal(publication_year(x = iris_dataset_2), as.character(1999))
})
