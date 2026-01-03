#!/usr/bin/env bash
# ============================================================================
# Aezka OS - Setup Automatizado
# ============================================================================
#
# Este script automatiza el setup completo de Aezka OS:
# 1. Verifica dependencias
# 2. Obtiene código base de Redox OS
# 3. Ejecuta bootstrap
# 4. Prepara el entorno de compilación
#
# Uso:
#   ./setup-aezka.sh
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

print_banner() {
    echo -e "${CYAN}"
    cat << "EOF"
    ___                __
   /   |  ___  ____   / /______ _
  / /| | / _ \|_  /  / //_/ __ `/
 / ___ |/  __/ / /__/ ,< / /_/ /
/_/  |_|\___/ /___/_/|_|\__,_/

       Aezka OS - Setup
EOF
    echo -e "${NC}"
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

check_command() {
    if command -v "$1" &> /dev/null; then
        print_success "$1 está instalado"
        return 0
    else
        print_warning "$1 NO está instalado"
        return 1
    fi
}

print_banner

echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Verificando Dependencias${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Verificar dependencias críticas
MISSING_DEPS=0

check_command "git" || MISSING_DEPS=1
check_command "make" || MISSING_DEPS=1
check_command "rustc" || MISSING_DEPS=1
check_command "cargo" || MISSING_DEPS=1
check_command "podman" || check_command "docker" || MISSING_DEPS=1

echo ""

if [ $MISSING_DEPS -eq 1 ]; then
    print_error "Faltan dependencias críticas"
    echo ""
    echo -e "${YELLOW}Por favor instala las dependencias:${NC}"
    echo ""
    echo "En Fedora:"
    echo "  sudo dnf groupinstall -y 'Development Tools'"
    echo "  sudo dnf install -y rust cargo podman make git"
    echo ""
    echo "Para instalar Rust:"
    echo "  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    echo ""
    echo "Ver BUILD_INSTRUCTIONS.md para la lista completa"
    echo ""
    exit 1
fi

print_success "Todas las dependencias críticas están instaladas"
echo ""

echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Obteniendo Código Base de Redox OS${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Verificar si ya tenemos Redox OS
if [ -f "podman_bootstrap.sh" ] && [ -d "mk" ]; then
    print_info "Código de Redox OS ya está presente"
else
    print_info "Descargando código base de Redox OS..."
    print_info "Esto puede tardar varios minutos..."

    if [ -d "redox-temp" ]; then
        rm -rf redox-temp
    fi

    git clone --depth=1 https://gitlab.redox-os.org/redox-os/redox.git redox-temp

    print_info "Copiando archivos..."
    cp -r redox-temp/* .
    cp -r redox-temp/.* . 2>/dev/null || true

    rm -rf redox-temp

    print_success "Código de Redox OS obtenido"
fi

echo ""

echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Verificando Configuración de Aezka${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Verificar que la configuración de Aezka existe
if [ -f "config/x86_64/aezka.toml" ]; then
    print_success "Configuración aezka.toml encontrada"
else
    print_error "config/x86_64/aezka.toml no encontrada"
    exit 1
fi

if [ -f "scripts/aezka.sh" ]; then
    print_success "Script aezka.sh encontrado"
    chmod +x scripts/aezka.sh
else
    print_error "scripts/aezka.sh no encontrado"
    exit 1
fi

echo ""

echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Ejecutando Bootstrap${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Decidir qué bootstrap usar
if command -v podman &> /dev/null; then
    print_info "Ejecutando bootstrap con Podman..."
    ./podman_bootstrap.sh
elif command -v docker &> /dev/null; then
    print_info "Ejecutando bootstrap con Docker..."
    ./podman_bootstrap.sh
else
    print_warning "Podman/Docker no disponible, usando bootstrap nativo..."
    if [ -f "native_bootstrap.sh" ]; then
        ./native_bootstrap.sh
    else
        print_error "native_bootstrap.sh no encontrado"
        exit 1
    fi
fi

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}   ✓ Setup Completado Exitosamente${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${CYAN}Versión:${NC} Aezka (Taquion | 0.1.0)"
echo ""
echo -e "${YELLOW}Próximos pasos:${NC}"
echo ""
echo -e "${CYAN}1. Compilar Aezka:${NC}"
echo "   ./scripts/aezka.sh build"
echo ""
echo -e "${CYAN}2. Ejecutar en QEMU:${NC}"
echo "   ./scripts/aezka.sh run"
echo ""
echo -e "${CYAN}3. Ver ayuda:${NC}"
echo "   ./scripts/aezka.sh help"
echo ""
echo -e "${CYAN}4. Leer documentación:${NC}"
echo "   cat docs/doc.md"
echo ""
echo -e "${GREEN}¡Bienvenido a Aezka OS!${NC}"
echo ""
