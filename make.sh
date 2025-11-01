#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

project_root="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$project_root/tor" "$project_root/tor-data" \
         "$project_root/weechat-data" "$project_root/weechat-certs"

# Convertir torrc en LF si dos2unix présent
if command -v dos2unix >/dev/null 2>&1; then
  dos2unix "$project_root/tor/torrc" >/dev/null 2>&1 || true
fi

echo "[1/4] Build tor…"
docker compose build --no-cache tor

echo "[2/4] Vérification config tor…"
docker compose up -d tor
docker compose exec tor tor --verify-config -f /etc/tor/torrc

echo "[3/4] Build client weechat…"
docker compose build --no-cache weechat

echo "[4/4] Démarrage des services…"
docker compose up -d
docker compose ps

echo "Logs tor (Ctrl-C pour quitter)…"
docker compose logs -f tor || true

echo "Attache à Weechat (Ctrl-PQ pour détacher)…"
docker attach weechat_tor_client || true

# Aide rapide:
cat <<'TIP'

Commandes utiles:
  docker compose logs -f weechat
  docker compose exec -it weechat bash
  # test de sortie via Tor depuis le client:
  docker compose exec weechat curl --socks5-hostname tor:9050 https://check.torproject.org/api/ip

Dans Weechat:
  /proxy add tor socks5 tor 9050
  /set irc.server_default.proxy "tor"
  /set irc.server_default.username anon
  /set irc.server_default.realname nobody
  /server add libera irc.libera.chat/6697 -ssl -autoconnect
  /connect libera

TIP

