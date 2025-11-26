# Changelog / Registro de Cambios

Todos los cambios notables en este proyecto serán documentados en este archivo.
All notable changes to this project will be documented in this file.

## [2.0.0] - 2025-11-26

### ✨ Agregado / Added
- **Soporte multi-distribución / Multi-distribution support:**
  - ✅ Ubuntu con PPA oficial / Ubuntu with official PPA
  - ✅ Arch Linux con paquete AUR / Arch Linux with AUR package
  - ✅ Fedora/Nobara (existente, mejorado) / Fedora/Nobara (existing, improved)

- **Documentación completa / Complete documentation:**
  - 📖 `docs/INSTALL_UBUNTU.md` - Guía detallada para Ubuntu
  - 📖 `docs/INSTALL_ARCH.md` - Guía detallada para Arch Linux
  - 📖 `docs/INSTALL_FEDORA.md` - Guía detallada para Fedora/Nobara
  - 🤝 `CONTRIBUTING.md` - Guía de contribución

- **Scripts de instalación automática / Automatic installation scripts:**
  - ⚡ `install-ubuntu.sh` - Instalación interactiva para Ubuntu
  - ⚡ `install-arch.sh` - Instalación automática para Arch Linux
  - ⚡ `install-fedora.sh` - Instalación automática para Fedora/Nobara

- **Mejoras en la estructura / Structure improvements:**
  - 📁 Carpeta `docs/` para documentación organizada
  - 📄 `.gitignore` apropiado para el proyecto
  - 📋 Tabla comparativa de métodos de instalación

### 🔄 Cambiado / Changed
- **README principal completamente rediseñado / Main README completely redesigned:**
  - Formato bilingüe mejorado (ES/EN) / Improved bilingual format (ES/EN)
  - Navegación más clara / Clearer navigation
  - Secciones organizadas por distribución / Sections organized by distribution
  - Tabla de distribuciones soportadas / Supported distributions table

### 📝 Documentado / Documented
- Método PPA para Ubuntu (recomendado) / PPA method for Ubuntu (recommended)
- Método AUR para Arch Linux / AUR method for Arch Linux
- Pasos de solución de problemas para cada distro / Troubleshooting steps for each distro
- Referencias a fuentes oficiales / References to official sources

### 🎯 Información Técnica / Technical Information
- **Ubuntu:** Usa `libfprint-2-tod1-fpc` desde PPA oficial
- **Arch:** Usa `libfprint-fpcmoh-git` desde AUR
- **Fedora/Nobara:** Usa drivers modificados de Lenovo con detección automática

## [1.0.0] - 2024-10

### ✨ Inicial / Initial
- Soporte básico para Fedora/Nobara / Basic support for Fedora/Nobara
- Scripts modificados de instalación / Modified installation scripts
- README en inglés y español / README in English and Spanish
- Créditos a Lukáš Maňák por el tutorial original / Credits to Lukáš Maňák for original tutorial

---

## Formato / Format

Este changelog sigue las convenciones de [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/).

This changelog follows the conventions of [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

### Tipos de cambios / Types of changes:
- `Agregado` / `Added` - Nueva funcionalidad
- `Cambiado` / `Changed` - Cambios en funcionalidad existente
- `Obsoleto` / `Deprecated` - Funcionalidad que será eliminada
- `Eliminado` / `Removed` - Funcionalidad eliminada
- `Corregido` / `Fixed` - Corrección de bugs
- `Seguridad` / `Security` - Vulnerabilidades
