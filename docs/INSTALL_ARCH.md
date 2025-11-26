# FPC 10a5:9800 Fingerprint Reader - Arch Linux Installation Guide

> 🌐 **Languages:** [English](#english) | [Español](#español)

---

## English

### Prerequisites
- Arch Linux or Arch-based distributions (Manjaro, EndeavourOS, etc.)
- FPC Fingerprint Reader ID: 10a5:9800
- Root/sudo access
- `yay` or `paru` (AUR helper) installed

### Installation

#### 1. Verify Fingerprint Reader
First, confirm you have the correct FPC 10a5:9800 fingerprint reader:
```bash
lsusb
```
Look for a line containing "10a5:9800" in the output.

#### 2. Install libfprint-fpcmoh-git from AUR

##### Using yay:
```bash
# Install build dependencies first
sudo pacman -S base-devel git meson ninja glib2-devel

# Install from AUR
yay -S libfprint-fpcmoh-git
```

##### Using paru:
```bash
# Install build dependencies first
sudo pacman -S base-devel git meson ninja glib2-devel

# Install from AUR
paru -S libfprint-fpcmoh-git
```

##### Manual installation from AUR:
If you prefer to install manually without an AUR helper:
```bash
# Install build dependencies
sudo pacman -S base-devel git meson ninja glib2-devel

# Clone the AUR repository
git clone https://aur.archlinux.org/libfprint-fpcmoh-git.git
cd libfprint-fpcmoh-git

# Build and install
makepkg -si
```

#### 3. Install fprintd
```bash
sudo pacman -S fprintd
```

#### 4. Enable and Start fprintd Service
```bash
sudo systemctl enable fprintd.service
sudo systemctl start fprintd.service
```

#### 5. Reboot the System (Recommended)
```bash
sudo reboot
```

### Configuration

#### For GNOME:
1. Open **Settings** → **Users**
2. Select your user
3. Go to **Fingerprint Login**
4. Click **Enable** and follow the instructions

#### For KDE Plasma:
1. Open **System Settings**
2. Go to **Workspace** → **Screen Locking (SDDM)**
3. Or use the command line tool

#### Configuration via CLI:
Enroll (register) a fingerprint:
```bash
fprintd-enroll
```

Verify registered fingerprints:
```bash
fprintd-list $USER
```

### Troubleshooting

#### Device not showing in lsusb
- Verify the fingerprint reader is enabled in BIOS/UEFI
- Make sure Secure Boot is disabled

#### Error compiling from AUR
Make sure you have all build dependencies:
```bash
sudo pacman -S base-devel git meson ninja glib2-devel
```

#### fprintd service doesn't start
Check service status:
```bash
systemctl status fprintd
```

Review logs:
```bash
journalctl -u fprintd -e
```

#### Reader not detected
Verify the kernel module is loaded:
```bash
lsmod | grep fpc
```

Restart the service:
```bash
sudo systemctl restart fprintd
```

### Uninstall

If you need to uninstall the driver:
```bash
sudo pacman -R libfprint-fpcmoh-git fprintd
```

### References
- AUR package: https://aur.archlinux.org/packages/libfprint-fpcmoh-git
- Arch Linux wiki on fprint: https://wiki.archlinux.org/title/Fprint
- GitHub repository: https://github.com/

### Additional Notes
- `libfprint-fpcmoh-git` is a modified version of libfprint with support for FPC MOH (Match-on-Host) sensors
- The package builds from source code, so it may take a few minutes
- Compatible with ThinkPad E14 Gen 4, E15 Gen 4 and other models with FPC 10a5:9800 sensor
- This method is preferable to proprietary drivers as it's better integrated with the system

### Supported Hardware
- FPC 10a5:9800
  - ThinkPad E14 Gen 4
  - ThinkPad E15 Gen 4
  - ThinkBook 13s Gen 4 ARB
- Possibly other Lenovo models with similar FPC sensors

---

## Español

### Requisitos Previos
- Arch Linux o distribuciones basadas en Arch (Manjaro, EndeavourOS, etc.)
- Lector de Huellas FPC con ID: 10a5:9800
- Acceso root/sudo
- `yay` o `paru` (AUR helper) instalado

### Instalación

#### 1. Verificar el Lector de Huellas
Primero, confirma que tienes el lector de huellas correcto FPC 10a5:9800:
```bash
lsusb
```
Busca una línea que contenga "10a5:9800" en la salida.

#### 2. Instalar libfprint-fpcmoh-git desde AUR

##### Usando yay:
```bash
# Instalar dependencias de compilación primero
sudo pacman -S base-devel git meson ninja glib2-devel

# Instalar desde AUR
yay -S libfprint-fpcmoh-git
```

##### Usando paru:
```bash
# Instalar dependencias de compilación primero
sudo pacman -S base-devel git meson ninja glib2-devel

# Instalar desde AUR
paru -S libfprint-fpcmoh-git
```

##### Instalación manual desde AUR:
Si prefieres instalar manualmente sin un AUR helper:
```bash
# Instalar dependencias de compilación
sudo pacman -S base-devel git meson ninja glib2-devel

# Clonar el repositorio del AUR
git clone https://aur.archlinux.org/libfprint-fpcmoh-git.git
cd libfprint-fpcmoh-git

# Compilar e instalar
makepkg -si
```

#### 3. Instalar fprintd
```bash
sudo pacman -S fprintd
```

#### 4. Habilitar y Iniciar el Servicio fprintd
```bash
sudo systemctl enable fprintd.service
sudo systemctl start fprintd.service
```

#### 5. Reiniciar el Sistema (Recomendado)
```bash
sudo reboot
```

### Configuración

#### Para GNOME:
1. Abre **Configuración** → **Usuarios**
2. Selecciona tu usuario
3. Ve a **Inicio de sesión con huella dactilar**
4. Haz clic en **Activar** y sigue las instrucciones

#### Para KDE Plasma:
1. Abre **Configuración del Sistema**
2. Ve a **Espacio de trabajo** → **Inicio de sesión de pantalla (SDDM)**
3. O usa la herramienta de línea de comandos

#### Configuración mediante CLI:
Enrollar (registrar) una huella dactilar:
```bash
fprintd-enroll
```

Verificar huellas registradas:
```bash
fprintd-list $USER
```

### Solución de Problemas

#### El dispositivo no aparece en lsusb
- Verifica que el lector de huellas esté habilitado en BIOS/UEFI
- Asegúrate de que Secure Boot esté deshabilitado

#### Error al compilar desde AUR
Asegúrate de tener todas las dependencias de compilación:
```bash
sudo pacman -S base-devel git meson ninja glib2-devel
```

#### El servicio fprintd no inicia
Verifica el estado del servicio:
```bash
systemctl status fprintd
```

Revisa los logs:
```bash
journalctl -u fprintd -e
```

#### El lector no es detectado
Verifica que el módulo del kernel esté cargado:
```bash
lsmod | grep fpc
```

Reinicia el servicio:
```bash
sudo systemctl restart fprintd
```

### Desinstalar

Si necesitas desinstalar el driver:
```bash
sudo pacman -R libfprint-fpcmoh-git fprintd
```

### Referencias
- Paquete AUR: https://aur.archlinux.org/packages/libfprint-fpcmoh-git
- Wiki de Arch Linux sobre fprint: https://wiki.archlinux.org/title/Fprint
- Repositorio GitHub: https://github.com/

### Notas Adicionales
- `libfprint-fpcmoh-git` es una versión modificada de libfprint con soporte para sensores FPC MOH (Match-on-Host)
- El paquete se compila desde el código fuente, por lo que puede tardar unos minutos
- Compatible con ThinkPad E14 Gen 4, E15 Gen 4 y otros modelos con sensor FPC 10a5:9800
- Este método es preferible a los drivers propietarios ya que está mejor integrado con el sistema

### Hardware Soportado
- FPC 10a5:9800
  - ThinkPad E14 Gen 4
  - ThinkPad E15 Gen 4
  - ThinkBook 13s Gen 4 ARB
- Posiblemente otros modelos Lenovo con sensores FPC similares
