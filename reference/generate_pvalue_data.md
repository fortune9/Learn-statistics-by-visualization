# Generate sample data for P-value visualization

Generate sample data for P-value visualization

## Usage

``` r
generate_pvalue_data(
  n = 30,
  mean_true = 0.5,
  mean_null = 0,
  sd = 1,
  test_type = "two.sided",
  alpha = 0.05
)
```

## Arguments

- n:

  Sample size

- mean_true:

  True mean under alternative hypothesis

- mean_null:

  Null hypothesis mean

- sd:

  Standard deviation

- test_type:

  Type of test ("two.sided", "less", "greater")

- alpha:

  Significance level

## Value

A list containing the sample data and test statistics
