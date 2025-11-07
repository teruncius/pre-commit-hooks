default:
    @just --list

hooks-setup: hooks-venv hooks-requirements hooks-install

hooks-venv:
    python -m venv venv

hooks-requirements:
    ./venv/bin/pip install -r requirements.txt

hooks-install:
    ./venv/bin/pre-commit install --overwrite
    ./venv/bin/pre-commit install --overwrite --hook-type commit-msg
