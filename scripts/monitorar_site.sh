#!/usr/bin/env bash

# Anexando as variaveis locais
source variaveis.env

# Local do arquivo onde os logs serao gravados
ARQUIVO_LOG="/var/log/monitoramento.log"

# Resposta HTTP recebida da URL
RESPOSTA_HTTP=$(curl -o /dev/null -s -w "%{http_code}" $URL)

# Armazena a data atual para salvar na log do sistema
DATA_ATUAL=$(date "+%Y-%m-%d %H:%M:%S")

# Compara se a resposta HTTP recebida possui o codigo 200(OK)
if [ "$RESPOSTA_HTTP" -eq 200 ]; then
	# Grava a resposta como ok no arquivo de log
  	echo "$DATA_ATUAL - O SITE ESTA OPERANDO COMO O ESPERADO. Codigo: $RESPOSTA_HTTP" >> $ARQUIVO_LOG
else
	# Grava a resposta como falha no arquivo de log
  	echo "$DATA_ATUAL - FALHA AO ACESSAR O SITE. Codigo: $RESPOSTA_HTTP" >> $ARQUIVO_LOG
	curl -X POST -H 'Content-type: application/json' --data '{"text":"A aplicacao apresentou falha! Verifique o arquivo de log."}' $WEBHOOK 
fi
