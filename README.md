# Zabbix3

### Informações sobre implementação do Zabbix 3

## Introdução

Zabbix é uma ferramenta de monitoramento Open Source muito completa e possui diversos benefícios:

* Monitoramento de toda a sua rede;
* Monitora alta disponibilidade do seu ambiente (redes / aplicações);
* Envia mensagens de indisponibilidade por e-mail ou diversos outros tipos de clientes de mensageria;
* Coleta dados com e sem agentes, dependendo da necessidade;
* Interface Web para administração;
* Gráficos com dados estatísticos;
* Suporte a maioria dos sistemas operacionais e equipamentos que suportam o protocolo SNMP;

## Objetivo

Neste documento mostrarei o processo de instalação e configuração básica do Zabbix na versão 3.2.

## Requisitos

Os requisitos podem ser verificados na [documentação oficial do projeto](https://www.zabbix.com/documentation/3.2/manual/installation/requirements):

Primeira coisa a se pensar é o tamanho da infraestrutura no meu caso usarei a recomendação da documentação:

| Name          | Platform                 | CPU/Memory    | Database   | Monitored Hosts |
| ------------- |:-----------------------: | -------------:| ---------- | --------------- |
| Large         | Red Hat Enterprise Linux | 4 CPU's / 8GB | PostgreSQL | > 1000          |

Sistema Operacional: Linux Centos;
Banco de Dados: PostgresQL.

## Instalação

### Instalando o Banco de Dados

Para instalarmos o PostgreSQL instale os seguintes pacotes:

```
# yum install postgresql-server postgresql-contrib -y
```

Inicie o banco de dados:

```
# postgresql-setup initdb
Initializing database ... OK
```

Por padrão o PostgreSQL. não permite autenticação por senhas, iremos permitir editando o arquivo “pg_hba.conf”

Edite o arquivo conforme a seguir:

```
# vi /var/lib/pgsql/data/pg_hba.conf
host    all             all             127.0.0.1/32            md5
host    all             all             localhost               md5
```

Inicie e PostgreSQL e configure na inicialização no sistema:

```
# systemctl start postgresql
# systemctl enable postgresql
```

Crie um usuário:

```
# useradd zabbix
# passwd zabbix
```

### Configurando as permissões do usuário

Acesse o banco de dados com o usuário “postgres”:

```
# sudo -i -u postgres
-bash-4.2$ createuser --interactive
Digite o nome da role a ser adicionada: zabbix
A nova role poderá criar um super-usuário? (s/n) s
```

Acesse o PostgreSQL e defina as permissões do usuário:

```
# psql
postgres=# ALTER ROLE zabbix WITH PASSWORD '*****';
postgres=# ALTER ROLE zabbix VALID UNTIL 'infinity';
postgres=# ALTER ROLE zabbix SUPERUSER INHERIT CREATEROLE CREATEDB;
postgres=# CREATE DATABASE zabbix;
postgres=# \q
```

Teste o acesso com o seguinte comando:

```
# psql -U zabbix -h localhost
Senha para usuário zabbix:
psql (9.2.18)
Digite "help" para ajuda.

zabbix=# \q
```

### Instalando o Zabbix 3

Instale o pacote de repositório do Centos:

```
# rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
```

Instale o frontend do Zabbix com o Banco PosgreSQL:

```
# yum install zabbix-server-pgsql zabbix-web-pgsql
```

Popule o banco de dados:

```
# zcat /usr/share/doc/zabbix-server-pgsql-3.2.2/create.sql.gz | psql -U zabbix -h localhost zabbix
```

Edite o arquivo de configuração do Zabbix Server:

```
# vi /etc/zabbix/zabbix_server.conf
DBHost=localhost
DBName=zabbix
DBUser=zabbix
DBPassword=<username_password>
```

Edite o arquivo de configuração do PHP:

```
# vi /etc/php.ini
max_execution_time 300
memory_limit 128M
post_max_size 16M
upload_max_filesize 2M
max_input_time 300
always_populate_raw_post_data -1
date.timezone America/SAO_PAULO
```

Inicie o Apache e configure na inicialização no sistema:

```
# systemctl start httpd
# systemctl enable httpd
```

Desabilite o selinux:

```
# setenforce 0
# vi /etc/selinux/config
SELINUX=disabled
```

Inicie e Zabbix-Server e configure na inicialização no sistema:

```
# systemctl start zabbix-server
# systemctl enable zabbix-server
```

### Concluindo a instalação

Agora concluiremos a instalação através do Browser: “http://<IP-SERVIDOR>/zabbix”:

Inline-style: 
![Imagem 01](https://github.com/renizgo/Zabbix3/blob/master/imagens/Imagem01.png)

Siga os passos de instalação conforme imagens a seguir:
![Imagem 02](https://github.com/renizgo/Zabbix3/blob/master/imagens/Imagem02.png)
![Imagem 03](https://github.com/renizgo/Zabbix3/blob/master/imagens/Imagem03.png)
![Imagem 04](https://github.com/renizgo/Zabbix3/blob/master/imagens/Imagem04.png)
![Imagem 05](https://github.com/renizgo/Zabbix3/blob/master/imagens/Imagem05.png)
![Imagem 06](https://github.com/renizgo/Zabbix3/blob/master/imagens/Imagem06.png)

### Acessando

Acesse seu sistema de monitoramento com as credenciais de acesso:
Username: Admin
Password: zabbix
Obs: Lembre se trocar a senha o mais rápido possível.


![Imagem 07](https://github.com/renizgo/Zabbix3/blob/master/imagens/Imagem07.png)

E para fechar a instalação habilite o monitoramento do servidor Zabbix, pelo menu: 

![Imagem 08](https://github.com/renizgo/Zabbix3/blob/master/imagens/Imagem08.png)

Seu ambiente está pronto para ser gerenciado e adicionar novos equipamentos para monitoramento:

![Imagem 09](https://github.com/renizgo/Zabbix3/blob/master/imagens/Imagem09.png)

