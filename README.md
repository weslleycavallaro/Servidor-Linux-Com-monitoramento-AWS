# Servidor-Linux-Com-monitoramento-AWS

<div style="display: flex; justify-content: center;">
  <img src="readme_images/aws.png" width="100"/>
  <img src="readme_images/linux.png" width="100"/>
  <img src="readme_images/nginx.png" width="100"/>
  <img src="readme_images/slack.png" width="100"/>
</div>

Este projeto utiliza a infraestrutura da AWS em conjunto com o NGINX para fornecer uma solução de gerenciamento e automação de monitoramento atraves de logs e notificações. O NGINX é configurado como servidor web e balanceador de carga, garantindo alta disponibilidade e desempenho. O monitoramento e feito atraves de um script em Bash que realiza chamadas HTTP para o dominio do site, rodando de maneira automatizada atraves do cron. Notificações em tempo real são enviadas automaticamente os supervisores do projeto atraves de um WebHook do Slack, permitindo respostas rápidas a incidentes e garantindo a continuidade do serviço.

---

# Sumário

`Leia todas as etapas antes de iniciar`

## ☁️ ETAPA 1: Configuração do Ambiente Cloud AWS
- **Objetivo:** Configuração inicial da AWS, criando uma VPC, sub-redes públicas e privadas, e instância EC2.
- **Passos principais:**
  - Criar a VPC
  - Criar Sub-redes Públicas e Privadas
  - Criar uma Internet Gateway
  - Criar uma Instância EC2 na AWS
  - Acessar a Instância via SSH

## 🌐 ETAPA 2: Configuração do Servidor Web
- **Objetivo:** Instalar e configurar o NGINX para hospedar uma página web simples.
- **Passos principais:**
  - Instalar o servidor NGINX na EC2
  - Criar uma página HTML simples
  - Configurar o NGINX

## 👨‍💻 ETAPA 3: Monitoramento e Notificações
- **Objetivo:** Configurar um sistema de monitoramento para verificar a disponibilidade do servidor web e enviar notificações.
- **Passos principais:**
  - Criação do Script em Bash
  - Configurando Webhook do Slack
  - Criar arquivo de logs
  - Configurar o script para rodar a cada 1 minuto utilizando cron
  - Configurar as variáveis de ambiente

## ⏳ ETAPA 4: Automação e Testes
- **Objetivo:** Criar scripts para testar o sistema e automatizar os testes.
- **Passos principais:**
  - Criar script de teste
  - Testes

## 🎲 ETAPA BONUS: Automação com User Data
- **Objetivo:** Automatizar a configuração da instância EC2 utilizando o campo User Data.
- **Passos principais:**
  - Automação com User Data


---

## Para uma utilizacao mais rapida, voce pode clonar esse repositorio em sua instancia
`git clone https://github.com/weslleycavallaro/Servidor-Linux-Com-monitoramento-AWS.git /`

---

# ETAPA 1: Configuração do Ambiente CLoud AWS

Este tutorial irá guiá-lo através do processo de criação de uma VPC na AWS, configuração de sub-redes públicas e privadas, e criação de uma instância EC2 com acesso via SSH.

---

## 1. Criar uma VPC na AWS

### 1.1. Criar a VPC

1.1.1 Acesse o [Console AWS](https://aws.amazon.com/console/) e navegue até a seção **VPC**.

1.1.2 Clique em **Create VPC** e siga as instruções.
   - Defina um **CIDR Block** (por exemplo, `10.0.0.0/16`).
   - Escolha um nome para a sua VPC.

![VPC](readme_images/vpc.png)

### 1.2. Criar Sub-redes Públicas e Privadas

1.2.1. No painel **VPC Dashboard**, clique em **Subnets** e depois em **Create subnet**.

1.2.2. Crie **2 sub-redes públicas**:
   - Sub-rede 1: `10.0.1.0/24` (exemplo de sub-rede pública 1).
   - Sub-rede 2: `10.0.2.0/24` (exemplo de sub-rede pública 2).
   
1.2.3. Crie **2 sub-redes privadas** para futuras expansões:
   - Sub-rede 3: `10.0.3.0/24` (exemplo de sub-rede privada 1).
   - Sub-rede 4: `10.0.4.0/24` (exemplo de sub-rede privada 2).

![VPC](readme_images/sr.png)

### 1.3. Criar uma Internet Gateway

1.3.1. No painel **VPC Dashboard**, clique em **Internet Gateways** e depois em **Create Internet Gateway**.

1.3.2. Dê um nome para o **Internet Gateway** e clique em **Create**.

1.3.3. Após a criação, clique em **Attach to VPC** e selecione a VPC criada anteriormente.

![VPC](readme_images/gateway.png)

![VPC](readme_images/previa_vpc.png)

---

## 2. Criar uma Instância EC2 na AWS

### 2.1. Escolher uma AMI baseada em Linux

2.1.1. Acesse a seção **EC2** no AWS Management Console e clique em **Launch Instance**.

2.1.2. Escolha uma **Amazon Machine Image (AMI)** baseada em Linux, como **Ubuntu**, **Debian** ou **Amazon Linux**.

2.1.3. Selecione o tipo de instância desejado (por exemplo, **t2.micro** para fins de teste).

![VPC](readme_images/ec2.png)

### 2.2 Par de chaves

2.2.1 Crie um par de chaves para ser associado a instancia.

![VPC](readme_images/chaves.png)

![VPC](readme_images/chave_ec2.png)

### 2.3. Instalar na Sub-rede Pública

2.3.1. Durante a configuração da instância, em **Network**, selecione a **VPC** e a **sub-rede pública** (ex: `10.0.1.0/24`).

2.3.2. Ative a opção **Auto-assign Public IP** para garantir que sua instância tenha um IP público.

### 2.4. Associar um Security Group

2.4.1. Crie um novo **Security Group** ou selecione um existente.

2.4.2. Adicione as seguintes regras de entrada:
   - **HTTP (porta 80)**: permitir tráfego de qualquer origem.
   - **SSH (porta 22)**: permitir tráfego de sua rede (opcional, se desejar restringir o acesso via SSH).

![VPC](readme_images/rede_sg.png)

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

# ETAPA 2: Configuração do Servidor Web

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
`nano index.html`

2.1.2. Em seu navegador de internet, insira o ip da sua instanci3.1.2 a EC2 e voce vera sua pagina rodando se tudo ocorrer normalmente.
`http://192.168.0.1`

---

## 3. Configurar o Nginx

### 3.1. Reiniciar de maneira automatica se o servico parar

3.1.1. Edite o arquivo nginx.service
`nano /lib/systemd/system/nginx.service`

3.1.2 Na secao service, adicione as duas linhas abaixo
`Restart=always
RestartSec=5`

Fara com que o arquivo reinicie sempre que der problema e ele tentara a cada 5 segundos.

---

# ETAPA 3: Monitoramento e Notificacoes

Este tutorial irá guiá-lo através do processo de criacao de um script de monitoramento, configuracao do webhook do Slack e automatizacao com cron.

---

## 1. Criacao do Script em Bash

O script de monitoramento e essencial para garantir a total operancia do servidor web. Ele faz requisicoes HTTP  e grava a resposta em um arquivo de log.

### 1.1. Criando Script

1.1.1. Crie um arquivo .sh no diretorio padrao de binarios do Linux.
`touch /usr/local/bin/monitorar_site.sh`

1.1.2. Modifique a execucao do arquivo
`chmod +x /usr/local/bin/monitorar_site.sh`

1.1.3. Adicione o conteudo do arquivo monitorar_site.sh presente no repositorio para o seu arquivo atraves de seu editor de arquivo.

---

## 2. Configurando Webhook do Slack

Webhooks são uma forma simples de enviar dados para o Slack a partir de outros aplicativos e serviços. Eles permitem que você envie mensagens para canais do Slack de maneira automatizada. Aqui, vamos explicar como configurar um Webhook no Slack.

### 2.1. Acesse o Slack API

2.1.1. Acesse [Slack API](https://api.slack.com/).

2.1.2. Faça login com a sua conta Slack.

### 2.2. Crie um Novo App

2.2.1. No menu lateral esquerdo, clique em **Your Apps**.

2.2.2. Clique no botão **Create New App**.

2.2.3. Escolha a opção **From Scratch**.

2.2.4. Dê um nome para o seu app (por exemplo, "Webhook de Integração") e selecione o workspace onde você deseja usar o Webhook.

2.2.5. Clique em **Create App**.

### 2.3 Ative o Webhook de Entrada

2.3.1. Após criar o app, no menu à esquerda, selecione **Incoming Webhooks**.

2.3.2. No topo da página, ative a opção **Activate Incoming Webhooks**.

2.3.3. Em seguida, clique em **Add New Webhook to Workspace**.

### 2.4. Escolha o Canal

2.4.1. Você será solicitado a escolher um canal para o qual as mensagens enviadas pelo Webhook irão. Escolha o canal desejado (por exemplo, "#geral" ou outro canal específico).

2.4.2. Clique em **Permitir** para conceder permissão ao Webhook.

### 2.5. Copie a URL do Webhook

2.5.1. Após permitir o acesso, o Slack irá gerar uma URL única do Webhook.

2.5.2. Copie essa URL, pois ela será usada para enviar mensagens para o Slack.
`https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX`

---

## 3. Criar arquivo de logs.

### 3.1. Criando arquivo

3.1.1. No diretorio /var/log crie um arquivo chamado monitoramento.log
`touch /var/log/monitoramento.log`

3.1.2 COnfigure as permicoes de leitura e escrita.
`chmod a+rw /var/log/monitoramento.log`

---

## 4. Cronfigurar Script para rodar a cada 1 minuto utilizando cron

### 4.1. Edite a tabela do cron

4.1.1. Execute o comando abaixo para acessar a tabela do cron no modo edicao.
`crontab -e`

4.1.2. Adicione o seguinte comando ao fim do arquivo.
`*/1 * * * * /usr/local/bin/monitorar_site.sh`

Isso fara com que o cron execute o script de monitoramento a cada 1 minuto.

---

## 5. Configurando as variaveis de ambiente.

### 5.1 Criando arquivo

5.1.1 No diretorio /usr/local/bin/ crie um arquivo chamado variaveis.env.
`touch /usr/local/bin/variaveis.env`

5.1.2 Adicione no arquivo usando seu editor de arquivos 2 variaveis:
   `URL="http://ip_da_sua_instancia"`
   `WEBHOOK="https://url_do_seu_webhook"`

Isso protegera dados sensiveis em caso de compartilhamento do script principal.

---

# ETAPA 4: Automacao e testes

## 1. Criar script de teste

O script de testes engloba uma serie de comandos essenciais para testar e garantir o funcionamento correto do servidor.

### 1.1. Criando arquivo

1.1.1. No diretorio /usr/local/bin/ crie um arquivo chamado testes.sh.
`touch /usr/local/bin/testes.sh`

1.1.2. De a permicao de execucao para todos.
`chmod a+x /usr/local/bin/testes.sh`

## 2. Testes:

2.1. Rodando script de teste

![Teste](readme_images/script_teste.png)

2.2. Parando o processo do Nginx.

![Parando_Nginx](readme_images/servidor_desligado.png)

2.3. Status do Nginx

![Status_Nginx](readme_images/status_nginx.png)

2.4. Notificacoes do Slack

![Notificacoes](readme_images/slack.png)

---

# ETAPA BONUS: Userdata

## 1. Automacao com User Data

Utilizando o User Data sua instancia EC2 ja pode ser iniciada com o Nginx, HTML e o monitoramento totalmente configurados

1.1.  Adicione o script abaixo no campo User Data ao criar sua instancia EC2

[LINK PARA O USERDATA](userdata/userdata.txt)

## Passos a serem pulados quando usado o USER DATA

## ETAPA 2:

Todos os passos

## ETAPA 3:

PASSO 1

PASSO 3

PASSO 4

## ETAPA 4:

PASSO 1
