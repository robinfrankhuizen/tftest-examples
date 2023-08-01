# tftest examples

This repository contains a number of basic examples for [tftest](https://github.com/GoogleCloudPlatform/terraform-python-testing-helper)

## Setup

```bash
# Optional select python version
pyenv local 3.11

# Initialize python environment
poetry install

# connection to Azure
az login 

# Terraform initialize the 'fixture' folder
cd resource-group/test/fixture && terraform init

# Run the test:
poetry run pytest -v
```