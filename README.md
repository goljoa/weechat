# WeeChat avec Tor - Container Docker

Configuration Docker pour utiliser WeeChat avec Tor pour l'anonymat sur IRC.

## Architecture

- **Service Tor** : Proxy SOCKS5 sur le port 9050 (interne au réseau Docker)
- **Service WeeChat** : Client IRC utilisant torsocks pour router tout le trafic via Tor

## Démarrage rapide

```bash
# Construction et démarrage
./make.sh

# Ou manuellement
docker compose up -d

# Attacher à WeeChat
docker attach weechat_tor_client
# (Ctrl-P puis Ctrl-Q pour détacher sans arrêter)
```

## Commandes utiles

### Gestion des containers
```bash
# Voir les logs
docker compose logs -f tor
docker compose logs -f weechat

# Accéder au shell du client
docker compose exec weechat bash

# Arrêter les services
docker compose down
```

### Tester la connexion Tor
```bash
# Depuis le container weechat
docker compose exec weechat curl --socks5-hostname tor:9050 https://check.torproject.org/api/ip
```

## Configuration WeeChat

Une fois dans WeeChat, configurez le proxy Tor et vos serveurs IRC :

```
# 1. Configurer le proxy Tor
/proxy add tor socks5 tor 9050
/set irc.server_default.proxy "tor"

# 2. Configuration de base anonyme
/set irc.server_default.username anon
/set irc.server_default.realname nobody
/set weechat.network.gnutls_ca_system on

# 3. Exemple : Libera.Chat
/server add libera irc.libera.chat/6697 -ssl -autoconnect
/set irc.server.libera.nicks "anon123,anon456,anon789"
/connect libera

# 4. Exemple : OFTC
/server add oftc irc.oftc.net/6697 -ssl
/set irc.server.oftc.nicks "anon123"
/connect oftc
```

## Sécurité et anonymat

### Points forts
- ✅ Tout le trafic passe par Tor (via torsocks)
- ✅ Utilisateur non-root dans les containers
- ✅ SafeLogging activé sur Tor
- ✅ Pas d'exposition réseau externe

### Bonnes pratiques
- ⚠️ Choisissez des pseudos non identifiants
- ⚠️ Ne divulguez pas d'informations personnelles
- ⚠️ Utilisez toujours SSL/TLS pour les connexions IRC
- ⚠️ Évitez les commandes DCC (transfert de fichiers direct)
- ⚠️ Ne pas utiliser le même pseudo sur différents réseaux

### Limitations
- Le fuseau horaire du container peut révéler votre localisation
- Les patterns de frappe et de langage peuvent permettre de vous identifier
- Tor ne protège pas contre l'analyse de comportement

## Structure des fichiers

```
.
├── docker-compose.yml      # Orchestration des services
├── Dockerfile             # Image WeeChat
├── Dockerfile.tor         # Image Tor
├── make.sh               # Script de construction/démarrage
├── start-weechat.sh      # Point d'entrée WeeChat
├── torsocks.conf         # Configuration torsocks
├── tor/
│   └── torrc            # Configuration Tor
├── tor-data/            # Données Tor (généré)
├── weechat-data/        # Configuration WeeChat (persisté)
└── weechat-certs/       # Certificats clients (optionnel)
```

## Dépannage

### Le healthcheck Tor échoue
```bash
docker compose exec tor netstat -tln | grep 9050
# Devrait montrer le port 9050 en écoute
```

### WeeChat ne se connecte pas
```bash
# Vérifier que Tor fonctionne
docker compose logs tor

# Tester la connectivité Tor
docker compose exec weechat torsocks curl https://check.torproject.org/api/ip
```

### Permissions sur tor-data
```bash
# Si problème de permissions
sudo chown -R 1000:1000 tor-data/
chmod 700 tor-data/
```

## Certificats clients (optionnel)

Pour utiliser des certificats clients IRC (authentification SASL EXTERNAL) :

```bash
# Générer un certificat
openssl req -x509 -new -newkey rsa:4096 -sha256 -days 1000 -nodes \
  -out weechat-certs/cert.pem -keyout weechat-certs/key.pem

# Dans WeeChat
/set irc.server.libera.ssl_cert "/home/weechat/.weechat/certs/cert.pem"
```

## License

Ce projet est fourni tel quel pour un usage éducatif et personnel.
