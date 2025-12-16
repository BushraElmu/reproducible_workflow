# Reproducible Project Structure and Workflow

A minimal repository that demonstrates an efficient and reproducible workflow and project structure for data projects: **clone -> setup -> run -> clean**, with clear data provenance and predictable outputs.

## 90-second reproduce
make setup
make run

Expected Output: prints 'Script has been run.'
Cleanup: make clean

## What this repo demonstrates
* A standard data / analytics repo layout (code, data, notebooks, reports, docs, tests)
* A simple command-line environment setup via make
* A consistent Makefile contract (setup, run, clean; (optional fetch-data, lint, test)

This Repository is intentionally not an analytics project. The output is the working workflow + structure.

## What to open first
* Makefile – the command-line runnable build tool
* README.md	– formatted guide to the reproducibility structure
* src/repro/ – example working package layout
* data/data.md – dataset provenance, licensing, and required raw files

# Outputs

This repository produces minimal outputs (by design):

* command-line system logs

Output locations:

* command-line interface

## Quickstart
Requirements

* Python 3.13+ recommended
* macOS / Linux / WSL recommended for Makefile path
	- Windows: use WSL or run equivalent commands manually

### Setup Environment

**make setup**

OR

1. create and activate venv
2. install dependencies as per pyproject.toml
3. and if necessary create data/raw, data/interim, & data/processed directories

### Run the project

**make run**

OR

python3 src/repro/script

### Clean generated outputs

**make clean**

OR

1. rm -rf __pycache__ .pytest_cache .ruff_cache
2. rm -rf data/interim data/processed data/raw

## Make targets

**make help** - view the intended available targets.

**make setup** - Creates .venv, installs the dependencies into the venv, and creates directories.

**make run** - Builds project outputs and artifacts.

**make clean** - Removes built outputs and artifacts.

(NOT APPLICABLE) *make test* - Runs pytest to run tests.

(NOT APPLICABLE) *make fetch-data* - Downloads raw datasets into data/raw/

(NOT APPLICABLE) *make lint* - Runs ruff and black to lint and format code.

## Clean Semantics

This section is the source of truth for what '**make clean**' deletes.

* make clean removes the raw, interim and processed data directories.

## Data

This repo uses data/data.md as the source of truth for:

* data provenance (URLS/sources)
* licensing acknowledgements and constraints
* required filenames for reproducibility

see: data/data.md

### Expected Raw Files

Example:

* data/raw/dataset.csv

## Repository Structure

 src/
	 repro/
		 __init__.py
		 script.py
 data/
	 data.md
	 raw/
	 interim/
	 processed/
 notebooks/
 reports/
 docs/
 tests/
 README.md
 LICENSE
 pyproject.toml
 poetry.lock
 .env.example
 Makefile

## Reproducibility Decisions

#### Why pyproject.toml
Dependencies are declared in pyproject.toml to be installable via: 'pip install -e .'

See '**make setup**'


#### Why Makefile

The Makefile ios a short, simple interface that:

* is highly easy and efficient to run
* makes execution predictible for reviewers and cloners
* standarizes the workflow across projects

Make is not required to understand the code. It is a convenience layer that defines a stable build design.

## Troubleshooting

make run fails with missing Python / venv

* Run: make setup

dependency install issues
* Confirm you are using the venv Python: .venv/bin/python --version

## License

Code License is an Apache-2.0 License under 'LICENSE'

Data Licensing Depends on upstream sources; see data/data.md for dataset-specific licensing and redistribution constraints.

## Acknowledgements
example: list external tools/datasets here.