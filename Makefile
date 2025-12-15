PYTHON := python3
VENV := .venv
PY := $(VENV)/bin/python
PIP := $(VENV)/bin/pip
BIN := $(VENV)/bin

.PHONY: help \
		setup setup-env setup-deps setup-dirs \
		run run-script \
		clean clean-cache clean-data \
		check-env check-dirs 
		# check-kaggle check-data \
		# fetch-data \
		# lint \
		# test 


help:
	@echo "make setup		Install dependencies and prepare environment"
	@echo "make run			Build project outputs and artifacts"
	@echo "make clean		Remove project builds"

setup: setup-env setup-deps setup-dirs

setup-env:
	@echo "Setting up environment"
	@test -d $(VENV) || $(PYTHON) -m venv $(VENV)

setup-deps:
	@$(PY) -m pip install -U pip
	@$(PIP) install -e .

setup-dirs:
	@mkdir -p data/raw data/interim data/processed

check-kaggle:
	@command -v kaggle >/dev/null 2>&1 || { echo "Missing kaggle CLI. Install and authenticate, or download dataset using README instructions."; exit 1; }

check-env:
	@test -x $(PY) || (echo "Missing $(PY). Run: make setup or create/activate an environment."; exit 1)
	
check-dirs:
	@test -d data || (echo "Missing data/. Run: make setup or create directories as per README.md"; exit 1)
	
fetch-data: check-kaggle check-env check-dirs
	@curl -fL "https://example.com/dataset_a.csv" -o "data/raw/dataset_a.csv"
	@curl -fL "https://example.com/data" -o "data/raw/dataset_b.zip"
	@unzip -o "data/raw/dataset_b.zip" -d "data/raw"
	@kaggle datasets download -d username/dataset_c -p data/raw --unzip
	@$(BIN)/repro-ingest-d --out data/raw/dataset_d.parquet

run: check-env check-dirs run-script # check-data
	@echo "Run Complete"
	
check-data:
	@test -f data/raw/dataset_a.csv || (echo "Missing required data: dataset_a"; exit 1)
	@test -f data/raw/dataset_b.parquet || (echo "Missing required data: dataset_b"; exit 1)
	@test -f data/raw/dataset_c.json || (echo "Missing required data: dataset_c"; exit 1)
	@test -f data/raw/dataset_d.parquet || (echo "Missing required data: dataset_d"; exit 1)

run-script: check-env
	@echo "Running Script"
	@$(BIN)/repro-script

test: check-env
	@$(PY) -m pytest -q
	
lint: check-env
	@$(PY) -m ruff check .
	@$(PY) -m black --check .
	
clean: clean-cache clean-data
	
clean-cache:
	@rm -rf __pycache__ .pytest_cache .ruff_cache
	
clean-data:
	@rm -rf data/interim data/processed data/raw # reports/artifacts