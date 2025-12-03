# Introduction to LearnStatsVis

## LearnStatsVis: Interactive Visualizations for Learning Statistics Concepts

The LearnStatsVis package provides functions to create sample data,
perform statistical tests, and generate visualizations for learning
statistics concepts with biological examples. It also includes a Shiny
app for interactive exploration.

### Overview

This package separates the computational and visualization components
from the interactive interface:

- R functions perform statistical computations and generate
  visualizations
- A Shiny app in the `shiny/` directory provides the interactive
  interface
- This structure allows for both programmatic use and interactive
  exploration

### Basic Usage

#### P-value Visualization

``` r
# Generate data for P-value visualization
pvalue_data <- generate_pvalue_data(
  n = 30, 
  mean_true = 0.5, 
  mean_null = 0, 
  sd = 1
)

# Create the visualization
pvalue_plot <- create_pvalue_plot(pvalue_data, mean_null = 0)
plot(pvalue_plot)
```

#### T-test Visualization

``` r
# Generate data for t-test visualization
ttest_data <- generate_ttest_data(
  n1 = 15, 
  n2 = 15, 
  mean1 = 0, 
  mean2 = 0.5
)

# Create the visualization
ttest_plot <- create_ttest_plot(ttest_data)
plot(ttest_plot)
```

#### ANOVA Visualization

``` r
# Generate data for ANOVA visualization
anova_data <- generate_anova_data(
  n1 = 10, 
  n2 = 10, 
  n3 = 10, 
  mean1 = 0, 
  mean2 = 0.5, 
  mean3 = 1
)

# Create the visualization
anova_plot <- create_anova_plot(anova_data)
plot(anova_plot)
```

### Running the Interactive Shiny App

To run the interactive Shiny application:

``` r
# From the package directory
shiny::runApp("shiny/")
```

The Shiny app allows you to: - Select different statistical concepts to
explore - Adjust parameters in real-time - See immediate visual
feedback - Access biological interpretations of results

### Available Function Categories

#### Data Generation Functions

These functions generate sample data for different statistical
scenarios: -
[`generate_pvalue_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_pvalue_data.md) -
For hypothesis testing -
[`generate_ttest_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_ttest_data.md) -
For comparing two groups -
[`generate_anova_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_anova_data.md) -
For comparing multiple groups -
[`generate_ci_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_ci_data.md) -
For confidence interval exploration -
[`generate_power_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_power_data.md) -
For power analysis -
[`generate_chisq_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_chisq_data.md) -
For chi-square tests -
[`generate_wilcox_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_wilcox_data.md) -
For Wilcoxon tests -
[`generate_regression_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_regression_data.md) -
For regression analysis

#### Visualization Functions

These functions create ggplot visualizations: -
[`create_pvalue_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_pvalue_plot.md) -
Visualizes P-value concepts -
[`create_ttest_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_ttest_plot.md) -
Visualizes t-test results -
[`create_anova_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_anova_plot.md) -
Visualizes ANOVA results -
[`create_ci_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_ci_plot.md) -
Visualizes confidence intervals -
[`create_power_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_power_plot.md) -
Visualizes power analysis -
[`create_chisq_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_chisq_plot.md) -
Visualizes chi-square tests -
[`create_wilcox_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_wilcox_plot.md) -
Visualizes Wilcoxon tests -
[`create_regression_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_regression_plot.md) -
Visualizes regression relationships -
[`create_residuals_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_residuals_plot.md) -
Visualizes regression residuals

### Biological Examples

All examples in this package use biological contexts such as: - Gene
expression comparisons between conditions - Drug treatment effects on
biological pathways - Population biology and ecological statistics -
Experimental design considerations

This makes statistical concepts more accessible and relevant to life
scientists.
