#Script para fazer o build do React
#!/bin/bash


function build_react {  
    echo   "Iniciando o build do React..."
    printf "    Verificando o diretório da aplicação..."

    if [ ! -d "bia" ]; then
        echo -e "${RED}[ERRO]"
        echo "      Diretório 'bia' não encontrado!"
        log_message "Diretório 'bia' não encontrado"
        exit 1
    else
        echo -e "${GREEN}[OK]"
        cd bia
        printf "    Instalando dependências do React..."
        if ! npm install; then
            echo "${RED}[ERRO]"
            echo "      Falha ao instalar dependências do React!"
            log_message "Falha ao instalar dependências do React"
            exit 1
        else
            cd client && VITE_API_URL=http://bia-alb-714329563.us-east-1.elb.amazonaws.com npm run build
            echo "${GREEN}[OK]"
            log_message "Dependências do React instaladas com sucesso" 
        fi  
        echo "Build do React concluído com sucesso!"
        echo -e "${RESET}"
        log_message "Build do React concluído com sucesso"
        cd ../../

    fi
    
    
}

