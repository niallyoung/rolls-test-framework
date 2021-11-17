SHELL := /bin/bash

PROJECT_ROOT=$(PWD)

# TODO store in env/*.env and `source env/$ENV.env` as required in Make targets
PYTHON_VERSION=3.7
LANG="en_US.UTF-8"
POETRY_VIRTUALENVS_CREATE=false
POETRY_VIRTUALENVS_IN_PROJECT=true
POETRY_VIRTUALENVS_PATH=$(PROJECT_ROOT)/.venv
PYTHONPATH=$(PROJECT_ROOT)/python/

.PHONY: all describe clean venv install lint test test-single test-cover test-local

all: describe clean venv install lint test

describe:
	@echo "# make describe"
	@echo "PROJECT_ROOT="$(PROJECT_ROOT)
	@echo "ENV="$(ENV)
	@echo "PYTHON_VERSION="$(PYTHON_VERSION)
	@echo "LANG="$(LANG)
	@echo "PYTHONPATH="$(PYTHONPATH)
	@echo "POETRY_VIRTUALENVS_CREATE=$(POETRY_VIRTUALENVS_CREATE)"
	@echo "POETRY_VIRTUALENVS_IN-PROJECT=$(POETRY_VIRTUALENVS_IN-PROJECT)"
	@echo "POETRY_VIRTUALENVS_PATH=$(POETRY_VIRTUALENVS_PATH)"
	@echo "PIPENV_VENV_IN_PROJECT="$(PIPENV_VENV_IN_PROJECT)
	@echo "PIPENV_VERBOSITY="$(PIPENV_VERBOSITY)

clean:
	@echo "# make clean"
	rm -rf .venv

venv:
	@echo "# make venv"
	mkdir -p $(PROJECT_ROOT)/.venv
	python$(PYTHON_VERSION) -m venv .venv
	#python$(PYTHON_VERSION) -m venv --without-pip .venv  # TODO incompatible macOS but not Linux?

install: venv
	@echo "# make install"
	export POETRY_VIRTUALENVS_CREATE=$(POETRY_VIRTUALENVS_CREATE) && \
	export POETRY_VIRTUALENVS_IN_PROJECT=$(POETRY_VIRTUALENVS_IN_PROJECT) && \
	export POETRY_VIRTUALENVS_PATH=$(POETRY_VIRTUALENVS_PATH) && \
	source .venv/bin/activate && \
	poetry install

lint:
	@echo "# make lint"
	source .venv/bin/activate && \
	pylint -E python/

test:
	@echo "# make test-single"
	export PYTHONPATH=$(PYTHONPATH) && \
	export PROJECT_ROOT=$(PROJECT_ROOT) && \
	source .venv/bin/activate && \
	pytest -n 1 python/test --show-capture=stdout --random-order-bucket=global

test-parallel:
	@echo "# make test"
	export PYTHONPATH=$(PYTHONPATH) && \
	export PROJECT_ROOT=$(PROJECT_ROOT) && \
	source .venv/bin/activate && \
	pytest -n auto --show-capture=stdout python/test

test-cover:
	@echo "# make test-cover"
	export PYTHONPATH=$(PYTHONPATH) && \
	export PROJECT_ROOT=$(PROJECT_ROOT) && \
	source .venv/bin/activate && \
	pytest -n 1 --cov=python/src --cov-report=term python/test

run:
	@echo "# make run"
	export PYTHONPATH=$(PYTHONPATH) && \
	source .venv/bin/activate && \
	python python/src/rolls.py
