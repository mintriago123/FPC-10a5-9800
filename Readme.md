# FPC Fingerprint Reader Driver Installation for Linux

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Fedora](https://img.shields.io/badge/Fedora-✓-51A2DA.svg?logo=fedora)](docs/INSTALL_FEDORA.md)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-✓-E95420.svg?logo=ubuntu)](docs/INSTALL_UBUNTU.md)
[![Arch Linux](https://img.shields.io/badge/Arch%20Linux-✓-1793D1.svg?logo=arch-linux)](docs/INSTALL_ARCH.md)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](CONTRIBUTING.md)

> 🌐 **Languages:** [English](#english) | [Español](#español)

---

## English

### 🔍 Description

This repository provides drivers and instructions for installing the FPC 10a5:9800 fingerprint reader on multiple Linux distributions, including Fedora, Nobara, Ubuntu, and Arch Linux.

### 🖥️ Supported Hardware

- **Device ID:** FPC 10a5:9800
- **Tested Models:** 
  - Lenovo ThinkPad E14 Gen 4
  - Lenovo ThinkPad E15 Gen 4
  - Lenovo ThinkBook 13s Gen 4 ARB
- **Other Compatible Models:** Other Lenovo laptops with FPC 10a5:9800 sensor

### 📋 Verify Your Device

Run this command to check if you have the FPC 10a5:9800 sensor:

```bash
lsusb | grep 10a5:9800
```

If you see "10a5:9800" in the output, this repository is for you!

### 📚 Installation Guides

Select your distribution:

#### 🎩 Fedora / Nobara
**[📖 Complete Guide](docs/INSTALL_FEDORA.md)**

Method using modified Lenovo drivers with automatic system detection.

**Manual installation:**
```bash
cd drivers/modified/fedora-nobara/r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc
chmod +x install.sh && sudo ./install.sh

cd ../../FPC_driver_linux_libfprint/install_libfprint
chmod +x install.sh && sudo ./install.sh
```

#### 🟠 Ubuntu
**[📖 Complete Guide](docs/INSTALL_UBUNTU.md)**

Use the official libfprint-tod1-group PPA (only working method).

```bash
sudo add-apt-repository ppa:libfprint-tod1-group/ppa
sudo apt update
sudo apt install libfprint-2-tod1-fpc fprintd
```

⚠️ **Note:** Manual Lenovo drivers don't work on Ubuntu. Use only the PPA.

#### 🟪 Deepin 25
**[📖 Complete Guide](docs/INSTALL_DEEPIN.md)**

Download and use original Lenovo scripts with immutable system.

⚠️ **Important:** Use the original driver (drivers/original/r1slm02w.zip or download from Lenovo). Do NOT use drivers/modified/fedora-nobara/ which contains Fedora-modified scripts.

```bash
# 1. Download from Lenovo and unzip
# Download from: https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477
# Or use the included drivers/original/r1slm02w.zip in this repository
unzip drivers/original/r1slm02w.zip

# 2. Disable immutability
sudo deepin-immutable-writable enable

# 3. REBOOT THE SYSTEM
sudo reboot

# 4. After reboot, install drivers
cd r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc
chmod +x install.sh && sudo ./install.sh

cd ../../FPC_driver_linux_libfprint/install_libfprint
chmod +x install.sh && sudo ./install.sh

# 5. Reboot again
sudo reboot
```

#### 🔵 Arch Linux
**[📖 Complete Guide](docs/INSTALL_ARCH.md)**

Install from AUR:

```bash
yay -S libfprint-fpcmoh-git fprintd
# or
paru -S libfprint-fpcmoh-git fprintd
```

### 📁 Repository Structure

```
FPC-10a5-9800/
├── docs/                          # 📚 Detailed documentation
│   ├── INSTALL_FEDORA.md         # Guide for Fedora/Nobara
│   ├── INSTALL_UBUNTU.md         # Guide for Ubuntu
│   ├── INSTALL_DEEPIN.md         # Guide for Deepin 25
│   └── INSTALL_ARCH.md           # Guide for Arch Linux
├── drivers/                       # 🔧 Drivers and binary files
│   ├── original/                 # Unmodified drivers
│   │   └── r1slm02w.zip          # Original Lenovo driver (for Deepin/manual Ubuntu)
│   └── modified/                 # Modified drivers
│       └── fedora-nobara/        # Scripts adapted for Fedora/Nobara
│           └── r1slm02w/
│               ├── FPC_driver_linux_27.26.23.39/
│               └── FPC_driver_linux_libfprint/
├── CHANGELOG.md                   # Change log
├── CONTRIBUTING.md                # Contributing guide
├── LICENSE                        # MIT License
└── README.md                      # This file
```

### ⚙️ Quick Setup

After installation:

**GNOME:**
Settings → Users → Fingerprint Login

**KDE/Others:**
```bash
fprintd-enroll
```

### 🛠️ Troubleshooting

**Device not showing:**
- Check BIOS/UEFI - Enable fingerprint reader
- Disable Secure Boot

**Check service:**
```bash
systemctl status fprintd
journalctl -xe | grep fprint
```

**Restart service:**
```bash
sudo systemctl restart fprintd
```

### 🤝 Contributing

Found a solution to a problem? Have an optimization tip? Contributions are welcome!

1. Fork this repository
2. Create a branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -m 'Add new optimization'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Open a Pull Request

Read our [contributing guide](CONTRIBUTING.md) for more details.

### 📄 License

This repository is licensed under the [MIT License](LICENSE).

**Important Note:**
- **Original Lenovo drivers:** Property of Lenovo (see license files in r1slm02w/)
- **Modified scripts and documentation:** MIT License

### 🌐 Supported Distributions

| Distribution | Method | Status | Guide |
|--------------|--------|--------|------|
| **Fedora/Nobara** | Modified Lenovo drivers | ✅ Tested | [View guide](docs/INSTALL_FEDORA.md) |
| **Ubuntu** | Official PPA | ✅ Official | [View guide](docs/INSTALL_UBUNTU.md) |
| **Deepin 25** | Lenovo scripts (immutable system) | ✅ Tested | [View guide](docs/INSTALL_DEEPIN.md) |
| **Arch Linux** | AUR (libfprint-fpcmoh-git) | ✅ Tested | [View guide](docs/INSTALL_ARCH.md) |
| **Manjaro/EndeavourOS** | AUR (libfprint-fpcmoh-git) | ✅ Compatible | [View guide](docs/INSTALL_ARCH.md) |

### 💡 Which method should I use?

**Ubuntu:**
- **Only working method:** Official PPA → Automatic updates + integrated support
- ⚠️ Manual drivers do **NOT** work on Ubuntu

**Deepin 25:**
- **Only working method:** Original Lenovo scripts (NOT modified ones) with immutability disabled
- ⚠️ Download the original Lenovo driver
- ⚠️ Disable immutability before installing

**Arch Linux:**
- **Only method:** AUR package → Better system integration

**Fedora/Nobara:**
- **Only method:** Modified Lenovo drivers (included here)

### 🔗 Useful Links

**Fedora/Nobara:**
- [Original tutorial by Lukáš Maňák](https://lukan.cz/2024/10/fedora-40-fpc-fingerprint-lenovo-thinkpad/)
- [Original Lenovo driver](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477)

**Ubuntu:**
- [Official libfprint-tod1-group PPA](https://launchpad.net/~libfprint-tod1-group/+archive/ubuntu/ppa/)
- [libfprint-2-tod1 information](https://gitlab.freedesktop.org/libfprint/libfprint)

**Arch Linux:**
- [AUR package libfprint-fpcmoh-git](https://aur.archlinux.org/packages/libfprint-fpcmoh-git)
- [Arch Linux wiki on fprint](https://wiki.archlinux.org/title/Fprint)

### 👥 Credits

**Fedora/Nobara Scripts:**
- **Tutorial and Modifications:** [Lukáš Maňák](https://lukan.cz/2024/10/fedora-40-fpc-fingerprint-lenovo-thinkpad/)
- **Original Driver:** Lenovo (Ubuntu 20.04/22.04)

**Ubuntu PPA:**
- **Maintainer:** libfprint-tod1-group
- **Base Project:** freedesktop.org libfprint

**Arch Linux:**
- **AUR Package:** Arch Linux community
- **Base Project:** libfprint with FPC MOH modifications

**Repository:**
- **Organization and additional documentation:** Contributors of this repository
- **Ubuntu and Arch guides:** Added to facilitate multi-distro installation

---

## Español

### 🔍 Descripción

Este repositorio proporciona drivers e instrucciones para instalar el lector de huellas dactilares FPC 10a5:9800 en múltiples distribuciones de Linux, incluyendo Fedora, Nobara, Ubuntu y Arch Linux.

### 🖥️ Hardware Soportado

- **Device ID:** FPC 10a5:9800
- **Modelos Probados:** 
  - Lenovo ThinkPad E14 Gen 4
  - Lenovo ThinkPad E15 Gen 4
  - Lenovo ThinkBook 13s Gen 4 ARB
- **Otros Modelos Compatibles:** Otras laptops Lenovo con sensor FPC 10a5:9800

### 📋 Verifica tu Dispositivo

Ejecuta este comando para verificar si tienes el sensor FPC 10a5:9800:

```bash
lsusb | grep 10a5:9800
```

Si ves "10a5:9800" en la salida, ¡este repositorio es para ti!

### 📚 Guías de Instalación

Selecciona tu distribución:

#### 🎩 Fedora / Nobara
**[📖 Guía Completa](docs/INSTALL_FEDORA.md)**

Método usando drivers modificados de Lenovo con detección automática del sistema.

**Instalación manual:**
```bash
cd drivers/modified/fedora-nobara/r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc
chmod +x install.sh && sudo ./install.sh

cd ../../FPC_driver_linux_libfprint/install_libfprint
chmod +x install.sh && sudo ./install.sh
```

#### 🟠 Ubuntu
**[📖 Guía Completa](docs/INSTALL_UBUNTU.md)**

Usa el PPA oficial de libfprint-tod1-group (único método funcional).

```bash
sudo add-apt-repository ppa:libfprint-tod1-group/ppa
sudo apt update
sudo apt install libfprint-2-tod1-fpc fprintd
```

⚠️ **Nota:** Los drivers manuales de Lenovo no funcionan en Ubuntu. Usa solo el PPA.

#### 🟪 Deepin 25
**[📖 Guía Completa](docs/INSTALL_DEEPIN.md)**

Descarga y usa scripts originales de Lenovo con sistema inmutable.

⚠️ **Importante:** Usa el driver original (drivers/original/r1slm02w.zip o descárgalo de Lenovo). NO uses drivers/modified/fedora-nobara/ que contiene scripts modificados para Fedora.

```bash
# 1. Descargar de Lenovo y descomprimir
# Descarga desde: https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477
# O usa el drivers/original/r1slm02w.zip incluido en este repositorio
unzip drivers/original/r1slm02w.zip

# 2. Desactivar inmutabilidad
sudo deepin-immutable-writable enable

# 3. REINICIAR EL SISTEMA
sudo reboot

# 4. Después del reinicio, instalar drivers
cd r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc
chmod +x install.sh && sudo ./install.sh

cd ../../FPC_driver_linux_libfprint/install_libfprint
chmod +x install.sh && sudo ./install.sh

# 5. Reiniciar nuevamente
sudo reboot
```

#### 🔵 Arch Linux
**[📖 Guía Completa](docs/INSTALL_ARCH.md)**

Instalar desde AUR:

```bash
yay -S libfprint-fpcmoh-git fprintd
# o
paru -S libfprint-fpcmoh-git fprintd
```

### 📁 Estructura del Repositorio

```
FPC-10a5-9800/
├── docs/                          # 📚 Documentación detallada
│   ├── INSTALL_FEDORA.md         # Guía para Fedora/Nobara
│   ├── INSTALL_UBUNTU.md         # Guía para Ubuntu
│   ├── INSTALL_DEEPIN.md         # Guía para Deepin 25
│   └── INSTALL_ARCH.md           # Guía para Arch Linux
├── drivers/                       # 🔧 Drivers y archivos binarios
│   ├── original/                 # Drivers sin modificar
│   │   └── r1slm02w.zip          # Driver original de Lenovo (para Deepin/Ubuntu manual)
│   └── modified/                 # Drivers modificados
│       └── fedora-nobara/        # Scripts adaptados para Fedora/Nobara
│           └── r1slm02w/
│               ├── FPC_driver_linux_27.26.23.39/
│               └── FPC_driver_linux_libfprint/
├── CHANGELOG.md                   # Registro de cambios
├── CONTRIBUTING.md                # Guía de contribución
├── LICENSE                        # Licencia MIT
└── README.md                      # Este archivo
```

### ⚙️ Configuración Rápida

Después de la instalación:

**GNOME:**
Configuración → Usuarios → Inicio de sesión con huella dactilar

**KDE/Otros:**
```bash
fprintd-enroll
```

### 🛠️ Solución de Problemas

**El dispositivo no aparece:**
- Verifica BIOS/UEFI - Habilita el lector de huellas
- Deshabilita Secure Boot

**Verificar servicio:**
```bash
systemctl status fprintd
journalctl -xe | grep fprint
```

**Reiniciar servicio:**
```bash
sudo systemctl restart fprintd
```

### 🤝 Contribuir

¿Encontraste una solución a un problema? ¿Tienes un consejo de optimización? ¡Las contribuciones son bienvenidas!

1. Haz fork de este repositorio
2. Crea una rama (`git checkout -b feature/nuevo-ajuste`)
3. Haz commit de tus cambios (`git commit -m 'Agregar nueva optimización'`)
4. Haz push a la rama (`git push origin feature/nuevo-ajuste`)
5. Abre un Pull Request

Lee nuestra [guía de contribución](CONTRIBUTING.md) para más detalles.

### 📄 Licencia

Este repositorio está licenciado bajo la [Licencia MIT](LICENSE).

**Nota importante:**
- **Drivers originales de Lenovo:** Propiedad de Lenovo (consulta archivos de licencia en r1slm02w/)
- **Scripts modificados y documentación:** Licencia MIT

### 🌐 Distribuciones Soportadas

| Distribución | Método | Estado | Guía |
|--------------|--------|--------|------|
| **Fedora/Nobara** | Drivers modificados de Lenovo | ✅ Probado | [Ver guía](docs/INSTALL_FEDORA.md) |
| **Ubuntu** | PPA oficial | ✅ Oficial | [Ver guía](docs/INSTALL_UBUNTU.md) |
| **Deepin 25** | Scripts de Lenovo (sistema inmutable) | ✅ Probado | [Ver guía](docs/INSTALL_DEEPIN.md) |
| **Arch Linux** | AUR (libfprint-fpcmoh-git) | ✅ Probado | [Ver guía](docs/INSTALL_ARCH.md) |
| **Manjaro/EndeavourOS** | AUR (libfprint-fpcmoh-git) | ✅ Compatible | [Ver guía](docs/INSTALL_ARCH.md) |

### 💡 ¿Qué método debo usar?

**Ubuntu:**
- **Único método funcional:** PPA oficial → Actualizaciones automáticas + soporte integrado
- ⚠️ Los drivers manuales **NO** funcionan en Ubuntu

**Deepin 25:**
- **Único método funcional:** Scripts originales de Lenovo (NO los modificados) con inmutabilidad desactivada
- ⚠️ Descarga el driver original de Lenovo
- ⚠️ Desactiva la inmutabilidad antes de instalar

**Arch Linux:**
- **Único método:** Paquete AUR → Mejor integración con el sistema

**Fedora/Nobara:**
- **Único método:** Drivers modificados de Lenovo (incluidos aquí)

### 🔗 Enlaces Útiles

**Fedora/Nobara:**
- [Tutorial original de Lukáš Maňák](https://lukan.cz/2024/10/fedora-40-fpc-fingerprint-lenovo-thinkpad/)
- [Driver original de Lenovo](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477)

**Ubuntu:**
- [PPA oficial libfprint-tod1-group](https://launchpad.net/~libfprint-tod1-group/+archive/ubuntu/ppa/)
- [Información sobre libfprint-2-tod1](https://gitlab.freedesktop.org/libfprint/libfprint)

**Arch Linux:**
- [Paquete AUR libfprint-fpcmoh-git](https://aur.archlinux.org/packages/libfprint-fpcmoh-git)
- [Wiki de Arch Linux sobre fprint](https://wiki.archlinux.org/title/Fprint)

### 👥 Créditos

**Scripts para Fedora/Nobara:**
- **Tutorial y Modificaciones:** [Lukáš Maňák](https://lukan.cz/2024/10/fedora-40-fpc-fingerprint-lenovo-thinkpad/)
- **Driver Original:** Lenovo (Ubuntu 20.04/22.04)

**PPA de Ubuntu:**
- **Mantenedor:** libfprint-tod1-group
- **Proyecto Base:** freedesktop.org libfprint

**Arch Linux:**
- **Paquete AUR:** Comunidad de Arch Linux
- **Proyecto Base:** libfprint con modificaciones para FPC MOH

**Repositorio:**
- **Organización y documentación adicional:** Contribuidores de este repositorio
- **Guías para Ubuntu y Arch:** Agregadas para facilitar la instalación multi-distro

---

**⭐ If this repository was helpful, consider giving it a star!**
**⭐ Si este repositorio te fue útil, ¡considera darle una estrella!**