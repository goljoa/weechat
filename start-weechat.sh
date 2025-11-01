#!/bin/bash
set -euo pipefail

# Créer le dossier s'il n'existe pas, mais ne pas forcer les permissions
# si le volume est monté (cela échouerait avec "Operation not permitted")
if [ ! -d "$HOME/.weechat" ]; then
  mkdir -p "$HOME/.weechat"
fi

# WeeChat supporte nativement les proxies SOCKS5
# Configuration à faire dans WeeChat :
#   /proxy add tor socks5 tor 9050
#   /set irc.server_default.proxy "tor"
#
# Certificats clients (optionnel) :
#   /set weechat.network.gnutls_ca_system on
#   /set irc.server.XXX.ssl_cert "/home/weechat/.weechat/certs/cert.pem"

# On lance quand même avec torsocks pour capturer tout trafic réseau non-proxy
exec torsocks weechat

