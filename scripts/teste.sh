#!/usr/bin/env bash

while true; do
    echo "Opcoes de depuracao:"
    echo "1. Rodar Monitoramento"
    echo "2. Parar processo do Nginx"
    echo "3. Status Nginx"
    echo "4. Exibir log"
    echo "5. Sair"
    
    read -p "Digite o número da opção: " opcao

    case $opcao in
        1)
            ./monitorar_site.sh
            echo "Rodando o monitoramento..."
            ;;
        2)
            sudo pkill -9 nginx
            echo "Finalizando o processo do Nginx..."
            ;;
	      3)
	          sudo systemctl status nginx
	          echo "Verificando status do Nginx..."
	          ;;
        4)
            cat /var/log/monitoramento.log
            ;;
	      5)
	          echo "Saindo..."
	          break
            ;;
        *)
            echo "Opcao invalida"
            ;;
    esac
done
