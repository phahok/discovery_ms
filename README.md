# DESCRIÇÂO

## Discovery MS

Automação para extração de dados do ambiente de aplicações SAS  

## Pre reqs:

- Git versão 1.8+ 
- Porta 22 deve ser liberada para clone do repositório via SSH. 
- O firewall precisa estar desativado para rodar os processos do SAS.
- Criação e inclusão de chave SSH no Azure, caso não exista:
- ssy-keygen -t RSA -C "<Conta do Azure>"


## Instruções de uso

1. Clonar o repositório discovery_ms do azure repos
[a link] (https://JoseRenatoFerreira@dev.azure.com/JoseRenatoFerreira/SAS_MS_TEAM/_git/discovery_ms)

- Opções para clone: HTTPS ou SSH

2. Os programas estão distribuídos na seguinte estrutura:
- ExtracaoDados.sh 
Nesse script são feitas as extrações das informações que aparecerão no discovery. 
As informações são gravadas em arquivos texto que serão lidos pelo script de processamento.

- ProcessamentoDados.sh
O script de processamento constroi os datasets SAS a partir dos dados de entrada coletados pelo script de extração.
- RelatorioDados.sh

- Discovery_Main.sh

