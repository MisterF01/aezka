# Contribuyendo a Aezka

**¡Gracias por tu interés en contribuir a Aezka!**

Este documento describe cómo puedes contribuir al proyecto Aezka. Apreciamos todas
las formas de contribución y esperamos **tu aporte!**

## Código de Conducta

Seguimos el [Rust Code Of Conduct](https://www.rust-lang.org/policies/code-of-conduct).

## Licencia

Tus contribuciones a Aezka están bajo la [Licencia MIT](https://en.wikipedia.org/wiki/MIT_License).

**Importante**: Aezka está basado en Redox OS. Al contribuir:
- Respeta el copyright dual: Redox OS Developers y Aezka & Mister_F
- Todo código nuevo debe ser compatible con MIT License
- Mantén las atribuciones originales de Redox en código heredado

## 🎯 Áreas de Contribución

### 1. Componentes Propios de Aezka

Estas son las áreas principales donde puedes contribuir código nuevo:

#### **Escritorio** (`aezka/escritorio/`)
- Gestor de ventanas
- Panel de sistema
- Menú de aplicaciones
- Temas y personalización

#### **Scheduler** (`aezka/scheduler/`)
- Scheduler de tiempo real
- Gestión de procesos
- Optimizaciones de rendimiento

#### **Herramientas** (`aezka/herramientas/`)
- Comandos en español
- Utilidades de sistema
- Herramientas de diagnóstico

### 2. Documentación

- Mejorar documentación existente
- Traducir documentación al español
- Crear tutoriales y guías
- Documentar APIs de componentes nuevos

### 3. Testing

- Escribir tests unitarios
- Tests de integración
- Reportar bugs
- Validar en hardware real

### 4. Drivers y Soporte de Hardware

- Drivers para hardware específico
- Mejoras de compatibilidad
- Documentación de hardware soportado

## 📝 Guías de Estilo

### Código Rust

```rust
// ✅ BUENO: Comentarios claros sobre funcionalidad y autor
/// Gestiona la creación de ventanas en el escritorio Aezka
///
/// Esta función inicializa el sistema de ventanas y configura
/// los parámetros predeterminados del gestor de ventanas.
///
/// # Implementador
/// Mister_F - 2025
/// Basado en arquitectura Redox OS
pub fn inicializar_ventanas() -> Result<(), Error> {
    // Implementación...
}
```

### Comentarios en Código

Todos los componentes nuevos deben incluir:

1. **Descripción de funcionalidad**: ¿Qué hace este código?
2. **Propósito**: ¿Para qué sirve?
3. **Autor**: Quién lo implementó
4. **Fecha**: Cuándo se implementó
5. **Atribuciones**: Si está basado en código de Redox, indicarlo

Ejemplo:

```rust
//! # Scheduler de Tiempo Real Aezka
//!
//! Módulo que implementa el scheduler con capacidades de tiempo real
//! para Aezka OS.
//!
//! ## Funcionalidad
//! - Scheduling por prioridades
//! - Soporte para tareas críticas de tiempo real
//! - Gestión eficiente de recursos
//!
//! ## Implementador
//! Mister_F - 2025
//!
//! ## Basado en
//! Arquitectura de scheduler de Redox OS
//! Copyright (c) 2016 Redox OS Developers
```

### Estructura de Commits

```
tipo(scope): descripción corta

Descripción más detallada si es necesario.

- Cambio específico 1
- Cambio específico 2

Implementador: Nombre
```

Tipos de commits:
- `feat`: Nueva funcionalidad
- `fix`: Corrección de bugs
- `docs`: Documentación
- `style`: Formato, sin cambios de código
- `refactor`: Refactorización
- `test`: Tests
- `chore`: Mantenimiento

Ejemplos:
```
feat(escritorio): agregar gestor de ventanas básico

Implementa el gestor de ventanas para el escritorio Aezka
con soporte para ventanas flotantes y tiling.

- Crear estructura WindowManager
- Implementar eventos de ventana
- Agregar soporte para múltiples escritorios

Implementador: Mister_F
```

## 🔄 Proceso de Contribución

1. **Fork y Clone**
   ```bash
   git clone https://github.com/tu-usuario/Aezka.git
   cd Aezka
   ```

2. **Crear Rama**
   ```bash
   git checkout -b feat/mi-nueva-funcionalidad
   ```

3. **Desarrollar**
   - Escribe código siguiendo las guías de estilo
   - Incluye comentarios descriptivos
   - Agrega tests si es posible

4. **Commit**
   ```bash
   git add .
   git commit -m "feat(scope): descripción"
   ```

5. **Push y Pull Request**
   ```bash
   git push origin feat/mi-nueva-funcionalidad
   ```
   Luego crea un Pull Request en GitHub

## ✅ Checklist antes de PR

- [ ] El código compila sin errores
- [ ] Se siguieron las guías de estilo
- [ ] Se agregaron comentarios descriptivos
- [ ] Se indicó el implementador en comentarios
- [ ] Se respetaron las atribuciones a Redox OS
- [ ] La documentación está actualizada
- [ ] Se probó la funcionalidad

## 🤝 Contribuir a Redox OS

Si encuentras bugs o quieres mejorar componentes base de Redox OS,
contribuye directamente a Redox:

- **Repositorio**: https://gitlab.redox-os.org/redox-os/redox
- **Guía**: https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md

## 📞 Contacto

Para dudas sobre contribuciones a Aezka:
- Crear un Issue en GitHub
- Contactar a Mister_F

Para Redox OS:
- Matrix: https://matrix.to/#/#redox-join:matrix.org
- Discord: https://discord.gg/JfggvrHGDY

## 📚 Recursos

- [Documentación Aezka](docs/doc.md)
- [Redox Book](https://doc.redox-os.org/book/)
- [Rust Book](https://doc.rust-lang.org/book/)
- [Redox GitLab](https://gitlab.redox-os.org/redox-os)

---

**¡Gracias por contribuir a Aezka!** 🎉
