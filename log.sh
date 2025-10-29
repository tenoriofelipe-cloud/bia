# ------------------------------------------------------------
# Script: log.sh
# Descrição: Script para logging de eventos e mensagens.
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

# Função para logging
log_message() {
    echo "[${TIMESTAMP}] [${USER}] $1" >> "${LOG_FILE}"
}