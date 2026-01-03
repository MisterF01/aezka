# Guía de Compilación de Aezka OS en WSL (Windows Subsystem for Linux)

## ⚠️ Detectado: Ubuntu 24.04 en WSL

Has intentado compilar desde `/mnt/z/Aezka`, lo que indica que estás en **WSL con Windows**.

---

## 🚀 Pasos para Compilar Aezka en WSL

### 1. Instalar Rust

```bash
# Instalar Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Cargar entorno de Rust
source $HOME/.cargo/env

# Configurar componentes necesarios
rustup component add rust-src
rustup target add x86_64-unknown-redox
```

### 2. Instalar Dependencias del Sistema (Ubuntu)

```bash
# Actualizar paquetes
sudo apt-get update

# Instalar dependencias
sudo apt-get install -y \
    build-essential \
    make \
    cmake \
    nasm \
    pkg-config \
    libssl-dev \
    curl \
    wget \
    git \
    fuse3 \
    libfuse3-dev \
    qemu-system-x86
```

### 3. Instalar Herramientas de Rust

```bash
# Instalar cbindgen (necesario para Redox OS)
cargo install cbindgen

# Verificar instalación
cbindgen --version
```

### 4. Obtener Código Base de Redox OS

```bash
# Navegar a tu directorio Aezka
cd /mnt/z/Aezka  # o la ruta donde tengas Aezka

# Descargar código base de Redox OS
git clone --depth=1 https://gitlab.redox-os.org/redox-os/redox.git redox-temp
cp -r redox-temp/* .
rm -rf redox-temp
```

### 5. Compilar en Modo Nativo (Sin Podman)

**Nota**: Podman no funciona bien en WSL, así que usaremos compilación nativa.

```bash
# Asegurarse de que Rust esté en el PATH
source $HOME/.cargo/env

# Compilar Aezka (modo nativo, sin Podman)
make all CONFIG_NAME=aezka PODMAN_BUILD=0
```

O usando el script de Aezka:

```bash
# Modificar el script para modo nativo
export PODMAN_BUILD=0

# Compilar
./scripts/aezka.sh build
```

---

## 🔧 Script de Setup Automático para WSL

Crea un archivo `setup-wsl.sh` en tu directorio Aezka:

```bash
#!/bin/bash
# Setup de Aezka OS para WSL

set -e

echo "=== Aezka OS Setup para WSL ==="

# 1. Instalar Rust si no está instalado
if ! command -v rustc &> /dev/null; then
    echo "Instalando Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
fi

# 2. Configurar Rust
echo "Configurando Rust..."
rustup component add rust-src
rustup target add x86_64-unknown-redox

# 3. Instalar dependencias del sistema
echo "Instalando dependencias del sistema..."
sudo apt-get update
sudo apt-get install -y \
    build-essential make cmake nasm \
    pkg-config libssl-dev fuse3 libfuse3-dev \
    qemu-system-x86

# 4. Instalar cbindgen
if ! command -v cbindgen &> /dev/null; then
    echo "Instalando cbindgen..."
    cargo install cbindgen
fi

# 5. Obtener código base de Redox OS
if [ ! -f "Makefile" ]; then
    echo "Descargando código base de Redox OS..."
    git clone --depth=1 https://gitlab.redox-os.org/redox-os/redox.git redox-temp
    cp -r redox-temp/* .
    rm -rf redox-temp
fi

echo ""
echo "=== Setup Completado ==="
echo ""
echo "Para compilar Aezka:"
echo "  source \$HOME/.cargo/env"
echo "  make all CONFIG_NAME=aezka PODMAN_BUILD=0"
echo ""
echo "O ejecutar en QEMU:"
echo "  make qemu CONFIG_NAME=aezka PODMAN_BUILD=0"
echo ""
```

Luego ejecuta:
```bash
chmod +x setup-wsl.sh
./setup-wsl.sh
```

---

## ⚡ Quick Start (Una línea)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
source $HOME/.cargo/env && \
rustup component add rust-src && rustup target add x86_64-unknown-redox && \
sudo apt-get update && sudo apt-get install -y build-essential make cmake nasm pkg-config libssl-dev fuse3 libfuse3-dev qemu-system-x86 && \
cargo install cbindgen && \
git clone --depth=1 https://gitlab.redox-os.org/redox-os/redox.git redox-temp && \
cp -r redox-temp/* . && rm -rf redox-temp && \
make all CONFIG_NAME=aezka PODMAN_BUILD=0
```

---

## 🎮 Ejecutar en QEMU

**IMPORTANTE**: QEMU con interfaz gráfica no funciona bien en WSL. Opciones:

### Opción 1: Modo Texto (Funciona en WSL)
```bash
make qemu CONFIG_NAME=aezka PODMAN_BUILD=0 vga=no
```

### Opción 2: Usar Windows (Recomendado)
1. Compila en WSL (Linux)
2. Copia el archivo `.img` generado a Windows
3. Usa QEMU for Windows para ejecutar

```powershell
# En PowerShell (Windows)
qemu-system-x86_64.exe -drive file=harddrive.img,format=raw -m 1024
```

### Opción 3: WSLg (Si tienes Windows 11)
```bash
# WSL2 con WSLg soporta aplicaciones gráficas
make qemu CONFIG_NAME=aezka PODMAN_BUILD=0
```

---

## 🆘 Solución de Problemas Comunes en WSL

### Error: "rustup not found"
```bash
source $HOME/.cargo/env
# Añadir a ~/.bashrc para permanencia
echo 'source $HOME/.cargo/env' >> ~/.bashrc
```

### Error: "cbindgen not found"
```bash
cargo install cbindgen
```

### Error: "No rule to make target 'all'"
```bash
# Necesitas el código base de Redox OS
git clone --depth=1 https://gitlab.redox-os.org/redox-os/redox.git redox-temp
cp -r redox-temp/* .
rm -rf redox-temp
```

### Error: "Permission denied" al compilar
```bash
# WSL puede tener problemas con permisos
# Compila desde un directorio en el sistema Linux nativo
mkdir -p ~/aezka-build
cp -r /mnt/z/Aezka/* ~/aezka-build/
cd ~/aezka-build
make all CONFIG_NAME=aezka PODMAN_BUILD=0
```

### QEMU no inicia (sin pantalla)
```bash
# En WSL, usa modo serial
make qemu CONFIG_NAME=aezka PODMAN_BUILD=0 vga=no
```

---

## 📝 Notas Importantes

1. **Podman no funciona en WSL1**: Usa `PODMAN_BUILD=0` siempre
2. **WSL2 es mejor**: Si puedes, actualiza a WSL2 para mejor compatibilidad
3. **Performance**: Compila en sistema de archivos Linux (`~/`) no en `/mnt/`, es más rápido
4. **QEMU gráfico**: Limitado en WSL, considera usar QEMU en Windows nativo

---

## 📞 Soporte

- Issues: https://github.com/MisterF01/Aezka/issues
- Docs: BUILD_INSTRUCTIONS.md

---

Versión: Aezka (Taquion | 0.1.0 | 20250103)
Implementador: Mister_F
