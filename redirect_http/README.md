# Redirecionamento da aplicação

Atualmente como visto no artigo nós acessamos a interface Web através do link:

```
http://<NOME-DO-SERVIDOR>/zabbix
```

E temos como objetivo acessarmos pelo link:

```
http://<NOME-DO-SERVIDOR>
```

Esta configuração é bem simples, conforme podemos ver no arquivo de configuração do “zabbix.conf”

```
# vi /etc/httpd/conf.d/zabbix.conf
<Directory "/usr/share/zabbix">
```

Edite o arquivo de configuração padrão do Apache com este caminho especificado:

```
# vi /etc/httpd/conf/httpd.conf
# Troque este
#DocumentRoot "/var/www/html"
# Por este
DocumentRoot "/usr/share/zabbix"
```

