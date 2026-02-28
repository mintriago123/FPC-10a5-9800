# Changelog / Registro de Cambios

Todos los cambios notables en este proyecto serán documentados en este archivo.
All notable changes to this project will be documented in this file.

## [2.2.0] - 2026-02-28

### ✨ Agregado / Added
- **Soporte para Fedora Atomic (distribuciones inmutables uBlue) / Support for Fedora Atomic (uBlue immutable distros):**
  - Agregado soporte de instalación mediante `rpm-ostree override replace` para distribuciones basadas en Fedora Atomic
  - Added installation support via `rpm-ostree override replace` for Fedora Atomic-based distributions
  - Debería funcionar en imágenes basadas en **Fedora 42 y 43** / Should work on images based on **Fedora 42 and 43**
  - Probado en Aurora, Aurora DX, Bluefin, Bluefin DX, Bazzite y Bazzite DX / Tested on Aurora, Aurora DX, Bluefin, Bluefin DX, Bazzite and Bazzite DX
  - Comando de instalación: `rpm-ostree override replace libfprint-1.94.10-1.lenovo.fc42.x86_64.rpm`
  - 📖 Nueva guía `docs/INSTALL_FEDORA_ATOMIC.md` (bilingüe ES/EN) / New guide `docs/INSTALL_FEDORA_ATOMIC.md` (bilingual ES/EN)
  - ✅ Confirmado que el RPM también funciona en Fedora mutable vía `dnf install` (probado en Ultramarine 43) / Confirmed RPM also works on mutable Fedora via `dnf install` (tested on Ultramarine 43)
  - Método RPM agregado como método alternativo en las secciones de instalación del README (EN y ES) / RPM method added as alternative method to the README installation sections (EN and ES)
  - Documentación de modificaciones de scripts actualizada en `docs/INSTALL_FEDORA.md` para reflejar que la lógica if/else fue eliminada y los scripts son ahora exclusivos para Fedora / Script modifications documentation updated in `docs/INSTALL_FEDORA.md` to reflect that if/else logic was removed and scripts are now Fedora-only
  - 📖 Nueva guía avanzada `docs/REBUILD_RPM.md` — recompilación del RPM con Toolbox/Distrobox para futuras versiones de Fedora / New advanced guide `docs/REBUILD_RPM.md` — RPM recompilation with Toolbox/Distrobox for future Fedora versions

### 🔄 Cambiado / Changed
- **`docs/INSTALL_FEDORA.md` actualizado / updated:**
  - Sección de modificaciones de scripts corregida: eliminado el bloque `if/else` de detección de OS que ya no existe en los scripts reales; ahora muestran los comandos Fedora directamente / Script modifications section corrected: removed the `if/else` OS detection block that no longer exists in the actual scripts; now shows the Fedora commands directly
  - Sección "Desinstalar / Uninstall" reescrita: eliminado `dnf versionlock delete libfprint` (obsoleto), dividida en dos sub-secciones según el método de instalación usado (scripts vs. RPM) / "Uninstall" section rewritten: removed obsolete `dnf versionlock delete libfprint`, split into two sub-sections depending on the installation method used (scripts vs. RPM)
  - Método RPM agregado a las instrucciones de instalación con chapeau que indica al usuario si puede saltarse la sección / RPM method added to installation instructions with a note indicating users can skip the section if scripts worked
  - Hardware Soportado agregado a la sección española (faltaba) / Hardware Soportado section added to the Spanish section (was missing)

- **README actualizado / Updated README:**
  - Nuevo badge de Fedora Atomic / New Fedora Atomic badge
  - Nuevas secciones de instalación para Fedora Atomic en inglés y español / New Fedora Atomic installation sections in English and Spanish
  - Aurora, Bluefin y Bazzite (normales y DX) agregados a las tablas de distribuciones soportadas / Aurora, Bluefin and Bazzite (standard and DX) added to supported distributions tables
  - Diagramas de estructura del repositorio actualizados para incluir `drivers/Fedora Atomic/` y `docs/INSTALL_FEDORA_ATOMIC.md` / Repository structure diagrams updated to include `drivers/Fedora Atomic/` and `docs/INSTALL_FEDORA_ATOMIC.md`
  - Sección "¿Qué método debo usar?" actualizada / "Which method should I use?" section updated

## [2.1.0] - 2026-02-15

### 🐛 Corregido / Fixed
- **Rutas de Fedora/Nobara corregidas / Fedora/Nobara paths fixed:**
  - Corregida la ruta de instalación: faltaba `r1slm02w/` en `drivers/modified/fedora-nobara/` (README y `docs/INSTALL_FEDORA.md`)
  - Fixed installation path: missing `r1slm02w/` in `drivers/modified/fedora-nobara/` (README and `docs/INSTALL_FEDORA.md`)

- **Paquete faltante en Ubuntu / Missing package on Ubuntu:**
  - Agregado `libpam-fprintd` al comando `apt install` en README y `docs/INSTALL_UBUNTU.md`
  - Added `libpam-fprintd` to `apt install` command in README and `docs/INSTALL_UBUNTU.md`

### 🗑️ Eliminado / Removed
- **Referencias a scripts inexistentes / References to non-existent scripts:**
  - Eliminadas referencias a `drivers/install-ubuntu.sh` y `drivers/install-arch.sh` que no existen en el repositorio
  - Removed references to `drivers/install-ubuntu.sh` and `drivers/install-arch.sh` which don't exist in the repository
  - Eliminadas secciones "Instalación Rápida" / "Quick Installation" del README

### 🔄 Cambiado / Changed
- **Nombre del repositorio en diagramas de estructura / Repository name in structure diagrams:**
  - Corregido de `FPC-10a5-9800-Fedora-Nobara/` a `FPC-10a5-9800/` en ambos diagramas del README
  - Fixed from `FPC-10a5-9800-Fedora-Nobara/` to `FPC-10a5-9800/` in both README diagrams
- **Diagramas de estructura actualizados / Updated structure diagrams:**
  - Ahora reflejan la estructura real del repositorio (incluyen subcarpeta `r1slm02w/`)
  - Now reflect the actual repository structure (include `r1slm02w/` subfolder)
- **"Fedora/Nobara" renombrado a "Fedora y derivadas" / "Fedora/Nobara" renamed to "Fedora & Derivatives":**
  - Actualizado en README, `docs/INSTALL_FEDORA.md`, badges y tablas de distribuciones
  - Updated in README, `docs/INSTALL_FEDORA.md`, badges and distribution tables
  - Agregado Ultramarine como distribución testeada / Added Ultramarine as tested distribution
  - Nobara y Ultramarine ahora aparecen como filas independientes en la tabla de distribuciones / Nobara and Ultramarine now appear as separate rows in the distributions table

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
