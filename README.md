# Servidor-Linux-Com-monitoramento-AWS

Este projeto utiliza a infraestrutura da AWS em conjunto com o NGINX para fornecer uma solução de gerenciamento e automação de monitoramento atraves de logs e notificações. O NGINX é configurado como servidor web e balanceador de carga, garantindo alta disponibilidade e desempenho. O monitoramento e feito atraves de um script em Bash que realiza chamadas HTTP para o dominio do site, rodando de maneira automatizada atraves do cron. Notificações em tempo real são enviadas automaticamente os supervisores do projeto atraves de um WebHook do Slack, permitindo respostas rápidas a incidentes e garantindo a continuidade do serviço.

---

# ETAPA1: Configuração do Ambiente CLoud AWS

Este tutorial irá guiá-lo através do processo de criação de uma VPC na AWS, configuração de sub-redes públicas e privadas, e criação de uma instância EC2 com acesso via SSH.

---

## 1. Criar uma VPC na AWS

### 1.1. Criar a VPC
1.1.1 Acesse o [Console AWS](https://aws.amazon.com/console/) e navegue até a seção **VPC**.
1.1.2 Clique em **Create VPC** e siga as instruções.
   - Defina um **CIDR Block** (por exemplo, `10.0.0.0/16`).
   - Escolha um nome para a sua VPC.

### 1.2. Criar Sub-redes Públicas e Privadas

1.2.1. No painel **VPC Dashboard**, clique em **Subnets** e depois em **Create subnet**.
1.2.2. Crie **2 sub-redes públicas**:
   - Sub-rede 1: `10.0.1.0/24` (exemplo de sub-rede pública 1).
   - Sub-rede 2: `10.0.2.0/24` (exemplo de sub-rede pública 2).
   
1.2.3. Crie **2 sub-redes privadas** para futuras expansões:
   - Sub-rede 3: `10.0.3.0/24` (exemplo de sub-rede privada 1).
   - Sub-rede 4: `10.0.4.0/24` (exemplo de sub-rede privada 2).

### 1.3. Criar uma Internet Gateway

1.3.1. No painel **VPC Dashboard**, clique em **Internet Gateways** e depois em **Create Internet Gateway**.
1.3.2. Dê um nome para o **Internet Gateway** e clique em **Create**.
1.3.3. Após a criação, clique em **Attach to VPC** e selecione a VPC criada anteriormente.

---

## 2. Criar uma Instância EC2 na AWS

### 2.1. Escolher uma AMI baseada em Linux

2.1.1. Acesse a seção **EC2** no AWS Management Console e clique em **Launch Instance**.
2.1.2. Escolha uma **Amazon Machine Image (AMI)** baseada em Linux, como **Ubuntu**, **Debian** ou **Amazon Linux**.
2.1.3. Selecione o tipo de instância desejado (por exemplo, **t2.micro** para fins de teste).

### 2.2. Instalar na Sub-rede Pública

2.2.1. Durante a configuração da instância, em **Network**, selecione a **VPC** e a **sub-rede pública** (ex: `10.0.1.0/24`).
2.2.2. Ative a opção **Auto-assign Public IP** para garantir que sua instância tenha um IP público.

### 2.3. Associar um Security Group

2.3.1. Crie um novo **Security Group** ou selecione um existente.
2.3.2. Adicione as seguintes regras de entrada:
   - **HTTP (porta 80)**: permitir tráfego de qualquer origem.
   - **SSH (porta 22)**: permitir tráfego de sua rede (opcional, se desejar restringir o acesso via SSH).

---

## 3. Acessar a Instância via SSH

### 2.1. Comando para acesso via SSH

2.1.1. Acesse um terminal Linux.
2.1.2. Verifique o caminho da sua chave de acesso
2.1.3. utilize `ssh -i /caminho/para/sua-chave.pem ami@ip-da-instancia`
   - **/caminho/para/sua-chave.pem**: Altere para o caminho da sua chave.
   -  **ami**: Altere para o seu tipo de AMI.
   - **ip-da-instancia**: Altere para o ip da sua instancia EC2.

---

# ETAPA2: Configuração do Servidor Web

Este tutorial irá guiá-lo através do processo de instalacao do Nginx na EC2, criar uma pagina html simples e configurar o Nginx.

---

## 1. Instalar o servidor Nginx na EC2

### 1.1. Instalar o Nginx

1.1.1. Acessado o terminal, atualize os pacotes do sistema.
`sudo apt update && sudo apt upgrade -y`
1.1.2. Instale o Nginx.
`sudo apt install nginx -y`
1.1.3. Inicialize o servico.
`sudo systemctl start nginx`
1.1.4. Verifique o status do servico.
`sudo systemctl status nginx`
1.1.5. Inicializar o servico junto com o sistema.
`sudo systemctl enable nginx`

---

## 2. Criar uma pagina HTML simples

### 2.1. Criar pagina html

2.1.1. Atraves de seu editor de arquivos de preferencia, crie um arquivo `index.html` no diretorio /var/www/html/ e monte sua estrutura html.
2.1.2. Em seu navegador de internet, insira o ip da sua instancia EC2 e voce vera sua pagina rodando se tudo ocorrer normalmente.

---

## 3. Configurar o Nginx

### 2.1. 

---

# ETAPA3: Monitoramento e Notificacoes

Este tutorial irá guiá-lo através do processo de criacao de um script de monitoramento, configuracao do webhook do Slack e automatizacao com cron.

---

## 1. Criacao do Script em Bash

### 1.1. Criando Script

1.1.1. Crie um arquivo .sh no diretorio padrao de binarios do Linux.
`touch /usr/local/bin/monitorar_site.sh`
1.1.2. Modifique a execucao do arquivo
`chmod +x /usr/local/bin/monitorar_site.sh`
1.1.3. Adicione o conteudo do arquivo monitorar_site.sh presente no repositorio para o seu arquivo atraves de seu editor de arquivo.

---
