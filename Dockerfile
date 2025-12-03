# Use the official R base image
FROM rocker/r-ver:4.5.1

# Install system dependencies required for R packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libcairo2-dev \
    libxt-dev \
    libv8-dev \
    wget \
    git \
    libxml2-dev \
    zlib1g-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R packages that are commonly needed
RUN install2.r --error --deps TRUE \
    shiny \
    ggplot2 \
    dplyr \
    stats \
    utils \
    methods \
    devtools \
    roxygen2 \
    testthat \
    knitr \
    rmarkdown \
    DT \
    plotly

# Set working directory
WORKDIR /app

# Copy the entire repository to the container
COPY . /app

# Install the LearnStatsVis package locally
RUN R -e "devtools::install('.', dependencies = FALSE)"

# Expose port for shiny server
EXPOSE 3838

# Set the command to run the Shiny app
CMD ["R", "-e", "shiny::runApp('/app/shiny', host = '0.0.0.0', port = 3838)"]