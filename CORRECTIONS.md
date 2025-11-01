# Corrections apportées au projet WeeChat + Tor

## Problèmes identifiés et corrigés

### 1. Healthcheck Tor défaillant
**Problème** : Le healthcheck utilisait `nc -z localhost 9050` mais BusyBox netcat ne supporte pas l'option `-z`.

**Correction** : Changé pour `netstat -tln | grep -q ':9050'` dans [docker-compose.yml](docker-compose.yml#L13)
- Ajout du paramètre `start_period: 5s` pour laisser le temps à Tor de démarrer

### 2. Version obsolète dans docker-compose.yml
**Problème** : L'attribut `version: "3.8"` est obsolète et génère un warning.

**Correction** : Supprimé l'attribut `version` dans [docker-compose.yml](docker-compose.yml)

### 3. Package inutile dans Dockerfile
**Problème** : `weechat-tcl` était installé sans nécessité.

**Correction** : Changé en `weechat` simple dans [Dockerfile](Dockerfile#L6)

### 4. Permissions sur les volumes montés
**Problème** : Le script [start-weechat.sh](start-weechat.sh) tentait de faire `chmod 700` sur un volume monté, causant "Operation not permitted".

**Correction** : Modifié pour ne créer le dossier que s'il n'existe pas, sans forcer les permissions

### 5. Configuration Tor sécurisée
**Amélioration** : Ajout de paramètres de sécurité dans [tor/torrc](tor/torrc) :
- `SafeLogging 1` : Évite de logger des informations sensibles
- `DisableDebuggerAttachment 0` : Adapté pour le container
- Commentaires explicatifs sur `SocksPort 0.0.0.0:9050`

### 6. Configuration torsocks simplifiée
**Problème** : `TorDNS 1` et autres options causaient des problèmes de connexion.

**Correction** : Simplification de [torsocks.conf](torsocks.conf) pour n'utiliser que les paramètres essentiels

### 7. Documentation WeeChat améliorée
**Ajout** : Instructions claires dans [start-weechat.sh](start-weechat.sh) et [README.md](README.md) pour configurer le proxy SOCKS5 natif de WeeChat :
```
/proxy add tor socks5 tor 9050
/set irc.server_default.proxy "tor"
```

## Fichiers ajoutés

### 1. [README.md](README.md)
Documentation complète incluant :
- Architecture du projet
- Guide de démarrage rapide
- Configuration WeeChat détaillée
- Bonnes pratiques de sécurité et anonymat
- Dépannage
- Structure des fichiers

### 2. [.gitignore](.gitignore)
Protection des données sensibles :
- `tor-data/` : Données Tor runtime
- `weechat-data/` : Configuration et logs WeeChat
- `weechat-certs/*.pem` : Certificats privés

### 3. [test.sh](test.sh)
Script de test automatique vérifiant :
- État des services Docker
- Port Tor 9050 en écoute
- Connectivité via Tor (vérification IP)
- Processus WeeChat

### 4. [CORRECTIONS.md](CORRECTIONS.md)
Ce document listant toutes les corrections

## Tests effectués

Tous les tests passent :
```bash
./test.sh
```

Résultats :
- ✓ Services Docker démarrés et sains
- ✓ Port Tor 9050 en écoute
- ✓ Connectivité Tor fonctionnelle (IP vérifiée via check.torproject.org)
- ✓ Container WeeChat opérationnel

## Commandes de vérification

```bash
# Vérifier les services
docker compose ps

# Tester la connexion Tor
docker compose exec weechat curl --socks5-hostname tor:9050 https://check.torproject.org/api/ip

# Voir les logs
docker compose logs -f tor

# Accéder à WeeChat
docker attach weechat_tor_client
# (Ctrl-P puis Ctrl-Q pour détacher)
```

## Points d'attention pour l'utilisateur

1. **Permissions** : Les dossiers `weechat-data/` et `tor-data/` doivent appartenir à l'UID:GID 1000:1000
2. **Configuration proxy** : Dans WeeChat, il faut manuellement configurer le proxy SOCKS5 (voir README)
3. **Anonymat** : Le projet améliore l'anonymat mais ne garantit pas l'anonymat total (voir section sécurité dans README)

## Recommandations futures

1. Ajouter une configuration WeeChat par défaut avec le proxy déjà configuré
2. Considérer l'ajout d'un script d'initialisation automatique pour le premier lancement
3. Éventuellement ajouter des bridges IRC-Tor (.onion) dans les exemples
