# FPC 10a5:9800 Fingerprint Reader - Fedora & Derivatives Installation Guide

> 🌐 **Languages:** [English](#english) | [Español](#español)

---

## English

### Prerequisites
- Fedora or Fedora-based distribution (Nobara, Ultramarine, etc.)
- FPC Fingerprint Reader ID: 10a5:9800
- Root/sudo access

### Installation

#### 1. Verify Fingerprint Reader
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

Or use this repository which already contains the modified scripts in `drivers/modified/fedora-nobara/`.

#### 4. Install First Driver Component
```bash
cd drivers/modified/fedora-nobara/r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc
chmod +x install.sh
sudo ./install.sh
```

#### 5. Install Second Driver Component
```bash
cd ../../FPC_driver_linux_libfprint/install_libfprint
chmod +x install.sh
sudo ./install.sh
```

#### 6. Reboot (Recommended)
Although it may work without rebooting, it's recommended:
```bash
sudo reboot
```

### Configuration

#### For GNOME (default on Fedora and derivatives):
1. Go to **Settings** → **Users** → **Fingerprint Login**
2. Click **Enable**
3. Follow the on-screen instructions to scan your fingerprints

#### For other desktop environments:
```bash
sudo authselect enable-feature with-fingerprint
```

### Script Modifications Explanation

The original Lenovo scripts were designed for Ubuntu. This repository includes modified versions that automatically detect Fedora and adjust paths and commands appropriately.

#### First Script (`FPC_driver_linux_27.26.23.39/install_fpc/install.sh`)

**Main modification:**
```bash
if grep -qE 'ID=fedora' /etc/os-release; then
  sudo cp ./libfpcbep.so /usr/lib64/
  sudo chmod +x /usr/lib64/libfpcbep.so
else
  sudo cp ./libfpcbep.so /usr/lib/x86_64-linux-gnu/
fi;
```

**Changes:**
- Detects if the system is Fedora
- On Fedora: installs to `/usr/lib64/` (64-bit library path on Fedora)
- On Ubuntu: installs to `/usr/lib/x86_64-linux-gnu/`

#### Second Script (`FPC_driver_linux_libfprint/install_libfprint/install.sh`)

**Main modification:**
```bash
if grep -qE 'ID=fedora' /etc/os-release; then
  sudo dnf -y install libfprint fprintd fprintd-pam
  sudo cp -r lib/* /usr/lib/
  sudo cp usr/lib/x86_64-linux-gnu/* /usr/lib64/
  sudo chmod +x /usr/lib64/libfprint-2*
else
  sudo cp -r lib/* /lib/
  sudo cp -r usr/* /usr/
  sudo mkdir -p /var/log/fpc
  echo "libfprint-2-2 hold" | sudo dpkg --set-selections
  sudo chmod 755 /usr/lib/x86_64-linux-gnu/libfprint-2.so.2.0.0
fi
```

**Changes:**
- Uses `dnf` instead of `apt`
- Installs required packages: libfprint, fprintd, fprintd-pam
- Copies libraries to correct Fedora paths
- **Note:** libfprint version is not locked since versionlock command doesn't work correctly

### Troubleshooting

#### Device not showing in lsusb
- Verify the fingerprint reader is enabled in BIOS/UEFI
- Make sure Secure Boot is disabled

#### Error during installation
Verify you have all necessary permissions:
```bash
sudo chmod +x r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc/install.sh
sudo chmod +x r1slm02w/FPC_driver_linux_libfprint/install_libfprint/install.sh
```

#### Reader not working after installation
1. Check fprintd service status:
```bash
systemctl status fprintd
```

2. Review system logs:
```bash
journalctl -xe | grep fprint
```

3. Restart the service:
```bash
sudo systemctl restart fprintd
```

#### Issues after updating Fedora
If you experience problems after updating the system, you may need to reinstall the driver.

### Uninstall

If you need to uninstall the driver:

```bash
# Remove installed libraries
sudo rm /usr/lib64/libfpcbep.so
sudo rm /usr/lib64/libfprint-2.so.2*

# Unlock libfprint
sudo dnf versionlock delete libfprint

# Reinstall original libfprint
sudo dnf reinstall libfprint
```

### Credits

**Original Tutorial and Script Modifications:**
- [Lukáš Maňák](https://lukan.cz/2024/10/%f0%9f%94%91-fedora-40-fpc-fingerprint-lenovo-thinkpad-e14-gen-4-e15-gen-4-zprovozneni-ctecky-otisku-prstu/)
  - Tutorial: "🔑 Fedora 40 – FPC FingerPrint Lenovo ThinkPad E14 Gen 4, E15 Gen 4"

**Original Driver:**
- Lenovo (for Ubuntu 20.04/22.04)

### References
- Original tutorial: https://lukan.cz/2024/10/fedora-40-fpc-fingerprint-lenovo-thinkpad/
- Lenovo driver: https://pcsupport.lenovo.com/

### Supported Hardware
- ThinkPad E14 Gen 4
- ThinkPad E15 Gen 4
- ThinkBook 13s Gen 4 ARB
- Other Lenovo models with FPC 10a5:9800 reader

---

## Español

### Requisitos Previos
- Fedora o distribución basada en Fedora (Nobara, Ultramarine, etc.)
- Lector de Huellas FPC con ID: 10a5:9800
- Acceso root/sudo

### Instalación

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

O usa este repositorio que ya contiene los scripts modificados en `drivers/modified/fedora-nobara/`.

#### 4. Instalar el Primer Componente del Controlador
```bash
cd drivers/modified/fedora-nobara/r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc
chmod +x install.sh
sudo ./install.sh
```

#### 5. Instalar el Segundo Componente del Controlador
```bash
cd ../../FPC_driver_linux_libfprint/install_libfprint
chmod +x install.sh
sudo ./install.sh
```

#### 6. Reiniciar (Recomendado)
Aunque puede funcionar sin reiniciar, se recomienda:
```bash
sudo reboot
```

### Configuración

#### Para GNOME (predeterminado en Fedora y derivadas):
1. Ve a **Configuración** → **Usuarios** → **Inicio de sesión con huella dactilar**
2. Haz clic en **Activar**
3. Sigue las instrucciones en pantalla para escanear tus huellas dactilares

#### Para otros entornos de escritorio:
```bash
sudo authselect enable-feature with-fingerprint
```

### Explicación de las Modificaciones del Script

Los scripts originales de Lenovo fueron diseñados para Ubuntu. Este repositorio incluye versiones modificadas que detectan automáticamente Fedora y ajustan las rutas y comandos apropiadamente.

#### Primer Script (`FPC_driver_linux_27.26.23.39/install_fpc/install.sh`)

**Modificación principal:**
```bash
if grep -qE 'ID=fedora' /etc/os-release; then
  sudo cp ./libfpcbep.so /usr/lib64/
  sudo chmod +x /usr/lib64/libfpcbep.so
else
  sudo cp ./libfpcbep.so /usr/lib/x86_64-linux-gnu/
fi;
```

**Cambios:**
- Detecta si el sistema es Fedora
- En Fedora: instala en `/usr/lib64/` (ruta de bibliotecas de 64 bits en Fedora)
- En Ubuntu: instala en `/usr/lib/x86_64-linux-gnu/`

#### Segundo Script (`FPC_driver_linux_libfprint/install_libfprint/install.sh`)

**Modificación principal:**
```bash
if grep -qE 'ID=fedora' /etc/os-release; then
  sudo dnf -y install libfprint fprintd fprintd-pam
  sudo cp -r lib/* /usr/lib/
  sudo cp usr/lib/x86_64-linux-gnu/* /usr/lib64/
  sudo chmod +x /usr/lib64/libfprint-2*
else
  sudo cp -r lib/* /lib/
  sudo cp -r usr/* /usr/
  sudo mkdir -p /var/log/fpc
  echo "libfprint-2-2 hold" | sudo dpkg --set-selections
  sudo chmod 755 /usr/lib/x86_64-linux-gnu/libfprint-2.so.2.0.0
fi
```

**Cambios:**
- Usa `dnf` en lugar de `apt`
- Instala paquetes necesarios: libfprint, fprintd, fprintd-pam
- Copia bibliotecas a las rutas correctas de Fedora
- **Nota:** No se bloquea la versión de libfprint ya que el comando versionlock no funciona correctamente

### Solución de Problemas

#### El dispositivo no aparece en lsusb
- Verifica que el lector de huellas esté habilitado en BIOS/UEFI
- Asegúrate de que Secure Boot esté deshabilitado

#### Error durante la instalación
Verifica que tienes todos los permisos necesarios:
```bash
sudo chmod +x r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc/install.sh
sudo chmod +x r1slm02w/FPC_driver_linux_libfprint/install_libfprint/install.sh
```

#### El lector no funciona después de la instalación
1. Verifica el estado del servicio fprintd:
```bash
systemctl status fprintd
```

2. Revisa los logs del sistema:
```bash
journalctl -xe | grep fprint
```

3. Reinicia el servicio:
```bash
sudo systemctl restart fprintd
```

#### Problemas después de actualizar Fedora
Si experimentas problemas después de actualizar el sistema, es posible que necesites reinstalar el driver.

### Desinstalar

Si necesitas desinstalar el driver:

```bash
# Eliminar bibliotecas instaladas
sudo rm /usr/lib64/libfpcbep.so
sudo rm /usr/lib64/libfprint-2.so.2*

# Desbloquear libfprint
sudo dnf versionlock delete libfprint

# Reinstalar libfprint original
sudo dnf reinstall libfprint
```

### Créditos

**Tutorial Original y Modificaciones de Scripts:**
- [Lukáš Maňák](https://lukan.cz/2024/10/%f0%9f%94%91-fedora-40-fpc-fingerprint-lenovo-thinkpad-e14-gen-4-e15-gen-4-zprovozneni-ctecky-otisku-prstu/)
  - Tutorial: "🔑 Fedora 40 – FPC FingerPrint Lenovo ThinkPad E14 Gen 4, E15 Gen 4"

**Controlador Original:**
- Lenovo (para Ubuntu 20.04/22.04)

### Referencias
- Tutorial original: https://lukan.cz/2024/10/fedora-40-fpc-fingerprint-lenovo-thinkpad/
- Driver de Lenovo: https://pcsupport.lenovo.com/

### Hardware Soportado
- ThinkPad E14 Gen 4
- ThinkPad E15 Gen 4
- ThinkBook 13s Gen 4 ARB
- Otros modelos Lenovo con lector FPC 10a5:9800
