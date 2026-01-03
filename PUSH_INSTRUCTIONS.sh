#!/usr/bin/env bash
# ============================================================================
# Aezka OS - Push Instructions Script
# ============================================================================
#
# Este script contiene las instrucciones para hacer push del proyecto Aezka
# al repositorio remoto en GitHub.
#
# IMPORTANTE: Ejecuta este script desde tu sistema Fedora local con
# credenciales de GitHub configuradas.
#
# Implementador: Mister_F - 2025
# ============================================================================

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}"
cat << "EOF"
    ___                __
   /   |  ___  ____   / /______ _
  / /| | / _ \|_  /  / //_/ __ `/
 / ___ |/  __/ / /__/ ,< / /_/ /
/_/  |_|\___/ /___/_/|_|\__,_/

    Aezka OS - Push to Remote
EOF
echo -e "${NC}"

echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Commits Pendientes de Push:${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
echo ""

git log --oneline origin/claude/create-aezka-os-vlUXd..HEAD 2>/dev/null || {
    echo -e "${BLUE}Mostrando últimos 4 commits:${NC}"
    git log --oneline -4
}

echo ""
echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Remotes Configurados:${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
git remote -v
echo ""

echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Instrucciones de Push:${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${CYAN}1. Verificar rama actual:${NC}"
echo "   git branch"
echo ""
echo -e "${CYAN}2. Push de la rama de desarrollo:${NC}"
echo "   git push -u origin claude/create-aezka-os-vlUXd"
echo ""
echo -e "${CYAN}3. Push del tag v0.1.0:${NC}"
echo "   git push origin v0.1.0"
echo ""
echo -e "${CYAN}4. (Opcional) Push de master:${NC}"
echo "   git checkout master"
echo "   git push origin master"
echo ""

echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}¿Deseas hacer push ahora? (y/n)${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    echo ""
    echo -e "${BLUE}Haciendo push de la rama...${NC}"

    if git push -u origin claude/create-aezka-os-vlUXd; then
        echo -e "${GREEN}✓ Push de rama exitoso!${NC}"

        echo ""
        echo -e "${BLUE}Haciendo push del tag v0.1.0...${NC}"

        if git push origin v0.1.0; then
            echo -e "${GREEN}✓ Push de tag exitoso!${NC}"
            echo ""
            echo -e "${GREEN}════════════════════════════════════════════${NC}"
            echo -e "${GREEN}  ¡Push completado exitosamente! 🎉${NC}"
            echo -e "${GREEN}════════════════════════════════════════════${NC}"
        else
            echo -e "${YELLOW}⚠ Push de tag falló (puede que ya exista)${NC}"
        fi
    else
        echo -e "${RED}✗ Push de rama falló${NC}"
        echo ""
        echo -e "${YELLOW}Posibles soluciones:${NC}"
        echo "1. Verifica tus credenciales de GitHub"
        echo "2. Asegúrate de tener permisos en el repositorio"
        echo "3. Verifica tu conexión a internet"
        exit 1
    fi
else
    echo ""
    echo -e "${YELLOW}Push cancelado. Puedes ejecutarlo manualmente con:${NC}"
    echo "  git push -u origin claude/create-aezka-os-vlUXd"
    echo "  git push origin v0.1.0"
fi

echo ""
