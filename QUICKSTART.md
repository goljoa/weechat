# Guide de démarrage rapide

## Installation

### Prérequis
- Docker et Docker Compose installés
- Permissions pour exécuter Docker

### Étape 1 : Cloner le repository

```bash
git clone <url-du-repo>
cd weechat
```

### Étape 2 : Vérifier les permissions

```bash
# Les dossiers de données doivent appartenir à l'utilisateur 1000:1000
sudo chown -R 1000:1000 tor-data/ weechat-data/ weechat-certs/
```

### Étape 3 : Démarrer les services

```bash
# Option A : Script automatique (recommandé pour la première fois)
./make.sh

# Option B : Manuellement
docker compose up -d
```

### Étape 4 : Vérifier que tout fonctionne

```bash
./test.sh
```

Vous devriez voir :
```
1. Vérification des services... ✓
2. Vérification du port Tor 9050... ✓
3. Test de connectivité Tor... ✓ (IP Tor: xxx.xxx.xxx.xxx)
4. Vérification de WeeChat... ✓
```

## Première connexion à WeeChat

```bash
docker attach weechat_tor_client
```

> **Note** : Pour détacher sans arrêter WeeChat : `Ctrl-P` puis `Ctrl-Q`

## Configuration initiale dans WeeChat

Une fois dans WeeChat, exécutez ces commandes :

```
/proxy add tor socks5 tor 9050
/set irc.server_default.proxy "tor"
/set irc.server_default.username anon
/set irc.server_default.realname nobody
/set weechat.network.gnutls_ca_system on
```

## Se connecter à un serveur IRC

### Exemple : Libera.Chat

```
/server add libera irc.libera.chat/6697 -ssl -autoconnect
/set irc.server.libera.nicks "anon123,anon456,anon789"
/connect libera
```

### Exemple : OFTC

```
/server add oftc irc.oftc.net/6697 -ssl
/set irc.server.oftc.nicks "anon123"
/connect oftc
```

## Vérifier que vous utilisez Tor

Dans un autre terminal :

```bash
docker compose exec weechat curl --socks5-hostname tor:9050 https://check.torproject.org/api/ip
```

Vous devriez voir `"IsTor":true` et une IP de sortie Tor.

## Commandes utiles

### Gestion des containers

```bash
# Voir les logs
docker compose logs -f tor
docker compose logs -f weechat

# Redémarrer les services
docker compose restart

# Arrêter proprement
docker compose down

# Reconstruire après des modifications
docker compose build --no-cache
docker compose up -d
```

### Accéder au shell du container

```bash
docker compose exec weechat bash
```

### Sauvegarder votre configuration WeeChat

```bash
# Dans WeeChat
/save

# Ou depuis l'hôte
docker compose exec weechat ls -la /home/weechat/.weechat/
```

## Dépannage rapide

### Les services ne démarrent pas

```bash
# Vérifier les logs
docker compose logs

# Vérifier les permissions
ls -la tor-data/ weechat-data/
```

### WeeChat ne se connecte pas à IRC

```bash
# Dans WeeChat, vérifier la config du proxy
/proxy list
/set irc.server_default.proxy

# Tester la connectivité Tor
docker compose exec weechat curl --socks5-hostname tor:9050 https://check.torproject.org/api/ip
```

### Tor ne démarre pas

```bash
# Vérifier la configuration
docker compose exec tor tor --verify-config -f /etc/tor/torrc

# Voir les logs détaillés
docker compose logs tor --tail 50
```

## Nettoyage

Pour tout supprimer (ATTENTION : efface vos données) :

```bash
docker compose down -v
rm -rf tor-data/* weechat-data/* weechat-certs/*.pem
```

## Prochaines étapes

- Lisez [README.md](README.md) pour plus de détails
- Consultez [SECURITY.md](SECURITY.md) pour les bonnes pratiques de sécurité
- Générez des certificats clients si nécessaire (voir [weechat-certs/README.md](weechat-certs/README.md))

## Besoin d'aide ?

- Créez une issue sur GitHub
- Consultez la documentation WeeChat : https://weechat.org/doc/
- Documentation Tor : https://www.torproject.org/docs/
