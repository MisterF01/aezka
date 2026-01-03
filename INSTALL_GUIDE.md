# Guía de Instalación de Aezka OS

## 📋 Resumen del Proyecto

**Aezka OS v0.1.0 "Taquion"** ha sido creado exitosamente basado en Redox OS.

```
    ___                __
   /   |  ___  ____   / /______ _
  / /| | / _ \|_  /  / //_/ __ `/
 / ___ |/  __/ / /__/ ,< / /_/ /
/_/  |_|\___/ /___/_/|_|\__,_/

Sistema Operativo Modular | Seguro | Accesible
```

---

## ✅ Tareas Completadas

✓ Estructura base del proyecto creada
✓ Sistema de licencias con copyright dual configurado
✓ Documentación completa generada
✓ Sistema de versionado automático implementado
✓ Configuración de build personalizada (aezka.toml)
✓ Scripts de desarrollo creados
✓ Commit inicial realizado
✓ Tag v0.1.0 creado
✓ Remote configurado para GitHub

---

## 🚀 Próximos Pasos

### 1. Instalar Dependencias en Fedora

En tu sistema Fedora local, ejecuta:

```bash
# Herramientas de desarrollo
sudo dnf groupinstall -y "Development Tools" "C Development Tools and Libraries"

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

### 2. Clonar/Sincronizar el Repositorio

Si estás trabajando localmente, asegúrate de sincronizar con el repositorio:

```bash
cd /ruta/a/tu/proyecto/Aezka
git pull origin claude/create-aezka-os-vlUXd
```

### 3. Push al Repositorio Remoto

Desde tu sistema local con credenciales configuradas:

```bash
# Verificar remotes
git remote -v

# Debería mostrar:
# origin    https://github.com/MisterF01/Aezka.git (fetch)
# origin    https://github.com/MisterF01/Aezka.git (push)
# redox-upstream    https://gitlab.redox-os.org/redox-os/redox.git (fetch)
# redox-upstream    https://gitlab.redox-os.org/redox-os/redox.git (push)

# Push a la rama de desarrollo
git push -u origin claude/create-aezka-os-vlUXd

# Push del tag v0.1.0
git push origin v0.1.0
```

### 4. Compilar Aezka

#### Opción A: Usando el Script Aezka (Recomendado)

```bash
# Ver ayuda
./scripts/aezka.sh help

# Compilar
./scripts/aezka.sh build

# Ejecutar en QEMU
./scripts/aezka.sh run
```

#### Opción B: Usando Make Directamente

```bash
# Setup inicial (solo primera vez)
./podman_bootstrap.sh

# Compilar
make all CONFIG_NAME=aezka

# Ejecutar en QEMU
make qemu CONFIG_NAME=aezka
```

---

## 📁 Estructura del Proyecto

```
Aezka/
├── aezka/                      # Componentes propios de Aezka
│   ├── escritorio/             # Entorno de escritorio (futuro)
│   ├── scheduler/              # Scheduler de tiempo real (futuro)
│   ├── herramientas/           # Utilidades en español (futuro)
│   ├── version.rs              # Sistema de versionado
│   └── VERSION                 # Configuración de versión
│
├── config/
│   └── x86_64/
│       └── aezka.toml          # Configuración de build Aezka
│
├── scripts/
│   └── aezka.sh                # Script de compilación y gestión
│
├── docs/
│   └── doc.md                  # Documentación completa
│
├── CHANGELOG.md                # Historial de cambios
├── CONTRIBUTING_AEZKA.md       # Guía de contribución
├── CREDITS.md                  # Atribuciones a Redox OS
├── LICENSE                     # MIT con copyright dual
├── README.md                   # Introducción del proyecto
└── INSTALL_GUIDE.md           # Esta guía
```

---

## 📚 Documentación

- **README.md**: Introducción y características de Aezka
- **docs/doc.md**: Documentación técnica completa
- **CONTRIBUTING_AEZKA.md**: Cómo contribuir al proyecto
- **CREDITS.md**: Atribuciones y agradecimientos
- **CHANGELOG.md**: Historial de versiones

---

## 🔧 Comandos Útiles

### Gestión del Proyecto

```bash
# Ver información de versión
./scripts/aezka.sh version

# Limpiar archivos de compilación
./scripts/aezka.sh clean

# Recompilar desde cero
./scripts/aezka.sh rebuild
```

### Git

```bash
# Ver estado del repositorio
git status

# Ver commits recientes
git log --oneline

# Ver tags
git tag

# Ver información de tag v0.1.0
git show v0.1.0
```

### Actualizar desde Redox OS Upstream

Si necesitas sincronizar con cambios de Redox OS:

```bash
# Fetch de Redox upstream
git fetch redox-upstream

# Ver cambios disponibles
git log HEAD..redox-upstream/master --oneline

# Merge de cambios (con precaución)
git merge redox-upstream/master
```

---

## 🎯 Roadmap Futuro

### Versión 0.2.0 (Planeada)
- [ ] Implementar estructura básica del escritorio
- [ ] Crear primeras herramientas en español
- [ ] Mejorar sistema de versionado con integración automática

### Versión 0.3.0 (Planeada)
- [ ] Scheduler de tiempo real básico
- [ ] Gestor de ventanas personalizado
- [ ] Herramientas de diagnóstico

### Versión 1.0.0 (Meta)
- [ ] Sistema completo y funcional
- [ ] Documentación exhaustiva
- [ ] Suite completa de herramientas
- [ ] Testing en hardware real

---

## ❓ Solución de Problemas

### Error: "podman not found"

```bash
sudo dnf install -y podman
```

### Error: "rustc not found"

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup default stable
```

### Error de compilación: "target not found"

```bash
rustup target add x86_64-unknown-redox
rustup component add rust-src
```

### QEMU no inicia

```bash
sudo dnf install -y qemu qemu-system-x86
```

---

## 📞 Soporte

- **Issues**: GitHub Issues del proyecto
- **Documentación Redox**: https://doc.redox-os.org/book/
- **Redox Chat**: https://matrix.to/#/#redox-join:matrix.org

---

## 📄 Licencia

MIT License

```
Copyright (c) 2025 Aezka & Mister_F
Copyright (c) 2016 Redox OS Developers
```

Ver [LICENSE](LICENSE) para más detalles.

---

## 🎉 ¡Felicitaciones!

Has creado exitosamente la base de Aezka OS. El proyecto está listo para:

1. ✅ Compilar y ejecutar
2. ✅ Desarrollo de componentes propios
3. ✅ Contribuciones de la comunidad
4. ✅ Evolución continua

**¡Bienvenido a Aezka OS!**

```
Versión: Aezka (Taquion | 0.1.0 | 20250103)
Implementador: Mister_F
Basado en: Redox OS
```
