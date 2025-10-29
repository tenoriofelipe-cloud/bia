#!/bin/bash

# ------------------------------------------------------------
# Script: deploy.sh
# Descrição: Script para fazer o deploy de uma aplicação React e depois subir para o Bucket S3.
# Uso: ./deploy.sh [bucket_name]
# Requisitos: AWS CLI instalado e configurado com credenciais válidas e node configurado.
# Autor: Bruno Salmito
# Data: 18/08/2025
# Versão: 1.0
# ------------------------------------------------------------

# Inclusão do arquivo de variáveis
if [ ! -f "variables.sh" ]; then
    echo  "[ERRO] Arquivo 'variables.sh' não encontrado!"
    exit 1
else
    source variables.sh
fi

# Limpa a tela e exibe a mensagem de boas-vindas
clear
echo -e "${CYAN}"
echo "-------------------------------------------------"
echo "Olá $USER - Você está executando [$0]"
echo "Data: $(date +%d/%m/%Y)"
echo "Executando deploy da aplicação React [BIA]..."
echo "-------------------------------------------------"
echo -e "${RESET}" 

# Inclusão de arquivos base

printf "Verificando arquivos de base..."

if [ ! -f "log.sh" ] || [ ! -f "s3.sh" ] || [ ! -f "react.sh" ]; then
    echo -e "${RED}[ERRO]${RESET} Arquivo(s) de base não encontrado(s)!"
    exit 1
else
    echo -e "${GREEN}[OK]${RESET}"
    source log.sh
    source s3.sh
    source react.sh
    #log_message "Arquivo(s) base adicionado(s) com sucesso"
fi

# Informa que um novo build e syncronização serão realizados
log_message "*************************************************************************"
log_message "Iniciando novo build e sincronização com S3"
log_message "Usuário: $USER"
log_message "Data: $(date +%d/%m/%Y)"
log_message "Hora: $(date +%H:%M:%S)"
log_message "Iniciando deploy da aplicação React [BIA]"
log_message "AWS Account: $AWS_ACCOUNT"   

# Função para exibir ajuda
show_help() {
    echo -e "${RED}----------------------------------------------------------"
    echo -e "${GREEN}Uso: $0 [Ambiente] [--help]"
    echo ""
    echo -e "${CYAN}Exemplos:"
    echo "  $0 --help"
    echo "  $0 hom"
    echo "  $0"
    echo "  $0 s3://meu-bucket"
    echo -e "${RED}----------------------------------------------------------"
    echo -e "${RESET}"
    log_message "Help menu displayed"
}

# Verificar se foi solicitada ajuda
if [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

#Executar build do React
build_react

sync_to_s3

# Carregar scripts necessários
#if [ ! -f "react.sh" ]; then
#    echo -e "${RED}[ERRO]${RESET} Arquivo 'react.sh' não encontrado!"
#    log_message "Arquivo 'react.sh' não encontrado"
#    exit 1
#else
#    echo -e "${GREEN}[OK]${RESET} Arquivo 'react.sh' encontrado!"
#    log_message "Arquivo 'react.sh' encontrado"
#    source react.sh
#fi

#if [ ! -f "s3.sh" ]; then
#    echo -e "${RED}[ERRO]${RESET} Arquivo 's3.sh' não encontrado!"
#    log_message "Arquivo 's3.sh' não encontrado"
#    exit 1
#else
#    echo -e "${GREEN}[OK]${RESET} Arquivo 's3.sh' encontrado!"
#    log_message "Arquivo 's3.sh' encontrado"
#    source s3.sh
#fi

# Executar build do React
#echo -e "${CYAN}Iniciando processo de build...${RESET}"
#build_react

# Perguntar se deseja sincronizar com S3
#echo ""
#read -p "Deseja sincronizar com S3? (y/n): " -n 1 -r
#echo ""
#if [[ $REPLY =~ ^[Yy]$ ]]; then
#    # Usar bucket passado como parâmetro ou solicitar entrada
#    if [ -n "$1" ]; then
#        bucket_name="$1"
#    else
#        read -p "Digite o nome do bucket (ou pressione Enter para usar 's3://teste25'): " bucket_name
#    fi
    
#    sync_to_s3 "$bucket_name"
#else
#    echo -e "${YELLOW}Deploy concluído sem sincronização S3${RESET}"
#    log_message "Deploy concluído sem sincronização S3"
#fi

#echo -e "${GREEN}Deploy finalizado!${RESET}"