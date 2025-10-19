# nf-test Paper

Code and data supporting the **nf-test** paper.

This repository contains all scripts, data, and analyses used to generate the main tables and figures in the publication.
Each section below describes how to reproduce the corresponding results.

## Table 1 and Table 2

### 1. Generate data

```bash
cd table1_2_fetchngs/bin
./01-test-modifications.sh
```

Generated data will be stored in:
`table1_2_fetchngs/data`

### 2. Create plots and tables

Render the R Markdown file in RStudio or in with this command:

```r
rmarkdown::render("table1_2_fetchngs/tables-and-figures.Rmd")
```

Output file:
`table1_2_fetchngs/tables-and-figures.docx`


## Table 3

### 1. Generate data

```bash
cd table3_sharding/bin
./01-sharding.sh
```

Generated data will be stored in:
`table3_sharding/data`

### 2. Create plots and tables

Render the R Markdown file in RStudio or in with this command::

```r
rmarkdown::render("table3_sharding/tables-and-figures.Rmd")
```

Output file:
`table3_sharding/tables-and-figures.docx`


## Figure 4

### 1. Generate data

```bash
cd figure4_modules/bin
./01-analyse-commits.sh
```

Generated data will be stored in:
`figure4_modules/data`

### 2. Create plots and tables

Render the R Markdown file in RStudio or in with this command:

```r
rmarkdown::render("figure4_modules/tables-and-figures.Rmd")
```

Output file:
`figure4_modules/tables-and-figures.docx`


## Notes

* All scripts are designed to run on Unix-like systems (Linux or macOS).
* Ensure that all required R packages and dependencies are installed before rendering the `.Rmd` files.
* The generated `.docx` files contain the final figures and tables used in the paper.
