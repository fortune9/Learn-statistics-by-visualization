# Generate sample data for chi-square test visualization

Generate sample data for chi-square test visualization

## Usage

``` r
generate_chisq_data(
  observed = c(10, 15, 20, 25),
  expected = NULL,
  alpha = 0.05
)
```

## Arguments

- observed:

  Observed frequencies

- expected:

  Expected frequencies (optional, if not provided will be calculated)

- alpha:

  Significance level

## Value

A list containing chi-square test results and visualization data
