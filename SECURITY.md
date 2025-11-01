# Security Policy

## Données sensibles

Ce projet est conçu pour protéger votre vie privée lors de l'utilisation d'IRC via Tor. Cependant, certaines pratiques sont essentielles :

### ✅ Ce qui est protégé

- Tout le trafic IRC passe par le réseau Tor
- Les certificats clients et clés privées sont automatiquement exclus de Git
- Les données runtime Tor ne sont jamais commitées
- Les logs et configurations WeeChat restent locaux
- Isolation réseau via Docker

### ⚠️ Ce qui n'est PAS protégé

- Votre style d'écriture et patterns de comportement
- Les métadonnées temporelles (heures de connexion)
- Les erreurs de manipulation (divulgation d'informations personnelles)
- Les vulnérabilités dans WeeChat, Tor ou Docker eux-mêmes

## Fichiers à ne JAMAIS commiter

Les fichiers suivants sont automatiquement exclus par `.gitignore` :

- `weechat-certs/*.pem`, `*.key`, `*.crt` - Certificats et clés privées
- `weechat-data/*` - Configuration WeeChat (peut contenir des mots de passe)
- `tor-data/*` - Données runtime de Tor
- `*.env` - Variables d'environnement

**Si vous avez accidentellement commité des données sensibles :**
1. Supprimez le commit : `git reset --hard HEAD~1`
2. Si déjà pushé : changez IMMÉDIATEMENT tous les mots de passe/clés concernés
3. Considérez le repository comme compromis
4. Utilisez `git filter-branch` ou BFG Repo-Cleaner si nécessaire

## Reporting a Vulnerability

Si vous découvrez une vulnérabilité de sécurité dans ce projet :

1. **NE PAS** créer d'issue publique
2. Contactez les mainteneurs directement via email privé
3. Décrivez la vulnérabilité en détail
4. Donnez-nous un délai raisonnable pour corriger (90 jours recommandés)

## Mises à jour de sécurité

### Images Docker

- **Tor** : Basé sur Alpine Linux, mises à jour régulières recommandées
- **WeeChat** : Basé sur Debian Stable, patches de sécurité via APT

Mettez à jour régulièrement :
```bash
docker compose pull
docker compose build --no-cache
docker compose up -d
```

### Audit régulier

Vérifiez périodiquement :
```bash
# Version de Tor
docker compose exec tor tor --version

# Packages Debian
docker compose exec weechat apt list --upgradable
```

## Bonnes pratiques

1. **Pseudonymes** : Utilisez des pseudos non liés à votre identité réelle
2. **Comportement** : Variez vos patterns d'écriture et horaires
3. **Informations personnelles** : Ne divulguez JAMAIS d'informations identifiantes
4. **Certificats** : Utilisez des certificats différents pour chaque serveur IRC si possible
5. **Logs** : Désactivez ou chiffrez les logs WeeChat si nécessaire
6. **Mises à jour** : Gardez Docker, Tor et WeeChat à jour

## Limitations connues

- **DNS Leaks** : Minimisés mais pas impossibles en cas de mauvaise configuration
- **Timezone** : Le fuseau horaire du container peut révéler votre localisation
- **Fingerprinting** : La version de WeeChat peut être détectée
- **Corrélation temporelle** : Vos heures de connexion peuvent être analysées

## Support

Pour des questions générales de sécurité sur Tor :
- https://support.torproject.org/
- https://www.torproject.org/docs/

Pour WeeChat :
- https://weechat.org/files/doc/stable/weechat_user.en.html#irc_ssl
