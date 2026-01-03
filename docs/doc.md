# Documentación de Aezka OS

```
    ___                __
   /   |  ___  ____   / /______ _
  / /| | / _ \|_  /  / //_/ __ `/
 / ___ |/  __/ / /__/ ,< / /_/ /
/_/  |_|\___/ /___/_/|_|\__,_/

Sistema Operativo Modular | Seguro | Accesible
```

---

## 📚 Tabla de Contenidos

1. [Introducción](#introducción)
2. [Arquitectura](#arquitectura)
3. [Instalación y Compilación](#instalación-y-compilación)
4. [Sistema de Versionado](#sistema-de-versionado)
5. [Desarrollo](#desarrollo)
6. [Componentes](#componentes)
7. [Configuración](#configuración)
8. [FAQ](#faq)
9. [Referencias](#referencias)

---

## Introducción

### ¿Qué es Aezka OS?

Aezka es un sistema operativo modular construido sobre **Redox OS**, un sistema
operativo tipo Unix escrito completamente en Rust. Aezka mantiene la solidez y
seguridad de Redox mientras añade características específicas orientadas a:

- **Modularidad**: Arquitectura de componentes independientes
- **Seguridad**: Múltiples capas de protección
- **Accesibilidad**: Interfaz en español y comandos localizados
- **Tiempo Real**: Capacidades de scheduling de tiempo real
- **Profesionalismo**: Calidad comercial con código abierto

### Filosofía

Aezka sigue estos principios:

1. **Respeto a los orígenes**: Mantener atribución clara a Redox OS
2. **Calidad sobre cantidad**: Código bien documentado y testeado
3. **Accesibilidad primero**: Interfaz intuitiva en español
4. **Seguridad por diseño**: Rust y arquitectura de microkernel
5. **Comunidad abierta**: Desarrollo transparente y colaborativo

---

## Arquitectura

### Visión General

Aezka hereda la arquitectura de **microkernel** de Redox OS:

```
┌─────────────────────────────────────────┐
│          Aplicaciones de Usuario         │
│  (COSMIC Apps, Herramientas Aezka, etc) │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│         Servicios de Usuario             │
│  (Escritorio, Drivers, Scheduler, etc)   │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│         Microkernel (Redox)              │
│   (IPC, Memory, Scheduling Básico)       │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│             Hardware                     │
└─────────────────────────────────────────┘
```

### Componentes Base (Heredados de Redox)

- **Kernel**: Microkernel mínimo en Rust
- **RedoxFS**: Sistema de archivos nativo
- **relibc**: Biblioteca C POSIX en Rust
- **Drivers**: Controladores de hardware en espacio de usuario
- **Orbital**: Servidor de display

### Componentes Propios de Aezka

#### 1. Escritorio (`aezka/escritorio/`)

Entorno de escritorio personalizado con:
- Gestor de ventanas moderno
- Panel de sistema
- Menú de aplicaciones en español
- Temas visuales personalizados

**Estado**: En desarrollo

#### 2. Scheduler (`aezka/scheduler/`)

Scheduler mejorado con capacidades de tiempo real:
- Prioridades de proceso
- Garantías de latencia para tareas críticas
- Métricas de rendimiento

**Estado**: Planeado

#### 3. Herramientas (`aezka/herramientas/`)

Utilidades de sistema en español:
- Comandos localizados
- Herramientas de diagnóstico
- Gestión de configuración

**Estado**: Planeado

---

## Instalación y Compilación

### Requisitos del Sistema

#### Hardware Mínimo
- CPU: x86_64 (64-bit)
- RAM: 2 GB (4 GB recomendado)
- Disco: 10 GB libres
- Virtualización: VT-x/AMD-V (para QEMU)

#### Software (Fedora)

```bash
# Herramientas de desarrollo
sudo dnf groupinstall -y "Development Tools" \
    "C Development Tools and Libraries"

# Dependencias de Redox/Aezka
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

### Compilación

#### Método 1: Script Aezka (Recomendado)

```bash
# Ver ayuda
./scripts/aezka.sh help

# Compilar
./scripts/aezka.sh build

# Ejecutar en QEMU
./scripts/aezka.sh run

# Limpiar y recompilar
./scripts/aezka.sh rebuild
```

#### Método 2: Make Directo

```bash
# Configuración inicial (primera vez)
./podman_bootstrap.sh

# Compilar
make all CONFIG_NAME=aezka

# Ejecutar en QEMU
make qemu CONFIG_NAME=aezka

# Limpiar
make clean CONFIG_NAME=aezka
```

---

## Sistema de Versionado

### Formato de Versión

Aezka usa **Semantic Versioning** (Major.Minor.Patch) con información adicional:

#### Formato Largo
```
Aezka (Codename | Major.Minor.Patch | FechaCompilación)
```

Ejemplo:
```
Aezka (Taquion | 0.1.0 | 20250103)
```

#### Formato Corto
```
Aezka (Codename)
```

Ejemplo:
```
Aezka (Taquion)
```

### Componentes de Versión

- **Major**: Cambios incompatibles de API
- **Minor**: Nueva funcionalidad compatible
- **Patch**: Correcciones de bugs
- **Codename**: Nombre único por versión major
- **FechaCompilación**: YYYYMMDD automático

### Versiones del Kernel

El kernel también tiene su propia versión basada en Redox:

```
Aezka Kernel (BasedOnRedoxVersion | LastRedoxUpdate)
```

---

## Desarrollo

### Estructura del Proyecto

```
Aezka/
├── aezka/              # Componentes propios
│   ├── escritorio/     # Entorno de escritorio
│   ├── scheduler/      # Scheduler de tiempo real
│   └── herramientas/   # Utilidades
├── config/
│   └── x86_64/
│       └── aezka.toml  # Configuración Aezka
├── docs/               # Documentación
├── scripts/
│   └── aezka.sh        # Script de build
├── build/              # Archivos compilados (generado)
├── recipes/            # Recetas de paquetes (Redox)
├── mk/                 # Makefiles (Redox)
├── CHANGELOG.md
├── CONTRIBUTING_AEZKA.md
├── CREDITS.md
├── LICENSE
└── README.md
```

### Flujo de Trabajo

1. **Crear rama de desarrollo**
   ```bash
   git checkout -b feat/nueva-funcionalidad
   ```

2. **Desarrollar**
   - Escribir código en `aezka/` para componentes nuevos
   - Seguir guías de estilo de Rust
   - Incluir comentarios descriptivos

3. **Documentar**
   - Actualizar documentación relevante
   - Agregar comentarios sobre implementador
   - Documentar cambios en CHANGELOG.md

4. **Compilar y probar**
   ```bash
   ./scripts/aezka.sh rebuild
   ./scripts/aezka.sh run
   ```

5. **Commit**
   ```bash
   git add .
   git commit -m "feat(scope): descripción"
   ```

6. **Pull Request**
   - Revisar checklist en CONTRIBUTING_AEZKA.md
   - Crear PR con descripción clara

### Guías de Código

#### Comentarios Obligatorios

```rust
//! # Módulo Example
//!
//! Descripción del módulo y su funcionalidad.
//!
//! ## Implementador
//! Nombre - Año
//!
//! ## Basado en
//! [Si aplica] Componente de Redox OS
//! Copyright (c) 2016 Redox OS Developers

/// Función que hace algo específico
///
/// # Parámetros
/// - `param`: Descripción del parámetro
///
/// # Retorna
/// Descripción del retorno
///
/// # Implementador
/// Nombre - Año
pub fn funcion_ejemplo(param: Type) -> Result<(), Error> {
    // Implementación
}
```

---

## Componentes

### COSMIC Desktop Apps

Aezka usa las aplicaciones COSMIC:

- **cosmic-edit**: Editor de texto
- **cosmic-files**: Gestor de archivos
- **cosmic-term**: Terminal

### Orbital

Servidor de display y gestor de ventanas de Redox.

### NetSurf

Navegador web ligero incluido por defecto.

---

## Configuración

### Archivo de Configuración

`config/x86_64/aezka.toml` controla qué se incluye en el build:

```toml
[general]
filesystem_size = 1024  # Tamaño en MiB

[packages]
cosmic-edit = {}
cosmic-files = {}
# ... más paquetes
```

### Agregar Componentes

Para incluir un nuevo componente de Aezka:

1. Desarrollar en `aezka/componente/`
2. Crear receta en `recipes/aezka-componente/`
3. Agregar a `config/x86_64/aezka.toml`:
   ```toml
   [packages]
   aezka-componente = {}
   ```

---

## FAQ

### ¿Aezka es un fork de Redox?

Sí, Aezka es un derivado de Redox OS que mantiene total respeto y atribución
al proyecto original. Toda la base del sistema es Redox.

### ¿Puedo contribuir a Aezka?

¡Absolutamente! Lee [CONTRIBUTING_AEZKA.md](../CONTRIBUTING_AEZKA.md).

### ¿Qué diferencia hay con Redox?

Aezka añade:
- Interfaz en español
- Scheduler de tiempo real
- Componentes de escritorio personalizados
- Enfoque en accesibilidad

### ¿Es estable para uso diario?

Actualmente NO. Aezka está en desarrollo activo (v0.1.0). No se recomienda
para producción.

### ¿Puedo ejecutarlo en hardware real?

Técnicamente sí, pero se recomienda usar QEMU para desarrollo y pruebas.

### ¿Qué licencia tiene?

MIT License, igual que Redox OS. Ver [LICENSE](../LICENSE).

---

## Referencias

### Documentación de Redox OS

- [Redox Book](https://doc.redox-os.org/book/)
- [Build System](https://doc.redox-os.org/book/build-system-reference.html)
- [GitLab Redox](https://gitlab.redox-os.org/redox-os)

### Rust

- [The Rust Book](https://doc.rust-lang.org/book/)
- [Rust by Example](https://doc.rust-lang.org/rust-by-example/)
- [Rust API Docs](https://doc.rust-lang.org/std/)

### Aezka

- [README](../README.md)
- [CHANGELOG](../CHANGELOG.md)
- [CREDITS](../CREDITS.md)
- [CONTRIBUTING](../CONTRIBUTING_AEZKA.md)

---

## Contacto y Soporte

- **Desarrollador Principal**: Mister_F
- **Issues**: GitHub Issues
- **Proyecto Base**: [Redox OS](https://www.redox-os.org/)

---

**Última actualización**: 2025-01-03
**Versión del documento**: 1.0
**Para Aezka**: v0.1.0 "Taquion"
