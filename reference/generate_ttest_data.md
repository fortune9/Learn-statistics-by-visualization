# Generate sample data for t-test visualization

Generate sample data for t-test visualization

## Usage

``` r
generate_ttest_data(
  n1 = 15,
  n2 = 15,
  mean1 = 0,
  mean2 = 0.5,
  sd1 = 1,
  sd2 = 1,
  test_type = "two.sided",
  alpha = 0.05
)
```

## Arguments

- n1:

  Sample size for group 1

- n2:

  Sample size for group 2

- mean1:

  Mean for group 1

- mean2:

  Mean for group 2

- sd1:

  Standard deviation for group 1

- sd2:

  Standard deviation for group 2

- test_type:

  Type of test ("two.sided", "less", "greater")

- alpha:

  Significance level

## Value

A list containing the sample data and test statistics
