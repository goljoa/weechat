#!/usr/bin/env bash
set -euo pipefail

echo "=== Test du setup WeeChat + Tor ==="
echo ""

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test 1 : Services running
echo -n "1. Vérification des services... "
if docker compose ps | grep -q "weechat_tor_tor.*Up.*healthy" && \
   docker compose ps | grep -q "weechat_tor_client.*Up"; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    echo "Les services ne sont pas tous démarrés !"
    docker compose ps
    exit 1
fi

# Test 2 : Tor port listening
echo -n "2. Vérification du port Tor 9050... "
if docker compose exec tor netstat -tln | grep -q ':9050'; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    exit 1
fi

# Test 3 : Connectivité Tor depuis weechat
echo -n "3. Test de connectivité Tor... "
RESULT=$(docker compose exec weechat curl -s --socks5-hostname tor:9050 https://check.torproject.org/api/ip 2>/dev/null || echo "FAIL")
if echo "$RESULT" | grep -q '"IsTor":true'; then
    IP=$(echo "$RESULT" | grep -o '"IP":"[^"]*"' | cut -d'"' -f4)
    echo -e "${GREEN}✓${NC} (IP Tor: $IP)"
else
    echo -e "${RED}✗${NC}"
    echo "Résultat: $RESULT"
    exit 1
fi

# Test 4 : WeeChat est lancé
echo -n "4. Vérification de WeeChat... "
if docker compose exec weechat pgrep -x weechat > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⚠${NC} WeeChat ne semble pas être lancé"
    docker compose logs weechat --tail 5
fi

echo ""
echo -e "${GREEN}=== Tous les tests passent ! ===${NC}"
echo ""
echo "Pour vous connecter à WeeChat :"
echo "  docker attach weechat_tor_client"
echo ""
echo "Dans WeeChat, configurez le proxy Tor :"
echo "  /proxy add tor socks5 tor 9050"
echo "  /set irc.server_default.proxy \"tor\""
echo ""
