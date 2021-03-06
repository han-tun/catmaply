# ---------------------------------------------
# Testing plotting
context("utils")

test_that("Test discrete_coloring", {

  categories <- paste("Category", seq.int(5))
  col_palette <- viridis::magma(length(categories))

  dc <- discrete_coloring(categories = categories, col_palette =  col_palette)

  expect_true(is(dc, "list"))

  expect_true(length(dc) == 3)

  expect_true(all(names(dc) %in% c("colorscale", "tickvals", "ticktext")))

  expect_true(dim(dc$colorscale)[1] == length(categories) * 2)

  expect_true(dim(dc$colorscale)[2] == 2)

  expect_true(length(dc$tickvals) == length(categories) && length(dc$ticktext) == length(categories))

  expect_true(all(categories == dc$ticktext))

  expect_error(discrete_coloring(categories[1:3], col_palette))

  expect_error(discrete_coloring(categories, col_palette[1:4]))

  # factor
  categories <- as.factor(paste("Category", seq.int(5)))
  col_palette <- viridis::magma(length(categories))

  dc <- discrete_coloring(categories = categories, col_palette =  col_palette)
  expect_true(is(dc, "list"))
})


test_that("Test discrete_coloring with custom color ranges", {

  df <- vbz[[3]]

  categories <- paste("Category", seq.int(5))
  col_palette <- viridis::magma(length(categories) * 2)

  dc <- discrete_coloring(categories = categories, col_palette =  col_palette, range_max = max(stats::na.omit(df$occupancy)), range_min = min(stats::na.omit(df$occupancy)))

  expect_true(is(dc, "list"))

  expect_true(length(dc) == 3)

  expect_true(all(names(dc) %in% c("colorscale", "tickvals", "ticktext")))

  expect_true(dim(dc$colorscale)[1] == length(categories) * 2)

  expect_true(dim(dc$colorscale)[2] == 2)

  expect_true(length(dc$tickvals) == length(categories) && length(dc$ticktext) == length(categories))

  expect_true(all(categories == dc$ticktext))

  expect_error(discrete_coloring(categories[1:3], col_palette))

  expect_error(discrete_coloring(categories, col_palette[1:4]))

})

test_that("Test discrete_coloring input error handling", {

  df <- vbz[[3]]

  categories <- paste("Category", seq.int(5))
  col_palette <- viridis::magma(length(categories) * 2)

  expect_error(
    discrete_coloring(
      categories = as.list(categories),
      col_palette =  col_palette,
      range_max = max(stats::na.omit(df$Besetzung)),
      range_min = min(stats::na.omit(df$Besetzung))
    )
  )
  expect_error(
    discrete_coloring(
      categories = categories,
      col_palette =  as.list(col_palette),
      range_max = max(stats::na.omit(df$Besetzung)),
      range_min = min(stats::na.omit(df$Besetzung))
    )
  )


})
