# Aezka OS - Sistema Operativo Modular

```
    ___                __
   /   |  ___  ____   / /______ _
  / /| | / _ \|_  /  / //_/ __ `/
 / ___ |/  __/ / /__/ ,< / /_/ /
/_/  |_|\___/ /___/_/|_|\__,_/

Sistema Operativo Modular | Seguro | Accesible
```

**Versión**: 0.1.0 "Taquion"
**Basado en**: [Redox OS](https://www.redox-os.org/)
**Licencia**: MIT
**Lenguaje**: Rust

## 🎯 ¿Qué es Aezka?

Aezka es un sistema operativo modular construido sobre la sólida base de **Redox OS**.
Está diseñado con enfoque en:

- **🔧 Modularidad**: Cada componente es independiente y extensible
- **🔒 Seguridad**: Múltiples capas de protección integradas
- **🌐 Accesibilidad**: Comandos en español e interfaz intuitiva
- **💼 Profesionalismo**: Calidad comercial con código abierto

## 📋 Características Principales

- **Arquitectura Microkernel**: Heredada de Redox OS
- **Escrito en Rust**: Seguridad de memoria garantizada
- **Capacidades de Tiempo Real**: Scheduler personalizado
- **Entorno de Escritorio**: Interfaz moderna y accesible
- **Comandos en Español**: Interfaz localizada
- **Open Source**: Licencia MIT

## 🏗️ Arquitectura

Aezka mantiene la arquitectura de microkernel de Redox OS y añade:

```
Aezka/
├── kernel/           # Kernel de Redox OS
├── drivers/          # Drivers del sistema (Redox)
├── relibc/           # Biblioteca C compatible (Redox)
├── redoxfs/          # Sistema de archivos (Redox)
└── aezka/            # Componentes propios de Aezka
    ├── escritorio/   # Entorno de escritorio
    ├── scheduler/    # Scheduler de tiempo real
    └── herramientas/ # Utilidades propias
```

## 📦 Requisitos del Sistema

### Para Compilar en Fedora

```bash
# Instalar herramientas de desarrollo
sudo dnf groupinstall -y "Development Tools" "C Development Tools and Libraries"

# Instalar dependencias de Redox/Aezka
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

# Configurar Rust
rustup default stable
rustup component add rust-src
rustup target add x86_64-unknown-redox
```

## 🚀 Compilación

### Quick Start (Opción Automática)

```bash
# 1. Clonar Aezka
git clone https://github.com/MisterF01/Aezka.git
cd Aezka

# 2. Setup automático (descarga Redox OS y configura todo)
./setup-aezka.sh

# 3. Compilar y ejecutar
./scripts/aezka.sh build
./scripts/aezka.sh run
```

### Opción Manual

**Importante**: Este repositorio contiene solo los componentes personalizados de Aezka.
Para compilar, primero necesitas el código base de Redox OS:

```bash
# 1. Clonar Aezka
git clone https://github.com/MisterF01/Aezka.git
cd Aezka

# 2. Obtener código base de Redox OS
git clone --depth=1 https://gitlab.redox-os.org/redox-os/redox.git redox-temp
cp -r redox-temp/* .
rm -rf redox-temp

# 3. Bootstrap (solo primera vez)
./podman_bootstrap.sh

# 4. Compilar Aezka
./scripts/aezka.sh build

# 5. Ejecutar en QEMU
./scripts/aezka.sh run
```

### Comandos del Script Aezka

```bash
./scripts/aezka.sh build      # Compilar
./scripts/aezka.sh run        # Ejecutar en QEMU
./scripts/aezka.sh clean      # Limpiar archivos de build
./scripts/aezka.sh rebuild    # Limpiar y recompilar
./scripts/aezka.sh version    # Ver información de versión
./scripts/aezka.sh help       # Mostrar ayuda
```

📖 **Instrucciones detalladas**: Ver [BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)

## 🎨 Información de Versión

### Formato de Versión

**Formato Largo**: `Aezka (Codename | version | fecha_compilación)`
Ejemplo: `Aezka (Taquion | 0.1.0 | 20250103)`

**Formato Corto**: `Aezka (Codename)`
Ejemplo: `Aezka (Taquion)`

### Versión Actual

- **Sistema**: Aezka 0.1.0 "Taquion"
- **Kernel**: Basado en Redox OS
- **Fecha de Compilación**: Automática

## 📚 Documentación

- [Documentación Completa](docs/doc.md)
- [Guía de Contribución](CONTRIBUTING.md)
- [Historial de Cambios](CHANGELOG.md)
- [Créditos y Atribuciones](CREDITS.md)

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Por favor lee [CONTRIBUTING.md](CONTRIBUTING.md)
antes de enviar pull requests.

### Áreas de Desarrollo

- Entorno de escritorio
- Scheduler de tiempo real
- Herramientas en español
- Drivers y soporte de hardware
- Documentación

## 🙏 Créditos

Aezka está construido sobre [Redox OS](https://www.redox-os.org/), creado por
Jeremy Soller y cientos de contribuidores de la comunidad.

Ver [CREDITS.md](CREDITS.md) para información completa sobre atribuciones.

## 📄 Licencia

MIT License - Ver [LICENSE](LICENSE) para más detalles.

```
Copyright (c) 2016 Redox OS Developers
Copyright (c) 2025 Aezka & Mister_F
```

## 🔗 Enlaces

- **Redox OS**: https://www.redox-os.org/
- **Documentación Redox**: https://doc.redox-os.org/
- **Build Instructions Redox**: https://doc.redox-os.org/book/podman-build.html

## 📞 Contacto

- **Desarrollador Principal**: Mister_F
- **Proyecto Base**: Redox OS Team

---

**Nota**: Aezka es un sistema operativo en desarrollo activo. Las características
y la API pueden cambiar entre versiones.

**Basado en Redox OS** - Un sistema operativo tipo Unix escrito en Rust
