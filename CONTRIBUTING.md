# Contributing

Merci de votre intérêt pour contribuer au projet WeeChat-Tor !

## Comment contribuer

### 🐛 Signaler un bug

1. Vérifiez d'abord si le bug n'a pas déjà été signalé
2. Créez une issue avec :
   - Description claire du problème
   - Étapes pour reproduire
   - Comportement attendu vs actuel
   - Environnement (OS, version Docker, etc.)
   - Logs pertinents (anonymisés !)

### 💡 Proposer une amélioration

1. Créez une issue pour discuter de l'idée
2. Attendez les retours avant de coder
3. Fork le projet et créez une branche
4. Implémentez votre amélioration
5. Créez une Pull Request

### 🔒 Signaler une vulnérabilité de sécurité

Consultez [SECURITY.md](SECURITY.md) pour savoir comment signaler une vulnérabilité de manière responsable.

## Standards de code

### Shell scripts

- Utilisez `#!/usr/bin/env bash` ou `#!/bin/bash`
- Incluez `set -euo pipefail` en début de script
- Commentez le code non-évident
- Testez avec ShellCheck si possible

### Docker

- Images minimales (Alpine ou Debian slim)
- Pas de `latest` dans les FROM
- Utilisateur non-root quand possible
- Documentation des ports et volumes

### Documentation

- Mettez à jour le README si nécessaire
- Ajoutez des commentaires dans le code
- Documentez les nouvelles fonctionnalités

## Tests

Avant de soumettre une PR :

```bash
# Construire les images
docker compose build --no-cache

# Lancer les tests
./test.sh

# Tester manuellement
docker compose up -d
docker compose logs -f
```

## Checklist pour les Pull Requests

- [ ] Le code suit les standards du projet
- [ ] Les tests passent (`./test.sh`)
- [ ] La documentation est à jour
- [ ] Les commits sont clairs et atomiques
- [ ] Pas de données sensibles commitées (certificats, clés, logs)
- [ ] Le `.gitignore` est à jour si nécessaire

## Revue de code

- Soyez respectueux et constructif
- Concentrez-vous sur le code, pas sur la personne
- Expliquez le "pourquoi" de vos suggestions
- Acceptez les désaccords de manière professionnelle

## License

En contribuant, vous acceptez que vos contributions soient sous licence MIT, comme le reste du projet.

## Questions ?

N'hésitez pas à ouvrir une issue pour poser des questions !
