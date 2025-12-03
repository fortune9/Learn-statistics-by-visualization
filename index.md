# LearnStatsVis: Interactive Visualizations for Learning Statistics Concepts

This R package provides functions to create sample data, perform
statistical tests, and generate visualizations for learning statistics
concepts with biological examples. It also includes a Shiny app that
provides an interactive interface to explore these concepts.

## Features

- Functions to create sample data for various statistical concepts
- Functions to perform statistical tests
- Functions to generate visualizations for key statistical concepts
- Interactive Shiny app for exploring different scenarios
- Biological examples throughout the applications
- Export visualizations for presentations or reports

## Installation

To install this package:

``` r
# Install required packages
install.packages(c("ggplot2", "dplyr", "shiny"))

# Install the LearnStatsVis package
# First, install from source directory:
devtools::install("path/to/Learn-statistics-by-visualization")
```

## Usage

The package provides functions for generating data and creating
visualizations for various statistical concepts:

### P-value Visualization

``` r
# Generate data for P-value visualization
pvalue_data <- generate_pvalue_data(n = 30, mean_true = 0.5, mean_null = 0, sd = 1)
# Create visualization
pvalue_plot <- create_pvalue_plot(pvalue_data, mean_null = 0)
plot(pvalue_plot)
```

### T-test Visualization

``` r
# Generate data for t-test visualization
ttest_data <- generate_ttest_data(n1 = 15, n2 = 15, mean1 = 0, mean2 = 0.5)
# Create visualization
ttest_plot <- create_ttest_plot(ttest_data)
plot(ttest_plot)
```

### ANOVA Visualization

``` r
# Generate data for ANOVA visualization
anova_data <- generate_anova_data(n1 = 10, n2 = 10, n3 = 10, mean1 = 0, mean2 = 0.5, mean3 = 1)
# Create visualization
anova_plot <- create_anova_plot(anova_data)
plot(anova_plot)
```

## Shiny App

The package also includes a Shiny app for interactive exploration of
these concepts:

``` r
# Run the Shiny app
shiny::runApp("shiny/")
```

The Shiny app allows users to: - Choose which statistical concept to
explore - Customize parameters for each concept - See real-time updates
in visualizations based on their inputs - Access biological
interpretations of results

## Available Functions

### Data Generation Functions:

- [`generate_pvalue_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_pvalue_data.md) -
  Generate data for P-value visualization
- [`generate_ttest_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_ttest_data.md) -
  Generate data for t-test visualization
- [`generate_anova_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_anova_data.md) -
  Generate data for ANOVA visualization
- [`generate_ci_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_ci_data.md) -
  Generate data for confidence interval visualization
- [`generate_power_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_power_data.md) -
  Generate data for power analysis
- [`generate_chisq_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_chisq_data.md) -
  Generate data for chi-square test
- [`generate_wilcox_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_wilcox_data.md) -
  Generate data for Wilcoxon test
- [`generate_regression_data()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/generate_regression_data.md) -
  Generate data for regression analysis

### Visualization Functions:

- [`create_pvalue_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_pvalue_plot.md) -
  Create P-value visualization
- [`create_ttest_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_ttest_plot.md) -
  Create t-test visualization
- [`create_anova_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_anova_plot.md) -
  Create ANOVA visualization
- [`create_ci_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_ci_plot.md) -
  Create confidence interval visualization
- [`create_power_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_power_plot.md) -
  Create power analysis visualization
- [`create_chisq_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_chisq_plot.md) -
  Create chi-square test visualization
- [`create_wilcox_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_wilcox_plot.md) -
  Create Wilcoxon test visualization
- [`create_regression_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_regression_plot.md) -
  Create regression analysis visualization
- [`create_residuals_plot()`](https://fortune9.github.io/Learn-statistics-by-visualization/reference/create_residuals_plot.md) -
  Create residuals plot for regression

## Technologies Used

- R for statistical computations and visualizations
- ggplot2 for creating high-quality charts and graphs
- dplyr for data manipulation
- Shiny for building interactive web applications
- HTML/CSS for front-end design
- JavaScript for enhancing interactivity

## Statistics Concepts Covered

- P values and hypothesis testing
- T-tests
- ANOVA
- Confidence intervals
- Statistical power analysis
- Chi-square tests
- Wilcoxon Ranksum test
- Regression analysis

## Docker Usage

You can run this application using Docker for easier setup and
deployment:

``` bash
# Build the Docker image
docker build -t learn-stats-vis .

# Run the container
docker run -p 3838:3838 learn-stats-vis
```

The application will be accessible at `http://localhost:3838`.

## Contributing

This is an open project to help biologists understand statistics better.
If you have suggestions for additional statistical concepts or
improvements, please contribute!

## License

MIT License

## Author

Zhenguo Zhang (<zhangz.sci@gmail.com>) GitHub: fortune9
