#!/bin/bash
#
# SCRIPT BACKUP BANCO DE DADOS POSTGRESQL(ZABBIX) ESTRUTURA WEB E CONFIGS
# AUTHOR: Renato Diniz Marigo
# DATE: 14/03/2017
# EMAIL: renato.diniz@scielo.org

#############
# Variaveis #
#############
DIR_BKP="/dados/backup"
BACKUP_NAME="bkp_zabbix"
export PGPASSWORD=xei0wahP

###################
# Backup Postgres #
###################
# Faz um Dump do Banco de Dados #
$(which pg_dump) -U zabbix -h localhost > $DIR_BKP/$BACKUP_NAME-`date +%F`.sql

# Faz a compressão Tar GZ
tar -czvf $DIR_BKP/$BACKUP_NAME-`date +%F`.tar.gz $DIR_BKP/$BACKUP_NAME-`date +%F`.sql

# Remove o arquivo não compactado
rm $DIR_BKP/$BACKUP_NAME-`date +%F`.sql

#########################
# Copia a Estrutura Web #
#########################
tar -cvzf $DIR_BKP/web_zabbix-`date +%F`.tar.gz /usr/share/zabbix/

##########################
# Copia arquivos de conf #
##########################
tar -cvzf $DIR_BKP/zabbix.conf-`date +%F`.tar.gz /etc/httpd/conf.d/zabbix.conf
tar -cvzf $DIR_BKP/etc_zabbix-`date +%F`.tar.gz /etc/zabbix/

#####################################
# Apagar backups maiores de 15 dias #
#####################################
/usr/bin/find  /root/backup/ -type f -ctime +15 -exec rm -rfv {} \; > /var/log/backup_zabbix_removido.log

# Exemplo de CRON\
#30 6 * * * /dados/backup/backup_zabbix_pg.sh > /var/log/backup_zabbix.log 2>&1
