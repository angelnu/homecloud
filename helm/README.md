# Helm charts for home cloud
Contains helm charts to install via Makefile

## Requirements
- ansible must be installed
- ~/.vault_pass.txt must exists and contain the required ansible password
- microk8s installed

## Commands
- `make dep` to download all dependencies
- `make` to install all charts
- `make <chart name>` to install only one chart
- `make <chart name>-del` to remove the chart
- `make <chart name>-debug` to see what charts are installed

## Edit the encrypted seetings
- default editor - ansible-vault edit values-prod.yaml
- Visual Editor Code - EDITOR="code --wait" ansible-vault edit values-prod.yaml
- using alias (deployed by parent ansible install)- vault-edit values-prod.yaml
