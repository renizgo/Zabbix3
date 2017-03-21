# Instalação do Zabbix Agent

Uma breve descrição de como fazer a instalação do Zabbix Agent, para monitoramento no Zabbix Server

Adicione o repositório:

```
# rpm -Uvh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
```

Instale o Zabbix-Agent:

```
# yum install zabbix-agent
```

Edite o arquivo de configuração do Zabbix-Agent:

```
# vi /etc/zabbix/zabbix_agentd.conf
Server=<IP-SERVIDOR>
Hostname=<IP-SERVIDOR>
```

Inicie e Zabbix-Agent e configure na inicialização no sistema:

```
# systemctl start zabbix-agent
# systemctl enable zabbix-agent
```
