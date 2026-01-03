# Changelog

Todos los cambios importantes de Aezka OS serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Formato de Versión

**Largo**: `Aezka (Codename | Mayor.Menor.Patch | FechaCompilación)`
**Corto**: `Aezka (Codename)`

Ejemplo: `Aezka (Taquion | 0.1.0 | 20250103)`

## [0.1.0] - 2025-01-03 "Taquion"

### 🎉 Versión Inicial

Primera versión de Aezka OS basada en Redox OS.

### ✨ Añadido

#### Estructura Base
- Fork inicial de Redox OS desde GitLab
- Estructura de directorios personalizada para componentes Aezka
- Sistema de licencias dual (Redox OS + Aezka)

#### Documentación
- README.md con información completa de Aezka
- CREDITS.md con atribuciones a Redox OS
- CONTRIBUTING_AEZKA.md con guías de contribución
- LICENSE actualizado con copyright dual
- Este CHANGELOG.md

#### Directorios Propios
- `aezka/`: Directorio raíz para componentes personalizados
- `aezka/escritorio/`: Espacio para entorno de escritorio futuro
- `aezka/scheduler/`: Espacio para scheduler de tiempo real
- `aezka/herramientas/`: Espacio para utilidades propias
- `scripts/`: Scripts de desarrollo
- `docs/`: Documentación adicional

#### Configuración
- Sistema de versionado automático configurado
- Configuración base para compilación

### 🏗️ Infraestructura

- Sistema de compilación heredado de Redox OS
- Soporte para Podman (containerización)
- Scripts de bootstrap incluidos
- Configuración para QEMU

### 📦 Componentes Base (Heredados de Redox OS)

Aezka incluye todos los componentes de Redox OS:
- Kernel microkernel en Rust
- RedoxFS (sistema de archivos)
- relibc (biblioteca C en Rust)
- Drivers de sistema
- Herramientas base

### 🎯 Objetivos Futuros

Para versiones futuras (ver roadmap):
- Implementar entorno de escritorio propio
- Desarrollar scheduler de tiempo real
- Crear herramientas con comandos en español
- Mejorar documentación en español
- Expandir soporte de hardware

### 👥 Implementadores

- **Mister_F**: Creador y desarrollador principal de Aezka

### 🙏 Agradecimientos

- **Redox OS Team**: Por crear la base sólida sobre la que se construye Aezka
- **Jeremy Soller**: Creador de Redox OS
- **Comunidad Rust**: Por el lenguaje y herramientas

---

## Formato de Entradas Futuras

### [X.Y.Z] - YYYY-MM-DD "Codename"

#### ✨ Añadido
- Nuevas características

#### 🔄 Cambiado
- Cambios en funcionalidad existente

#### 🗑️ Deprecado
- Características que serán removidas

#### ❌ Removido
- Características removidas

#### 🐛 Corregido
- Correcciones de bugs

#### 🔒 Seguridad
- Correcciones de vulnerabilidades

---

## Enlaces

- [Repositorio Aezka](https://github.com/MisterF01/Aezka)
- [Redox OS](https://www.redox-os.org/)
- [Documentación](docs/doc.md)

## Notas

- **Fechas de Compilación**: Se generan automáticamente en formato YYYYMMDD
- **Versionado**: Mayor.Menor.Patch según Semantic Versioning
- **Codenames**: Cada versión mayor tiene un codename único
