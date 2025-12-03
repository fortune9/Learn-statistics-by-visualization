# Makefile for LearnStatsVis package

# Variables
RSCRIPT = Rscript
PKG_NAME = LearnStatsVis
PKG_DIR = .
BUILD_DIR = build

# Default target
all: build

# Build the package
build:
	@echo "Building package $(PKG_NAME)..."
	R CMD build .

# Check the package
check: build
	@echo "Checking package $(PKG_NAME)..."
	R CMD check --no-manual --as-cran $(PKG_NAME)_*.tar.gz

# Install the package locally
install: build
	@echo "Installing package $(PKG_NAME)..."
	R CMD INSTALL $(PKG_NAME)_*.tar.gz

# Document using roxygen2
document:
	@echo "Generating documentation..."
	$(RSCRIPT) -e "devtools::document()"

# Run tests
test:
	@echo "Running tests..."
	$(RSCRIPT) -e "devtools::test()"

# Clean built files
clean:
	@echo "Cleaning build files..."
	rm -rf $(BUILD_DIR) $(PKG_NAME)_*.tar.gz
	rm -rf $(PKG_NAME).Rcheck/

# Generate vignettes
vignettes:
	@echo "Building vignettes..."
	$(RSCRIPT) -e "devtools::build_vignettes()"

# Run the Shiny app for development
run_shiny:
	@echo "Starting Shiny app..."
	$(RSCRIPT) -e "shiny::runApp('shiny/')"

# Build pkgdown site
pkgdown:
	@echo "Building pkgdown site..."
	$(RSCRIPT) -e "pkgdown::build_site()"

# Show help
help:
	@echo "Available targets:"
	@echo "  all        - Build the package (default)"
	@echo "  build      - Build the package"
	@echo "  check      - Check the package"
	@echo "  install    - Install the package"
	@echo "  document   - Generate documentation"
	@echo "  test       - Run tests"
	@echo "  clean      - Clean build files"
	@echo "  vignettes  - Build vignettes"
	@echo "  run_shiny  - Run the Shiny app"
	@echo "  pkgdown    - Build pkgdown site"
	@echo "  help       - Show this help message"

.PHONY: all build check install document test clean vignettes run_shiny pkgdown help