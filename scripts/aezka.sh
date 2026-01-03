#!/usr/bin/env bash
# ============================================================================
# Aezka OS - Build Script
# Sistema Operativo Modular | Seguro | Accesible
# ============================================================================
#
# Script de compilación y gestión de Aezka OS
#
# Uso:
#   ./scripts/aezka.sh build      - Compilar Aezka
#   ./scripts/aezka.sh run        - Ejecutar Aezka en QEMU
#   ./scripts/aezka.sh clean      - Limpiar archivos de compilación
#   ./scripts/aezka.sh rebuild    - Limpiar y recompilar
#   ./scripts/aezka.sh version    - Mostrar versión de Aezka
#   ./scripts/aezka.sh help       - Mostrar ayuda
#
# Implementador: Mister_F - 2025
# Basado en sistema de build de Redox OS
# Copyright (c) 2025 Aezka & Mister_F
# Copyright (c) 2016 Redox OS Developers
# ============================================================================

set -e  # Salir en caso de error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Información de versión de Aezka
AEZKA_VERSION_MAJOR=0
AEZKA_VERSION_MINOR=1
AEZKA_VERSION_PATCH=0
AEZKA_CODENAME="Taquion"
AEZKA_BUILD_DATE=$(date +%Y%m%d)

# Configuración
CONFIG_NAME="aezka"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# ============================================================================
# FUNCIONES DE UTILIDAD
# ============================================================================

print_banner() {
    echo -e "${CYAN}"
    cat << "EOF"
    ___                __
   /   |  ___  ____   / /______ _
  / /| | / _ \|_  /  / //_/ __ `/
 / ___ |/  __/ / /__/ ,< / /_/ /
/_/  |_|\___/ /___/_/|_|\__,_/

    Sistema Operativo Modular
EOF
    echo -e "${NC}"
}

print_version() {
    echo -e "${GREEN}Aezka OS${NC}"
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${CYAN}Versión Larga:${NC} Aezka ($AEZKA_CODENAME | $AEZKA_VERSION_MAJOR.$AEZKA_VERSION_MINOR.$AEZKA_VERSION_PATCH | $AEZKA_BUILD_DATE)"
    echo -e "${CYAN}Versión Corta:${NC} Aezka ($AEZKA_CODENAME)"
    echo -e "${CYAN}Kernel:${NC} Basado en Redox OS"
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# ============================================================================
# FUNCIONES PRINCIPALES
# ============================================================================

aezka_build() {
    print_banner
    print_info "Compilando Aezka OS..."
    print_info "Configuración: $CONFIG_NAME"

    cd "$PROJECT_ROOT"

    # Verificar que existe la configuración
    if [ ! -f "config/x86_64/$CONFIG_NAME.toml" ]; then
        print_error "No se encuentra la configuración: config/x86_64/$CONFIG_NAME.toml"
        exit 1
    fi

    print_info "Iniciando compilación..."
    make all CONFIG_NAME="$CONFIG_NAME"

    print_success "Aezka compilado exitosamente!"
    print_version
}

aezka_run() {
    print_banner
    print_info "Ejecutando Aezka OS en QEMU..."

    cd "$PROJECT_ROOT"

    # Verificar que existe la imagen compilada
    if [ ! -f "build/x86_64/$CONFIG_NAME/harddrive.img" ]; then
        print_error "No se encuentra la imagen compilada."
        print_info "Ejecuta primero: $0 build"
        exit 1
    fi

    print_info "Iniciando QEMU..."
    make qemu CONFIG_NAME="$CONFIG_NAME"
}

aezka_clean() {
    print_banner
    print_info "Limpiando archivos de compilación..."

    cd "$PROJECT_ROOT"

    if [ -d "build" ]; then
        print_info "Eliminando directorio build/..."
        make clean CONFIG_NAME="$CONFIG_NAME"
        print_success "Limpieza completada!"
    else
        print_info "No hay archivos para limpiar."
    fi
}

aezka_rebuild() {
    print_banner
    print_info "Recompilando Aezka OS desde cero..."

    aezka_clean
    echo ""
    aezka_build
}

aezka_help() {
    print_banner
    print_version
    echo ""
    echo -e "${GREEN}Comandos disponibles:${NC}"
    echo -e "  ${CYAN}build${NC}      - Compilar Aezka OS"
    echo -e "  ${CYAN}run${NC}        - Ejecutar Aezka en QEMU"
    echo -e "  ${CYAN}clean${NC}      - Limpiar archivos de compilación"
    echo -e "  ${CYAN}rebuild${NC}    - Limpiar y recompilar"
    echo -e "  ${CYAN}version${NC}    - Mostrar información de versión"
    echo -e "  ${CYAN}help${NC}       - Mostrar esta ayuda"
    echo ""
    echo -e "${GREEN}Ejemplos:${NC}"
    echo -e "  ./scripts/aezka.sh build"
    echo -e "  ./scripts/aezka.sh run"
    echo -e "  ./scripts/aezka.sh rebuild"
    echo ""
    echo -e "${GREEN}Compilación Manual (alternativa):${NC}"
    echo -e "  make all CONFIG_NAME=aezka"
    echo -e "  make qemu CONFIG_NAME=aezka"
    echo ""
    echo -e "${GREEN}Más información:${NC}"
    echo -e "  README: $PROJECT_ROOT/README.md"
    echo -e "  Docs:   $PROJECT_ROOT/docs/doc.md"
    echo ""
}

# ============================================================================
# PROCESAMIENTO DE ARGUMENTOS
# ============================================================================

case "${1:-help}" in
    build)
        aezka_build
        ;;
    run)
        aezka_run
        ;;
    clean)
        aezka_clean
        ;;
    rebuild)
        aezka_rebuild
        ;;
    version)
        print_banner
        print_version
        ;;
    help|--help|-h)
        aezka_help
        ;;
    *)
        print_error "Comando desconocido: $1"
        echo ""
        aezka_help
        exit 1
        ;;
esac

exit 0
