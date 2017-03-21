# Zabbix3 - Script de Backup Postgres + Web + Confs

## Introdução

Script criado para fazer o backup do Banco de Dados Postgresql do Zabbix na versão 3, o script também copia a estrutura Web e arquivos de configurações.

No final o script remove backups anteriores há 15 dias

## Explanação

Nome: backup_zabbix.sh

Copie o arquivo para seu servidor
Dê as pemrissões necessárias:
```
# chmod +x bkp_zabbix_pg.sh
```

Execute o script:
```
# ./bkp_zabbix_pg.sh
```

Exemplo de Crontab:
```
30 6 * * * /dados/backup/backup_zabbix_pg.sh > /var/log/backup_zabbix.log 2>&1
```
