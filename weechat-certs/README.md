# Certificats WeeChat

Ce dossier contient les certificats clients pour l'authentification IRC (optionnel).

## Générer un certificat client

```bash
openssl req -x509 -new -newkey rsa:4096 -sha256 -days 1000 -nodes \
  -out cert.pem -keyout key.pem \
  -subj "/CN=YourNick"
```

## Utilisation dans WeeChat

```
/set irc.server.SERVERNAME.ssl_cert "/home/weechat/.weechat/certs/cert.pem"
```

## Enregistrement du certificat

Pour Libera.Chat (SASL EXTERNAL) :
1. Générez votre certificat
2. Connectez-vous avec le certificat configuré
3. Identifiez-vous : `/msg NickServ IDENTIFY password`
4. Ajoutez le certificat : `/msg NickServ CERT ADD`

## Sécurité

**IMPORTANT** : Les fichiers `*.pem`, `*.key`, `*.crt` sont automatiquement ignorés par Git.
Ne commitez JAMAIS vos clés privées !
