# Envio de alertas através do Telegram
<center>Centered text</center>
Referência: [https://github.com/ableev/Zabbix-in-Telegram](https://github.com/ableev/Zabbix-in-Telegram)

## Criando um bot no telegram com uma API key

Agora abra o seu Telegram e procure por “@BotFather” e clique em iniciar:

![Imagem 01](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem01.png)
Imagem01

Aparecerá uma lista de opções e nós criaremos um novo “/newbot” e definiremos um nome que no meu caso escolhi “zabbix3”

![Imagem 02](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem02.png)
Imagem02

![Imagem 03](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem03.png)
Imagem03

Agora devemos escolher um usuário que no final do nome obrigatoriamente será “bot” e recebemos uma Chave: 

```
Use this token to access the HTTP API:
309059834:AAHGvJGJkhJQCb2O7aPTLOArTCVlgyCHXWs
```

![Imagem 04](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem04.png)
Imagem04

Acesse o link abaixo digitando a sua chave API que foi gerada anteriormente:

```
https://api.telegram.org/bot<API>/getMe
```

Adicione um grupo no Telegram e neste grupo adicione o usuário que criou anteriormente:

![Imagem 05](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem05.png)
Imagem05

Acesse o link abaixo digitando a sua chave API para copiar as informações:


```
https://api.telegram.org/bot<API>/getUpdates
```

Copie algumas informações importantes:

```
{"ok":true,"result":[{"update_id":530285918,
"message":{"message_id":1,"from":{"id":457653184,"first_name":"Renato","last_name":"Diniz Marigo"},"chat":{"id":-195343187,"title":"SciELOZabbix","type":"group","all_members_are_administrators":true},"date":1482339296,"new_chat_participant":{"id":289059834,"first_name":"zabbix3","username":"zabbix3_alarmsbot"},"new_chat_member":{"id":409059834,"first_name":"zabbix3","username":"zabbix3_alarmsbot"}}}]}
```

![Imagem 06](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem06.png)
Imagem06


## Configurando o Zabbix-in-Telegram

Verifique no arquivo de configuração do Zabbix o Path “AlertScriptsPath” e guarde esta informação.

```
# vi /etc/zabbix/zabbix-server.conf
AlertScriptsPath=/usr/lib/zabbix/alertscripts
```

Instale o comando “pip install”, caso não tenha:

```
# wget https://bootstrap.pypa.io/get-pip.py
# python get-pip.py
```

Instale o módulo “requests” do Python:

```
# pip install requests
```

Faça um clone do repositório:

```
# git clone https://github.com/ableev/Zabbix-in-Telegram.git
```

Entre no diretório e copie os arquivos para os respectivos lugares:

```
# cd Zabbix-in-Telegram/
```

Copie os arquivos “zbxtg.py” e “zbxtg_group.py” para o diretório “AlertScriptsPath”, que foi verificado anteriormente:

```
# cp zbxtg.py /usr/lib/zabbix/alertscripts
# cp zbxtg_group.py /usr/lib/zabbix/alertscripts
```

Copie também o arquivo de configuração de exemplo edite conforme a seguir:

```
# cp zbxtg_settings.example.py /usr/lib/zabbix/alertscripts/zbxtg_settings.py
```

Configure o seu ambiente conforme sua infraestrutura:

```
# -*- coding: utf-8 -*-

tg_key = "XYZ"  # telegram bot api key

zbx_tg_prefix = "zbxtg"  # variable for separating text from script info
zbx_tg_tmp_dir = "/tmp/" + zbx_tg_prefix  # directory for saving caches, uids, cookies, etc.
zbx_tg_signature = False

zbx_server = "http://localhost"  # zabbix server full url
zbx_api_user = "api"
zbx_api_pass = "api"
zbx_api_verify = True  # True - do not ignore self signed certificates, False - ignore

proxy_to_zbx = None
proxy_to_tg = None

#proxy_to_zbx = "proxy.local:3128"
#proxy_to_tg = "proxy.local:3128"

emoji_map = {
    "ok": "✅",
    "problem": "❗",
    "info": "ℹ️",
    "warning": "⚠️",
    "disaster": "❌",
    "bomb": "💣",
    "fire": "🔥",
    "hankey": "💩",
}
```

Crie uma “Media Type” em Administration / Media types:

![Imagem 07](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem07.png)
Imagem07

![Imagem 08](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem08.png)
Imagem08

Para testar via linha de comando
Crie uma “action” em Configuration / Actions:
![Imagem 09](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem09.png)
Imagem09

![Imagem 10](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem10.png)
Imagem10

![Imagem 11](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem11.png)
Imagem11

![Imagem 12](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem12.png)
Imagem12

Crie a “Media type”, dentro do User, lembre-se que o username é “Case-Sensitive”:

![Imagem 13](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem13.png)
Imagem13

![Imagem 14](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem14.png)
Imagem14

Cause um problema em um servidor para receber a mensagem:

![Imagem 15](https://github.com/renizgo/Zabbix3/blob/master/telegram/imagens/Imagem15.png)
Imagem15


