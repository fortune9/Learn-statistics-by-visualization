test_that("P-value functions work", {
  # Test data generation
  pvalue_data <- generate_pvalue_data(n = 10, mean_true = 0.5, mean_null = 0, sd = 1)
  expect_type(pvalue_data, "list")
  expect_true(is.numeric(pvalue_data$sample_mean))
  
  # Test plot creation
  pvalue_plot <- create_pvalue_plot(pvalue_data, mean_null = 0)
  expect_s3_class(pvalue_plot, "gg")
})

test_that("T-test functions work", {
  # Test data generation
  ttest_data <- generate_ttest_data(n1 = 10, n2 = 10, mean1 = 0, mean2 = 0.5)
  expect_type(ttest_data, "list")
  expect_true(nrow(ttest_data$group_summary) == 2)
  
  # Test plot creation
  ttest_plot <- create_ttest_plot(ttest_data)
  expect_s3_class(ttest_plot, "gg")
})

test_that("ANOVA functions work", {
  # Test data generation
  anova_data <- generate_anova_data(n1 = 10, n2 = 10, n3 = 10, mean1 = 0, mean2 = 0.5, mean3 = 1)
  expect_type(anova_data, "list")
  expect_true(nrow(anova_data$group_summary) == 3)
  
  # Test plot creation
  anova_plot <- create_anova_plot(anova_data)
  expect_s3_class(anova_plot, "gg")
})

test_that("Confidence interval functions work", {
  # Test data generation
  ci_data <- generate_ci_data(true_mean = 0, sd = 1, n = 10, num_samples = 5)
  expect_type(ci_data, "list")
  expect_true(nrow(ci_data$data) == 5)
  
  # Test plot creation
  ci_plot <- create_ci_plot(ci_data)
  expect_s3_class(ci_plot, "gg")
})

test_that("Power analysis functions work", {
  # Test data generation
  power_data <- generate_power_data(effect_size = 0.5, n = 10, alpha = 0.05)
  expect_type(power_data, "list")
  expect_true(is.numeric(power_data$actual_power))
  
  # Test plot creation
  power_plot <- create_power_plot(power_data)
  expect_s3_class(power_plot, "gg")
})