# Par où commencer ?

Bienvenue dans le projet WeeChat-Tor ! Ce fichier vous guide vers la bonne documentation selon votre profil.

## 🆕 Je débute complètement sur IRC

**Parcours recommandé (2-3h)** :

1. **[QUICKSTART.md](QUICKSTART.md)** (15 min)
   - Installation du projet
   - Premier lancement
   - Vérification que tout fonctionne

2. **[IRC_GUIDE.md](IRC_GUIDE.md)** (1-2h)
   - Lisez au moins les sections 1 à 5
   - Section 1 : Qu'est-ce qu'IRC ?
   - Section 2 : Interface WeeChat
   - Section 3 : Configuration de base
   - Section 4 : Commandes essentielles
   - Section 5 : Votre première connexion (PAS À PAS)

3. **Pratiquez !**
   - Connectez-vous à Libera.Chat
   - Rejoignez #libera (canal d'accueil)
   - Observez les discussions
   - Posez vos questions

4. **[SECURITY.md](SECURITY.md)** (30 min)
   - Lisez pour comprendre les limites de l'anonymat
   - Bonnes pratiques essentielles

## 💬 Je connais IRC mais pas WeeChat

**Parcours recommandé (45 min)** :

1. **[QUICKSTART.md](QUICKSTART.md)** (10 min)
   - Installation rapide

2. **[IRC_GUIDE.md](IRC_GUIDE.md)** - Sections spécifiques :
   - Section 2 : Premiers pas avec WeeChat (navigation)
   - Section 3 : Configuration de base (IMPORTANT : proxy Tor)
   - Section 4 : Commandes essentielles WeeChat
   - Section 7 : Fonctionnalités avancées (scripts, filtres)

3. **[IRC_GUIDE.md - Raccourcis clavier](IRC_GUIDE.md#raccourcis-clavier-weechat)** (5 min)
   - Référence rapide

## 🔐 Je veux comprendre la sécurité

**Parcours recommandé (1h)** :

1. **[README.md - Avertissement](README.md#️-avertissement)** (5 min)

2. **[SECURITY.md](SECURITY.md)** (30 min)
   - Politique de sécurité complète
   - Fichiers sensibles
   - Bonnes pratiques

3. **[IRC_GUIDE.md - Sécurité et anonymat](IRC_GUIDE.md#sécurité-et-anonymat)** (25 min)
   - Protection de l'identité
   - Commandes dangereuses
   - Vérifier Tor

## 🛠️ Je veux contribuer au projet

**Parcours recommandé (45 min)** :

1. **[CONTRIBUTING.md](CONTRIBUTING.md)** (20 min)
   - Standards de code
   - Workflow de contribution
   - Checklist PR

2. **[GIT_SETUP.md](GIT_SETUP.md)** (15 min)
   - Configuration Git
   - Protection des données sensibles

3. **[SECURITY.md - Reporting a Vulnerability](SECURITY.md#reporting-a-vulnerability)** (10 min)
   - Comment signaler une vulnérabilité

## 🚀 Je veux juste lancer rapidement

**Parcours minimal (10 min)** :

1. **[README.md](README.md)** - Vue d'ensemble
2. **[QUICKSTART.md](QUICKSTART.md)** - Installation en 5 min
3. **Lancez** : `./make.sh`

⚠️ **ATTENTION** : Lisez au moins [IRC_GUIDE.md - Configuration de base](IRC_GUIDE.md#configuration-de-base) pour configurer le proxy Tor correctement !

## 📚 Navigation complète

Pour une vue d'ensemble de toute la documentation :

→ **[DOCS_INDEX.md](DOCS_INDEX.md)**

## ❓ FAQ Rapide

### Comment se connecter à WeeChat ?

```bash
docker attach weechat_tor_client
```

Pour détacher sans quitter : `Ctrl-P` puis `Ctrl-Q`

### Comment vérifier que j'utilise Tor ?

```bash
docker compose exec weechat curl --socks5-hostname tor:9050 https://check.torproject.org/api/ip
```

Résultat attendu : `"IsTor":true`

### Quelle est la première chose à faire dans WeeChat ?

Configurer le proxy Tor !

```
/proxy add tor socks5 tor 9050
/set irc.server_default.proxy "tor"
/save
```

Voir [IRC_GUIDE.md - Configuration de base](IRC_GUIDE.md#configuration-de-base)

### Où trouver la liste complète des commandes IRC ?

→ [IRC_GUIDE.md - Commandes essentielles](IRC_GUIDE.md#commandes-essentielles)

### Comment rejoindre un canal ?

```
/join #nom-du-canal
```

Exemple : `/join #debian`

### Le projet ne démarre pas, que faire ?

1. [QUICKSTART.md - Dépannage rapide](QUICKSTART.md#dépannage-rapide)
2. [IRC_GUIDE.md - Dépannage](IRC_GUIDE.md#dépannage)
3. Vérifiez les logs : `docker compose logs`

## 🎯 Résumé des documents

| Document | Pour qui ? | Temps | Priorité |
|----------|------------|-------|----------|
| [README.md](README.md) | Tous | 10 min | ⭐⭐⭐ |
| [QUICKSTART.md](QUICKSTART.md) | Tous | 15 min | ⭐⭐⭐ |
| [IRC_GUIDE.md](IRC_GUIDE.md) | Débutants IRC | 1-2h | ⭐⭐⭐⭐⭐ |
| [SECURITY.md](SECURITY.md) | Tous | 30 min | ⭐⭐⭐⭐ |
| [DOCS_INDEX.md](DOCS_INDEX.md) | Navigation | 5 min | ⭐⭐ |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Développeurs | 20 min | ⭐⭐ |
| [GIT_SETUP.md](GIT_SETUP.md) | Développeurs | 15 min | ⭐⭐ |
| [weechat-certs/README.md](weechat-certs/README.md) | Utilisateurs avancés | 10 min | ⭐ |

---

**Bonne découverte !** 🚀

Si vous avez des questions, consultez [DOCS_INDEX.md](DOCS_INDEX.md) ou créez une issue sur GitHub.
