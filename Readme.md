# FPC Fingerprint Reader Driver Installation for Fedora/Nobara

## English Version

### Description
This repository contains modified installation scripts for the FPC 10a5:9800 fingerprint reader driver, specifically adapted for Fedora and Nobara Linux distributions. The original driver from Lenovo was designed for Ubuntu, but these modifications allow it to work seamlessly on Fedora-based systems.

### Prerequisites
- Fedora or Nobara Linux
- FPC Fingerprint Reader with ID: 10a5:9800
- Root/sudo access

### Installation Instructions

#### 1. Verify Your Fingerprint Reader
First, confirm you have the correct FPC 10a5:9800 fingerprint reader:
```bash
lsusb
```
Look for a line containing "10a5:9800" in the output.

#### 2. Install fprintd Package
```bash
sudo dnf install fprintd
```

#### 3. Download the Driver
Download the FPC FingerPrint Driver (r1slm02w.zip) from Lenovo's website:
[Lenovo FPC Driver Download](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477-fpc-fingerprint-driver-for-ubuntu-2004-ubuntu-2204-thinkpad-e14-gen-4-e15-gen-4?category=Fingerprint%20Reader)

Or clone this repository which already contains the modified scripts.

#### 4. Script Modifications Explained

##### First Installation Script (`FPC_driver_linux_27.26.23.39/install_fpc/install.sh`)

**Original code:**
```bash
sudo cp ./libfpcbep.so /usr/lib64/
sudo chmod +x /usr/lib64/libfpcbep.so
```

**Modified code:**
```bash
if grep -qE 'ID=fedora' /etc/os-release; then
  sudo cp ./libfpcbep.so /usr/lib64/
  sudo chmod +x /usr/lib64/libfpcbep.so
else
  sudo cp ./libfpcbep.so /usr/lib/x86_64-linux-gnu/
fi;
```

**Changes:**
- Added OS detection to identify Fedora-based systems
- On Fedora/Nobara: installs library to `/usr/lib64/` (correct path for Fedora)
- On other systems (Ubuntu): installs to `/usr/lib/x86_64-linux-gnu/`
- Makes the script compatible with both Fedora and Debian-based distributions

##### Second Installation Script (`FPC_driver_linux_libfprint/install_libfprint/install.sh`)

**Modified code:**
```bash
if grep -qE 'ID=fedora' /etc/os-release; then
  sudo dnf -y install libfprint fprintd fprintd-pam 'dnf-command(versionlock)'
  sudo dnf versionlock libfprint
  sudo cp -r lib/* /usr/lib/
  sudo cp usr/lib/x86_64-linux-gnu/* /usr/lib64/
  sudo chmod +x /usr/lib64/libfprint-2*
else
  sudo cp -r lib/* /lib/
  sudo cp -r usr/* /usr/
  sudo mkdir -p /var/log/fpc
  #avoid libfprint being modified under apt upgrading
  echo "libfprint-2-2 hold" | sudo dpkg --set-selections
  sudo chmod 755 /usr/lib/x86_64-linux-gnu/libfprint-2.so.2.0.0
fi
echo "Installation completed successfully. You must reboot your system."
```

**Changes:**
- **Fedora path:** Uses `dnf` package manager instead of `apt`
- Installs required packages: `libfprint`, `fprintd`, `fprintd-pam`, and version lock plugin
- Locks `libfprint` version to prevent updates from breaking the driver
- Copies libraries to `/usr/lib64/` (Fedora's 64-bit library path)
- **Ubuntu path:** Uses original Ubuntu installation method with `dpkg` to hold package versions
- Adds informative message about system reboot

#### 5. Install First Driver Component
```bash
cd r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc
chmod +x install.sh
sudo ./install.sh
```

#### 6. Install Second Driver Component
```bash
cd ../../FPC_driver_linux_libfprint/install_libfprint
chmod +x install.sh
sudo ./install.sh
```

#### 7. Reboot (Recommended)
Although it may work without reboot, it's recommended:
```bash
sudo reboot
```

#### 8. Configure Fingerprint in GNOME
1. Go to **Settings** → **Users** → **Fingerprint Login**
2. Click **Enable**
3. Follow the on-screen instructions to scan your fingerprints

For other desktop environments, try:
```bash
sudo authselect enable-feature with-fingerprint
```

### Troubleshooting
- If `lsusb` doesn't show your device, check if the fingerprint reader is enabled in BIOS
- If installation fails, ensure you have disabled Secure Boot
- Check system logs: `journalctl -xe`

### License
This repository contains drivers from Lenovo. Please refer to the original license files included in the driver packages.

---

## Español:

### Descripción
Este repositorio contiene scripts de instalación modificados para el lector de huellas dactilares FPC 10a5:9800, específicamente adaptados para las distribuciones de Linux Fedora y Nobara. El controlador original de Lenovo fue diseñado para Ubuntu, pero estas modificaciones permiten que funcione sin problemas en sistemas basados en Fedora.

### Requisitos Previos
- Fedora o Nobara Linux
- Lector de Huellas FPC con ID: 10a5:9800
- Acceso root/sudo

### Instrucciones de Instalación

#### 1. Verificar el Lector de Huellas
Primero, confirma que tienes el lector de huellas correcto FPC 10a5:9800:
```bash
lsusb
```
Busca una línea que contenga "10a5:9800" en la salida.

#### 2. Instalar el Paquete fprintd
```bash
sudo dnf install fprintd
```

#### 3. Descargar el Controlador
Descarga el controlador FPC FingerPrint Driver (r1slm02w.zip) del sitio web de Lenovo:
[Descarga del Driver FPC de Lenovo](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477-fpc-fingerprint-driver-for-ubuntu-2004-ubuntu-2204-thinkpad-e14-gen-4-e15-gen-4?category=Fingerprint%20Reader)

O clona este repositorio que ya contiene los scripts modificados.

#### 4. Modificaciones de los Scripts Explicadas

##### Primer Script de Instalación (`FPC_driver_linux_27.26.23.39/install_fpc/install.sh`)

**Código original:**
```bash
sudo cp ./libfpcbep.so /usr/lib64/
sudo chmod +x /usr/lib64/libfpcbep.so
```

**Código modificado:**
```bash
if grep -qE 'ID=fedora' /etc/os-release; then
  sudo cp ./libfpcbep.so /usr/lib64/
  sudo chmod +x /usr/lib64/libfpcbep.so
else
  sudo cp ./libfpcbep.so /usr/lib/x86_64-linux-gnu/
fi;
```

**Cambios:**
- Se agregó detección del sistema operativo para identificar sistemas basados en Fedora
- En Fedora/Nobara: instala la biblioteca en `/usr/lib64/` (ruta correcta para Fedora)
- En otros sistemas (Ubuntu): instala en `/usr/lib/x86_64-linux-gnu/`
- Hace que el script sea compatible tanto con distribuciones Fedora como basadas en Debian

##### Segundo Script de Instalación (`FPC_driver_linux_libfprint/install_libfprint/install.sh`)

**Código modificado:**
```bash
if grep -qE 'ID=fedora' /etc/os-release; then
  sudo dnf -y install libfprint fprintd fprintd-pam 'dnf-command(versionlock)'
  sudo dnf versionlock libfprint
  sudo cp -r lib/* /usr/lib/
  sudo cp usr/lib/x86_64-linux-gnu/* /usr/lib64/
  sudo chmod +x /usr/lib64/libfprint-2*
else
  sudo cp -r lib/* /lib/
  sudo cp -r usr/* /usr/
  sudo mkdir -p /var/log/fpc
  #avoid libfprint being modified under apt upgrading
  echo "libfprint-2-2 hold" | sudo dpkg --set-selections
  sudo chmod 755 /usr/lib/x86_64-linux-gnu/libfprint-2.so.2.0.0
fi
echo "Installation completed successfully. You must reboot your system."
```

**Cambios:**
- **Ruta Fedora:** Usa el gestor de paquetes `dnf` en lugar de `apt`
- Instala los paquetes requeridos: `libfprint`, `fprintd`, `fprintd-pam` y el plugin de bloqueo de versión
- Bloquea la versión de `libfprint` para evitar que las actualizaciones rompan el controlador
- Copia las bibliotecas a `/usr/lib64/` (ruta de bibliotecas de 64 bits de Fedora)
- **Ruta Ubuntu:** Usa el método de instalación original de Ubuntu con `dpkg` para mantener las versiones de paquetes
- Agrega mensaje informativo sobre el reinicio del sistema

#### 5. Instalar el Primer Componente del Controlador
```bash
cd r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc
chmod +x install.sh
sudo ./install.sh
```

#### 6. Instalar el Segundo Componente del Controlador
```bash
cd ../../FPC_driver_linux_libfprint/install_libfprint
chmod +x install.sh
sudo ./install.sh
```

#### 7. Reiniciar (Recomendado)
Aunque puede funcionar sin reiniciar, se recomienda:
```bash
sudo reboot
```

#### 8. Configurar Huella Dactilar en GNOME
1. Ve a **Configuración** → **Usuarios** → **Inicio de sesión con huella dactilar**
2. Haz clic en **Activar**
3. Sigue las instrucciones en pantalla para escanear tus huellas dactilares

Para otros entornos de escritorio, prueba:
```bash
sudo authselect enable-feature with-fingerprint
```

### Solución de Problemas
- Si `lsusb` no muestra tu dispositivo, verifica si el lector de huellas está habilitado en BIOS
- Si la instalación falla, asegúrate de haber deshabilitado Secure Boot
- Revisa los logs del sistema: `journalctl -xe`

### Licencia
Este repositorio contiene controladores de Lenovo. Por favor consulta los archivos de licencia originales incluidos en los paquetes del controlador.

---

## Credits / Créditos

### English
- **Original Tutorial and Script Modifications:** [Lukáš Maňák](https://lukan.cz/2024/10/%f0%9f%94%91-fedora-40-fpc-fingerprint-lenovo-thinkpad-e14-gen-4-e15-gen-4-zprovozneni-ctecky-otisku-prstu/)
  - Tutorial: "🔑 Fedora 40 – FPC FingerPrint Lenovo ThinkPad E14 Gen 4, E15 Gen 4 (Zprovoznění čtečky otisku prstů)"
- **Original FPC Driver:** Lenovo (for Ubuntu 20.04/22.04)
- **Hardware Supported:** ThinkPad E14 Gen 4, E15 Gen 4 with FPC 10a5:9800 fingerprint reader

### Español
- **Tutorial Original y Modificaciones de Scripts:** [Lukáš Maňák](https://lukan.cz/2024/10/%f0%9f%94%91-fedora-40-fpc-fingerprint-lenovo-thinkpad-e14-gen-4-e15-gen-4-zprovozneni-ctecky-otisku-prstu/)
  - Tutorial: "🔑 Fedora 40 – FPC FingerPrint Lenovo ThinkPad E14 Gen 4, E15 Gen 4 (Zprovoznění čtečky otisku prstů)"
- **Controlador FPC Original:** Lenovo (para Ubuntu 20.04/22.04)
- **Hardware Soportado:** ThinkPad E14 Gen 4, E15 Gen 4 con lector de huellas FPC 10a5:9800

### Special Thanks / Agradecimientos Especiales
Special thanks to Lukáš Maňák for documenting the installation process and creating the script modifications that made this driver work on Fedora-based distributions.

Un agradecimiento especial a Lukáš Maňák por documentar el proceso de instalación y crear las modificaciones de scripts que hicieron que este controlador funcione en distribuciones basadas en Fedora.