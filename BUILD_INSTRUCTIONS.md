# Instrucciones de Compilación de Aezka OS

## ⚠️ IMPORTANTE

Para compilar Aezka OS necesitas estar en tu **sistema Fedora local** con todas las dependencias instaladas.

El código está listo, pero la compilación requiere:
1. Podman o Docker
2. Rust y herramientas de compilación
3. QEMU (para ejecutar)
4. Otras dependencias de Redox OS

---

## 📋 Instalación de Dependencias en Fedora

Ejecuta estos comandos en tu sistema Fedora:

```bash
# 1. Herramientas de desarrollo
sudo dnf groupinstall -y "Development Tools" "C Development Tools and Libraries"

# 2. Dependencias de Redox/Aezka
sudo dnf install -y \
    rust cargo rustfmt \
    podman \
    make cmake nasm \
    qemu qemu-system-x86 \
    fuse-devel \
    git curl wget \
    pkg-config openssl-devel \
    gmp-devel mpfr-devel libmpc-devel \
    texinfo bison flex \
    perl-FindBin perl-File-Compare perl-File-Copy perl-lib

# 3. Configurar Rust
rustup default stable
rustup component add rust-src
rustup target add x86_64-unknown-redox
```

---

## 🚀 Proceso de Compilación

### Opción A: Usando Podman (Recomendado)

```bash
# 1. Clonar el repositorio
git clone https://github.com/MisterF01/Aezka.git
cd Aezka

# 2. Obtener código base de Redox OS
# Como nuestro repo solo tiene archivos de Aezka, necesitamos Redox
git clone --depth=1 https://gitlab.redox-os.org/redox-os/redox.git redox-temp
cp -r redox-temp/* .
rm -rf redox-temp

# 3. Bootstrap inicial (solo primera vez)
./podman_bootstrap.sh

# 4. Compilar usando el script de Aezka
./scripts/aezka.sh build

# 5. Ejecutar en QEMU
./scripts/aezka.sh run
```

### Opción B: Compilación Nativa (Sin Podman)

```bash
# 1-2. Igual que arriba (clonar y obtener Redox)

# 3. Bootstrap nativo
./native_bootstrap.sh

# 4. Compilar
make all CONFIG_NAME=aezka

# 5. Ejecutar
make qemu CONFIG_NAME=aezka
```

---

## 🔧 Script Simplificado de Setup

Crea un archivo `setup-aezka.sh` en tu sistema Fedora:

```bash
#!/bin/bash
# Setup completo de Aezka OS

set -e

echo "=== Aezka OS Setup ==="

# 1. Clonar repositorio
if [ ! -d "Aezka" ]; then
    echo "Clonando Aezka..."
    git clone https://github.com/MisterF01/Aezka.git
fi

cd Aezka

# 2. Obtener código base de Redox
echo "Obteniendo código base de Redox OS..."
if [ ! -f "podman_bootstrap.sh" ]; then
    git clone --depth=1 https://gitlab.redox-os.org/redox-os/redox.git redox-temp
    cp -r redox-temp/* .
    cp -r redox-temp/.* . 2>/dev/null || true
    rm -rf redox-temp
    echo "✓ Código de Redox OS obtenido"
fi

# 3. Bootstrap
echo "Ejecutando bootstrap..."
./podman_bootstrap.sh

echo ""
echo "=== Setup Completo ==="
echo ""
echo "Para compilar Aezka:"
echo "  ./scripts/aezka.sh build"
echo ""
echo "Para ejecutar en QEMU:"
echo "  ./scripts/aezka.sh run"
echo ""
```

Luego ejecuta:
```bash
chmod +x setup-aezka.sh
./setup-aezka.sh
```

---

## 📝 Explicación

### ¿Por qué necesito clonar Redox OS?

Nuestro repositorio GitHub contiene **solo los componentes personalizados de Aezka**:
- Configuración `aezka.toml`
- Scripts `aezka.sh`
- Documentación
- Módulos propios en `aezka/`

Para compilar, necesitas **el código completo de Redox OS** (kernel, drivers, libraries, etc.) que no está en nuestro repo para mantenerlo ligero.

### ¿Esto es normal?

Sí, es la práctica estándar cuando creas una distribución basada en otro OS:
- Tu repo = Personalizaciones
- Repo upstream (Redox) = Código base
- Al compilar = Combinas ambos

### Flujo de Trabajo

```
GitHub (Aezka)          GitLab (Redox OS)
     |                        |
     |                        |
     +----------+-------------+
                |
         Tu Máquina Local
                |
        (Compilar Aezka)
```

---

## ⚡ Quick Start (Una vez instaladas dependencias)

```bash
# Setup completo
git clone https://github.com/MisterF01/Aezka.git && cd Aezka
git clone --depth=1 https://gitlab.redox-os.org/redox-os/redox.git redox-temp
cp -r redox-temp/* . && rm -rf redox-temp
./podman_bootstrap.sh

# Compilar y ejecutar
./scripts/aezka.sh build
./scripts/aezka.sh run
```

---

## 🆘 Solución de Problemas

### Error: "podman: command not found"
```bash
sudo dnf install -y podman
```

### Error: "rustc: command not found"
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

### Error: "No such file: mk/config.mk"
Necesitas clonar Redox OS base (ver arriba)

### Error en compilación
```bash
# Limpiar y reintentar
./scripts/aezka.sh clean
./scripts/aezka.sh build
```

---

## 📞 Soporte

- Issues: https://github.com/MisterF01/Aezka/issues
- Docs Redox: https://doc.redox-os.org/book/
- Docs Aezka: docs/doc.md

---

Versión: Aezka (Taquion | 0.1.0 | 20250103)
Implementador: Mister_F
