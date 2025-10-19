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

Details:

* Clones the **nf-core/fetchngs** GitHub repository (if not already present in `./fetchngs`).
* Checks out the specific release version **1.12.0** for reproducibility.
* Runs a full `nf-test test` across all modules with coverage and dependency graph generation
* Reads a list of experiment configurations from `../modifications.txt`, where each line defines a test name, description, and related files.
* For each experiment:
  * Runs `nf-test test` for the specified related tests.
  * Annotates timing results with the experiment name using `csvtk`.
  * Saves annotated results as individual CSV files.
* Merges all experiment results into a single summary file `tests.times.modifications.txt`.


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

Details:

* Clones the **genepi/nf-gwas** GitHub repository (if not already present in `./nf-gwas`).
* Checks out the specific release version **v1.05** for reproducibility.
* Runs a baseline `nf-test test`, saving timing results to `../../data/baseline.times.txt`.
* Defines **5 shards** (`chunks=5`) to evaluate performance under different parallelization strategies.
* For each shard:
  * Runs `nf-test test` using two sharding strategies:
    * `"none"` (no sharding)
    * `"round-robin"` (distributes tests evenly across shards)
  * Annotates each result with the shard number and strategy using `csvtk`.
* Merges all annotated shard results into a single summary file.


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
`figure4_modules/data/tests.times.modifications.txt`

Details:

* Clones the **nf-core/modules** GitHub repository.
* Checks out a specific commit (`ca199cf`, from 2024-02-23) to use as the starting point.
* Iteratively goes back through **500 previous commits**, performing analyses on each one.
* For each commit:
  * Runs `nf-test test` twice — once for changed modules (`--changed-since HEAD^`) and once for all modules.
  * Uses `csvtk` to annotate output files with metadata (`version`, `setup`, and `version_date`).
  * Saves annotated timing data into the `../../data` directory.
* After all iterations, concatenates all annotated result files into a single summary file `tests.times.modifications.txt`.



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
