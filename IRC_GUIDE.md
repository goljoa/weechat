# Guide Complet IRC et WeeChat

Guide complet pour débuter sur IRC avec WeeChat via Tor, de l'installation à l'utilisation avancée.

## Table des matières

1. [Introduction à IRC](#introduction-à-irc)
2. [Premiers pas avec WeeChat](#premiers-pas-avec-weechat)
3. [Configuration de base](#configuration-de-base)
4. [Commandes essentielles](#commandes-essentielles)
5. [Rejoindre et utiliser des canaux](#rejoindre-et-utiliser-des-canaux)
6. [Messages privés et discussions](#messages-privés-et-discussions)
7. [Fonctionnalités avancées](#fonctionnalités-avancées)
8. [Bonnes pratiques et étiquette IRC](#bonnes-pratiques-et-étiquette-irc)
9. [Sécurité et anonymat](#sécurité-et-anonymat)
10. [Dépannage](#dépannage)

---

## Introduction à IRC

### Qu'est-ce qu'IRC ?

**IRC (Internet Relay Chat)** est un protocole de discussion en temps réel créé en 1988. C'est l'un des plus anciens systèmes de chat en ligne encore largement utilisé.

### Concepts de base

- **Serveur IRC** : Machine qui héberge les discussions (ex: irc.libera.chat)
- **Réseau** : Ensemble de serveurs interconnectés (ex: Libera.Chat, OFTC)
- **Canal (Channel)** : Salon de discussion, commence par `#` (ex: #debian, #python)
- **Nick** : Votre pseudonyme sur IRC
- **Opérateur (OP)** : Modérateur d'un canal (préfixe `@`)
- **Voice** : Privilège de parole dans certains canaux (préfixe `+`)

### Réseaux IRC populaires

| Réseau | Description | Adresse |
|--------|-------------|---------|
| **Libera.Chat** | Projets open source | irc.libera.chat (6697 SSL) |
| **OFTC** | Organisations et projets | irc.oftc.net (6697 SSL) |
| **Rizon** | Communauté générale, anime | irc.rizon.net (6697 SSL) |
| **EFNet** | L'un des plus anciens | irc.efnet.org (6697 SSL) |
| **Freenode** | (historique, migration vers Libera) | - |

---

## Premiers pas avec WeeChat

### Démarrer WeeChat

```bash
# Démarrer le container et WeeChat
docker compose up -d
docker attach weechat_tor_client
```

Vous verrez l'interface de WeeChat avec :
- **Barre de titre** (en haut) : Version, mode, etc.
- **Zone de chat** (centre) : Messages et conversations
- **Barre de status** (milieu) : Buffers actifs, notifications
- **Barre d'input** (bas) : Où vous tapez vos commandes

### Navigation de base

| Touche | Action |
|--------|--------|
| `Alt + ←/→` | Changer de buffer (fenêtre) |
| `Alt + 1-9` | Aller au buffer 1-9 |
| `Alt + j` puis `##` | Aller au buffer numéro ## |
| `PgUp/PgDn` | Défiler dans l'historique |
| `Ctrl-P Ctrl-Q` | Détacher sans quitter (depuis docker attach) |
| `/quit` | Quitter WeeChat |

### Interface WeeChat expliquée

```
┌─────────────────────────────────────────────────────────────────┐
│ [WeeChat 3.x] [mode: ...]                          [12:34:56]  │ ← Barre de titre
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  12:30:00 --> Alice (alice@example.com) has joined #canal      │
│  12:30:15 <Bob> Bonjour à tous !                               │
│  12:30:30 <Alice> Salut Bob !                                  │ ← Zone de chat
│  12:31:00 <@Charlie> Bienvenue Alice                           │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│ [1:libera] 2:#debian(+n){150} 3:#python(+tn){89} [Act: 2,3]   │ ← Barre de status
├─────────────────────────────────────────────────────────────────┤
│ [12:34] [2] [#debian(+n){150}] [@Charlie(i)]                   │ ← Barre de nicklist
├─────────────────────────────────────────────────────────────────┤
│ │>                                                              │ ← Input
└─────────────────────────────────────────────────────────────────┘
```

---

## Configuration de base

### Étape 1 : Configuration du proxy Tor

**IMPORTANT** : À faire en premier pour garantir l'anonymat !

```
/proxy add tor socks5 tor 9050
/set irc.server_default.proxy "tor"
```

### Étape 2 : Configuration de l'identité

```
# Choisir un pseudo anonyme (pas votre vrai nom !)
/set irc.server_default.nicks "anon123,anon456,anon789"
/set irc.server_default.username "anon"
/set irc.server_default.realname "Anonymous User"
```

⚠️ **Évitez** :
- Votre vrai nom ou pseudo habituel
- Des noms liés à vos comptes existants
- Des informations personnelles identifiables

### Étape 3 : Configuration SSL/TLS

```
/set weechat.network.gnutls_ca_system on
/set irc.server_default.ssl on
/set irc.server_default.ssl_verify on
```

### Étape 4 : Sauvegarder la configuration

```
/save
```

La configuration est sauvegardée dans `~/.weechat/` (persistée dans le volume Docker).

---

## Commandes essentielles

### Commandes WeeChat (commencent par `/`)

#### Gestion des serveurs

```
# Ajouter un serveur
/server add <nom> <adresse>/<port> -ssl

# Exemple Libera.Chat
/server add libera irc.libera.chat/6697 -ssl -autoconnect

# Se connecter à un serveur
/connect <nom>
/connect libera

# Se déconnecter
/disconnect <nom>
/disconnect libera

# Lister les serveurs
/server list

# Supprimer un serveur
/server del <nom>
```

#### Gestion des canaux

```
# Rejoindre un canal
/join #nom-du-canal
/join #debian

# Quitter un canal
/part [message]
/part Bye!

# Lister les canaux du serveur (peut être très long)
/list

# Obtenir des infos sur un canal
/topic            # Voir le topic
/names            # Voir la liste des users
/who #canal       # Infos détaillées sur les users
```

#### Messages et communication

```
# Message sur le canal actuel
Tapez simplement votre message et appuyez sur Entrée

# Message privé (query)
/query <nick>
/msg <nick> <message>

# Action (/me)
/me fait quelque chose
# Affiche : * votre_nick fait quelque chose

# Notice (message discret)
/notice <nick> <message>
```

#### Commandes utilisateur

```
# Changer de nick
/nick <nouveau_nick>

# S'absenter (away)
/away [message]
/away Je suis parti manger
/away           # Retirer le statut away

# Quitter IRC
/quit [message]
```

### Commandes IRC natives (avec /quote ou /raw)

Certaines commandes IRC nécessitent `/quote` :

```
# Changer de nick (méthode IRC)
/quote NICK nouveau_nick

# Obtenir des infos sur un user
/whois <nick>
/whois Alice

# Mode d'un canal
/mode #canal
/mode #canal +nt  # Activer modes n et t
```

---

## Rejoindre et utiliser des canaux

### Tutoriel pas à pas : Première connexion à Libera.Chat

#### 1. Ajouter et configurer le serveur

```
/server add libera irc.libera.chat/6697 -ssl
/set irc.server.libera.proxy "tor"
/set irc.server.libera.nicks "anon123,anon456"
/set irc.server.libera.autoconnect on
/set irc.server.libera.autojoin "#debian,#python"
/save
```

#### 2. Se connecter

```
/connect libera
```

Vous verrez :

```
-- | libera: Connecting to irc.libera.chat/6697 (tor SOCKS5 proxy)...
-- | libera: Connected to irc.libera.chat
-- | libera: Welcome to the Libera.Chat Internet Relay Chat Network anon123
```

#### 3. Rejoindre votre premier canal

```
/join #libera
```

C'est le canal d'accueil de Libera.Chat, idéal pour débuter.

#### 4. Observer avant de parler

Passez quelques minutes à lire les messages pour comprendre :
- Le sujet du canal (affiché en haut)
- Le type de discussions
- Les règles (souvent dans le topic)

#### 5. Votre premier message

```
Hello! I'm new to IRC, nice to meet you all!
```

#### 6. Interagir avec d'autres utilisateurs

Pour mentionner quelqu'un, tapez leur nick :

```
Alice: Thanks for the help!
```

La plupart des clients IRC (dont WeeChat) envoient une notification quand on est mentionné.

### Comprendre les modes de canal

Les canaux ont des **modes** qui définissent leur comportement :

| Mode | Signification |
|------|---------------|
| `+n` | Pas de messages externes (il faut être dans le canal) |
| `+t` | Seuls les OPs peuvent changer le topic |
| `+m` | Modéré (seuls les OPs et +v peuvent parler) |
| `+i` | Invite-only (il faut être invité) |
| `+k <clé>` | Canal protégé par mot de passe |
| `+l <nombre>` | Limite d'utilisateurs |
| `+s` | Secret (invisible dans /list) |

Exemple : `#debian(+nt)` signifie modes `n` et `t` actifs.

### Canaux recommandés pour débuter

#### Libera.Chat

```
/join #libera           # Canal d'accueil
/join #debian           # Support Debian
/join #python           # Python
/join ##linux           # Linux général (note: 2x #)
/join #git              # Git
```

#### OFTC

```
/server add oftc irc.oftc.net/6697 -ssl
/set irc.server.oftc.proxy "tor"
/connect oftc
/join #debian           # Debian (canal officiel)
```

### Étiquette dans les canaux

#### ✅ À FAIRE

- Lire le topic (`/topic`) avant de poser des questions
- Utiliser un site de pastebin pour du code long (paste.debian.net, pastebin.com)
- Être patient - les gens répondent quand ils sont disponibles
- Remercier ceux qui vous aident
- Rester courtois et respectueux

#### ❌ À ÉVITER

- Spammer ou répéter la même question
- Écrire en MAJUSCULES (considéré comme crier)
- Demander de l'aide en privé sans permission
- Poster des messages off-topic
- Utiliser des couleurs excessives
- Cross-poster (poser la même question sur plusieurs canaux)

---

## Messages privés et discussions

### Envoyer un message privé

```
# Ouvrir une fenêtre de query
/query <nick>

# Ou envoyer directement
/msg <nick> Bonjour, puis-je te poser une question ?
```

### Accepter/Refuser les messages privés

Par défaut, WeeChat accepte tous les messages privés. Pour plus de contrôle :

```
# Bloquer les queries non sollicitées
/set irc.look.anti_flood_pv_msg 0

# Ignorer un utilisateur
/ignore add <nick>
/ignore add SpamBot

# Voir la liste des ignorés
/ignore

# Retirer un ignore
/ignore del <nick>
```

### Sécurité dans les messages privés

⚠️ **Attention** :
- Ne partagez JAMAIS de mots de passe
- Méfiez-vous des liens suspects
- Vérifiez l'identité avec `/whois <nick>`
- Les admins IRC ne demandent jamais de mot de passe

---

## Fonctionnalités avancées

### Enregistrer son nick sur Libera.Chat

**Note** : Cela nécessite une adresse email et réduit l'anonymat !

```
# S'enregistrer (remplacez PASSWORD et email@example.com)
/msg NickServ REGISTER password email@example.com

# Vérifiez votre email et confirmez
/msg NickServ VERIFY REGISTER <nick> <code-from-email>

# Pour vous identifier lors de la prochaine connexion
/msg NickServ IDENTIFY password
```

Pour automatiser l'identification :

```
/set irc.server.libera.command "/msg NickServ IDENTIFY password"
/save
```

⚠️ **SÉCURISÉ** : Utilisez SASL à la place :

```
/set irc.server.libera.sasl_mechanism plain
/set irc.server.libera.sasl_username "votre_nick"
/set irc.server.libera.sasl_password "votre_password"
/save
```

### Utiliser des scripts WeeChat

WeeChat supporte des scripts en Python, Perl, Ruby, Lua, etc.

```
# Installer un script manager
/script install go.py           # Navigation rapide entre buffers
/script install colorize_nicks.py   # Colorer les nicks

# Lister les scripts disponibles
/script list

# Installer un script
/script install <nom>

# Charger/décharger un script
/script load <nom>
/script unload <nom>
```

Scripts utiles :
- **go.py** : Navigation rapide (`Alt+g` puis taper le nom du buffer)
- **buffers.pl** : Sidebar avec la liste des buffers
- **colorize_nicks.py** : Colore les pseudos
- **highmon.pl** : Moniteur de highlights

### Filtres et highlights

```
# Être notifié quand on vous mentionne
/set weechat.look.highlight "votre_nick"

# Ajouter des mots-clés à surveiller
/set weechat.look.highlight "votre_nick,keyword1,keyword2"

# Filtrer les join/part/quit pour réduire le bruit
/filter add irc_smart * irc_smart_filter *
```

### Layouts (disposition des fenêtres)

```
# Diviser horizontalement
/window splith

# Diviser verticalement
/window splitv

# Fusionner les fenêtres
/window merge

# Sauvegarder le layout
/layout store
/save
```

### Logging (journalisation)

```
# Activer les logs
/set logger.level.irc 3

# Emplacement des logs
# /home/weechat/.weechat/logs/

# ⚠️ IMPORTANT : Les logs peuvent contenir des infos sensibles !
# Ils sont déjà exclus du Git dans ce projet.
```

---

## Bonnes pratiques et étiquette IRC

### Règles d'or

1. **Lisez le topic** : `/topic` donne les règles et infos du canal
2. **Ne demandez pas "puis-je poser une question"** : Posez directement votre question
3. **Soyez patient** : IRC est asynchrone, attendez une réponse
4. **Utilisez pastebin** : Pour du code ou des logs > 3 lignes
5. **Restez on-topic** : Respectez le sujet du canal

### Poser une bonne question

#### ❌ Mauvais

```
<newbie> Quelqu'un peut m'aider ?
<newbie> C'est urgent !
<newbie> ???
```

#### ✅ Bon

```
<newbie> Bonjour ! J'ai une erreur "ModuleNotFoundError" en important numpy sur Python 3.9 (Debian 11). Voici le traceback : https://paste.debian.net/xxxxx
```

### Codes de conduite

La plupart des réseaux IRC ont un code de conduite :

- **Libera.Chat** : https://libera.chat/policies
- **OFTC** : https://www.oftc.net/Conduct/

Règles générales :
- Pas de harcèlement, discrimination, ou propos haineux
- Pas de spam ou flood
- Pas de partage de contenus illégaux
- Respect de la vie privée des autres

### Commandes d'opérateur (si vous êtes OP)

Si vous devenez opérateur d'un canal (`@`) :

```
# Donner/retirer OP
/mode #canal +o <nick>
/mode #canal -o <nick>

# Donner/retirer voice (+v)
/mode #canal +v <nick>
/mode #canal -v <nick>

# Kicker un user
/kick #canal <nick> [raison]

# Banner un user
/mode #canal +b *!*@hostname
/kick #canal <nick> banned

# Retirer un ban
/mode #canal -b *!*@hostname

# Changer le topic
/topic Nouvelle description du canal
```

---

## Sécurité et anonymat

### Vérifier que vous utilisez Tor

**À FAIRE RÉGULIÈREMENT** :

```bash
# Dans un autre terminal
docker compose exec weechat curl --socks5-hostname tor:9050 https://check.torproject.org/api/ip
```

Devrait afficher `"IsTor":true`.

### Protection de votre identité

#### ✅ Bonnes pratiques

1. **Pseudos** : Utilisez des nicks différents pour chaque réseau
2. **Informations personnelles** : Ne partagez JAMAIS
   - Votre localisation (même approximative)
   - Votre fuseau horaire
   - Votre employeur ou école
   - Des détails sur votre vie privée
3. **Patterns de connexion** : Variez vos heures de connexion
4. **Style d'écriture** : Évitez les expressions ou fautes caractéristiques
5. **Canaux** : Ne rejoignez pas de canaux liés à votre identité réelle

#### ❌ Erreurs courantes

- Utiliser le même nick que sur d'autres plateformes
- Mentionner sa ville ou pays
- Poster des screenshots avec des infos personnelles
- Utiliser des commandes comme `/time` qui révèlent votre fuseau
- Cliquer sur des liens sans vérifier (risque de déanonymisation)

### Commandes IRC et vie privée

```
# Ces commandes révèlent des informations :
/time          # Votre fuseau horaire
/version       # Version de votre client

# Désactiver les réponses automatiques
/set irc.ctcp.clientinfo ""
/set irc.ctcp.finger ""
/set irc.ctcp.source ""
/set irc.ctcp.time ""
/set irc.ctcp.userinfo ""
/set irc.ctcp.version ""
/save
```

### Authentification sécurisée

Si vous devez vous authentifier :

```
# Utiliser SASL (plus sûr que NickServ)
/set irc.server.libera.sasl_mechanism plain
/set irc.server.libera.sasl_username "votre_nick"
/set irc.server.libera.sasl_password "votre_password"

# ⚠️ Alternative : Certificat client (encore mieux)
# Voir weechat-certs/README.md

/set irc.server.libera.ssl_cert "/home/weechat/.weechat/certs/cert.pem"
/set irc.server.libera.sasl_mechanism external
```

### DCC et transferts de fichiers

⚠️ **ÉVITEZ DCC** : DCC révèle votre vraie IP !

```
# Désactiver DCC complètement
/set irc.look.display_dcc_notifications off
/set xfer.file.auto_accept_files off
```

---

## Dépannage

### Problèmes courants

#### 1. Impossible de se connecter

**Symptômes** : `Connection timed out` ou `Connection refused`

**Solutions** :

```bash
# Vérifier que Tor fonctionne
docker compose exec tor netstat -tln | grep 9050

# Vérifier la config du proxy
/proxy list
/set irc.server.*.proxy

# Tester la connexion Tor
docker compose exec weechat curl --socks5-hostname tor:9050 https://check.torproject.org/api/ip
```

#### 2. Nick déjà utilisé

**Symptômes** : `Nickname is already in use`

**Solutions** :

```
# Essayer un autre nick
/nick anon456

# Ou récupérer votre nick enregistré
/msg NickServ IDENTIFY password
/msg NickServ RELEASE ancien_nick password
/nick ancien_nick
```

#### 3. Cannot join channel (+i)

**Symptômes** : `Cannot join #canal (invite only)`

**Solutions** :

```
# Canal en mode +i, il faut une invitation
# Demander dans #canal-social ou au OP du canal
/join #canal-social
Bonjour, puis-je avoir une invitation pour #canal ?

# Un OP devra faire :
/invite votre_nick #canal
```

#### 4. Banned from channel (+b)

**Symptômes** : `Cannot join #canal (you are banned)`

**Solutions** :

- Vous êtes peut-être banni par erreur (ban large)
- Contactez les OPs dans un canal associé
- Certains canaux bannissent les proxies/Tor par défaut

#### 5. Messages non envoyés (+m moderated)

**Symptômes** : Vous tapez mais rien n'apparaît

**Solutions** :

Canal en mode modéré (+m). Seuls les OPs et +v peuvent parler.
Attendez qu'un OP vous donne voice (+v).

### Commandes de diagnostic WeeChat

```
# Version de WeeChat
/version

# Infos système
/debug dump

# Vérifier les plugins
/plugin list

# Recharger la config
/reload

# Voir tous les paramètres
/set

# Voir les filtres actifs
/filter list

# Buffer de debug
/debug buffer
```

### Logs utiles

```bash
# Logs WeeChat (sur l'hôte)
ls -lah weechat-data/.weechat/logs/

# Logs Tor
docker compose logs tor

# Logs du container WeeChat
docker compose logs weechat
```

---

## Annexes

### Glossaire IRC

- **AFK** : Away From Keyboard (absent)
- **BRB** : Be Right Back (je reviens)
- **ChanServ** : Bot qui gère les canaux
- **CTCP** : Client-To-Client Protocol
- **DCC** : Direct Client-to-Client (à éviter avec Tor !)
- **Flood** : Envoyer trop de messages rapidement
- **Highlight** : Mention de votre nick
- **Hostmask** : Identifiant complet `nick!user@host`
- **K-Line** : Ban du serveur entier
- **Lag** : Délai entre vous et le serveur
- **Netsplit** : Déconnexion entre serveurs d'un réseau
- **NickServ** : Bot qui gère les nicks enregistrés
- **OP/Operator** : Modérateur de canal (@)
- **Ping/Pong** : Test de connexion
- **Query** : Conversation privée
- **SASL** : Méthode d'authentification sécurisée
- **Services** : Bots du réseau (NickServ, ChanServ, etc.)
- **Topic** : Sujet/description d'un canal
- **Voice** : Droit de parole dans un canal modéré (+v)
- **Wallops** : Messages d'administration réseau
- **Whois** : Obtenir des infos sur un user

### Raccourcis clavier WeeChat

| Raccourci | Action |
|-----------|--------|
| `Alt + ←/→` | Buffer précédent/suivant |
| `Alt + a` | Aller au buffer avec activité |
| `Alt + h` | Aller au buffer hotlist (mentions) |
| `Alt + n` | Scroll vers highlight suivant |
| `Alt + p` | Scroll vers highlight précédent |
| `Ctrl + r` | Recherche dans l'historique |
| `Tab` | Complétion de nick/commande |
| `Alt + k` | Grab key (pour configurer raccourcis) |
| `Alt + =` | Filtres toggle |
| `Alt + -` | Filtres toggle (inverse) |
| `PgUp/PgDn` | Scroll historique |
| `Alt + PgUp/PgDn` | Scroll nicklist |

### Ressources externes

#### Documentation

- **WeeChat** : https://weechat.org/doc/
- **WeeChat Quick Start** : https://weechat.org/files/doc/stable/weechat_quickstart.en.html
- **Libera.Chat** : https://libera.chat/guides/
- **OFTC** : https://www.oftc.net/

#### Tutoriels

- IRC Guides : https://www.irchelp.org/
- Modern IRC Client Protocol : https://modern.ircdocs.horse/

#### Outils

- **Pastebin** : https://paste.debian.net/, https://pastebin.com/
- **IRC Search** : https://netsplit.de/ (statistiques réseaux IRC)

#### Canaux d'aide

```
# Libera.Chat
/join #libera      # Aide générale Libera.Chat
/join #weechat     # Support WeeChat

# OFTC
/join #oftc        # Aide OFTC
```

---

## Conclusion

IRC est un protocole simple mais puissant. Avec ce guide, vous avez toutes les bases pour :

✅ Vous connecter de manière anonyme via Tor
✅ Naviguer dans WeeChat efficacement
✅ Rejoindre et participer à des canaux
✅ Respecter l'étiquette et les bonnes pratiques
✅ Protéger votre vie privée

**Conseil final** : IRC est une communauté. Soyez respectueux, patient et n'hésitez pas à aider les autres une fois que vous serez plus expérimenté !

Bon chat ! 🎉

---

**Aide supplémentaire** : `/help` dans WeeChat ou rejoignez `#weechat` sur Libera.Chat
