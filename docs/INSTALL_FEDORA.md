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

---

### Alternative Method: RPM Package (Tested on Ultramarine 43)

> If the scripts above worked for you, you're done — skip this section entirely.
> This method is useful if you prefer a single `dnf` command, or if the scripts fail on your system for any reason.

As an alternative to the scripts above, you can install the pre-built Lenovo-patched RPM directly with `dnf`. This method was tested on **Ultramarine Linux 43** and replaces the system `libfprint` automatically thanks to the `Obsoletes` tag in the package.

```bash
cd drivers/Fedora\ Atomic
sudo dnf install ./libfprint-1.94.10-1.lenovo.fc42.x86_64.rpm
```

`dnf` will show a transaction summary similar to:
```
Upgrading:  libfprint  x86_64  1.94.10-1.lenovo.fc42  (replacing libfprint x86_64 1.94.9-4.fc43)
```
Confirm with `y` and reboot.

> ⚠️ **Warning:** The RPM is signed with a Lenovo key not in your system's keyring. `dnf` will warn about a missing OpenPGP signature — this is expected. Review the package source before accepting.

After installation, enroll your fingerprint **as a regular user (without sudo)**:
```bash
fprintd-enroll
```
You will be prompted to authenticate via your desktop session (PolicyKit). Running it with `sudo` will cause a permission error.

---

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

The script installs the proprietary FPC library directly to the Fedora 64-bit library path:

```bash
sudo cp ./libfpcbep.so /usr/lib64/
sudo chmod +x /usr/lib64/libfpcbep.so
```

**Changes from original:**
- Installs to `/usr/lib64/` instead of `/usr/lib/x86_64-linux-gnu/` (Ubuntu path)
- OS detection logic removed; script is now Fedora-only

#### Second Script (`FPC_driver_linux_libfprint/install_libfprint/install.sh`)

The script installs `libfprint` and related packages via `dnf`, then copies the patched libraries to the correct Fedora paths:

```bash
sudo dnf -y install libfprint fprintd fprintd-pam
sudo cp -r lib/* /usr/lib/
sudo cp usr/lib/x86_64-linux-gnu/* /usr/lib64/
sudo chmod +x /usr/lib64/libfprint-2*
```

**Changes from original:**
- Uses `dnf` instead of `apt`
- Installs required packages: `libfprint`, `fprintd`, `fprintd-pam`
- Copies libraries to Fedora paths (`/usr/lib/`, `/usr/lib64/`)
- OS detection logic removed; script is now Fedora-only
- libfprint version is **not** locked (versionlock is not used)

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

#### Method 1 — Scripts

If you installed using the scripts, remove the libraries manually and reinstall the upstream `libfprint`:

```bash
# Remove installed libraries
sudo rm -f /usr/lib64/libfpcbep.so
sudo rm -f /usr/lib64/libfprint-2.so.2 /usr/lib64/libfprint-2.so.2.0.0
sudo rm -f /usr/lib/udev/rules.d/60-libfprint-2-device-fpc.rules

# Reinstall upstream libfprint
sudo dnf reinstall libfprint
```

#### Method 2 — RPM package

If you installed using `dnf install` with the Lenovo RPM, remove it and reinstall the upstream package:

```bash
sudo dnf remove libfprint
sudo dnf install libfprint
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

---

### Método Alternativo: Paquete RPM (Probado en Ultramarine 43)

> Si los scripts anteriores funcionaron correctamente, ya terminaste — puedes saltarte esta sección.
> Este método es útil si prefieres un único comando `dnf`, o si los scripts fallan en tu sistema por alguna razón.

Como alternativa a los scripts anteriores, puedes instalar directamente el RPM parcheado por Lenovo con `dnf`. Este método fue probado en **Ultramarine Linux 43** y reemplaza el `libfprint` del sistema automáticamente gracias a la etiqueta `Obsoletes` del paquete.

```bash
cd drivers/Fedora\ Atomic
sudo dnf install ./libfprint-1.94.10-1.lenovo.fc42.x86_64.rpm
```

`dnf` mostrará un resumen de transacción similar a:
```
Modernizando:  libfprint  x86_64  1.94.10-1.lenovo.fc42  (reemplazando libfprint x86_64 1.94.9-4.fc43)
```
Confirma con `y` y reinicia.

> ⚠️ **Advertencia:** El RPM está firmado con una clave que no está en el anillo de claves de tu sistema. `dnf` mostrará un aviso sobre la firma OpenPGP omitida — esto es esperado. Revisa la procedencia del paquete antes de aceptar.

Tras la instalación, registra tu huella **como usuario normal (sin sudo)**:
```bash
fprintd-enroll
```
Se te pedirá autenticación mediante la sesión de escritorio (PolicyKit). Ejecutarlo con `sudo` causará un error de permisos.

---

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

El script instala la biblioteca propietaria de FPC directamente en la ruta de bibliotecas de 64 bits de Fedora:

```bash
sudo cp ./libfpcbep.so /usr/lib64/
sudo chmod +x /usr/lib64/libfpcbep.so
```

**Cambios respecto al original:**
- Instala en `/usr/lib64/` en lugar de `/usr/lib/x86_64-linux-gnu/` (ruta de Ubuntu)
- Lógica de detección de OS eliminada; el script es ahora exclusivo para Fedora

#### Segundo Script (`FPC_driver_linux_libfprint/install_libfprint/install.sh`)

El script instala `libfprint` y paquetes relacionados mediante `dnf`, y copia las bibliotecas parcheadas a las rutas correctas de Fedora:

```bash
sudo dnf -y install libfprint fprintd fprintd-pam
sudo cp -r lib/* /usr/lib/
sudo cp usr/lib/x86_64-linux-gnu/* /usr/lib64/
sudo chmod +x /usr/lib64/libfprint-2*
```

**Cambios respecto al original:**
- Usa `dnf` en lugar de `apt`
- Instala los paquetes necesarios: `libfprint`, `fprintd`, `fprintd-pam`
- Copia las bibliotecas a las rutas de Fedora (`/usr/lib/`, `/usr/lib64/`)
- Lógica de detección de OS eliminada; el script es ahora exclusivo para Fedora
- La versión de libfprint **no** se bloquea (no se usa versionlock)

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

#### Método 1 — Scripts

Si instalaste usando los scripts, elimina las bibliotecas manualmente y reinstala el `libfprint` original del repositorio:

```bash
# Eliminar bibliotecas instaladas
sudo rm -f /usr/lib64/libfpcbep.so
sudo rm -f /usr/lib64/libfprint-2.so.2 /usr/lib64/libfprint-2.so.2.0.0
sudo rm -f /usr/lib/udev/rules.d/60-libfprint-2-device-fpc.rules

# Reinstalar libfprint original
sudo dnf reinstall libfprint
```

#### Método 2 — Paquete RPM

Si instalaste usando `dnf install` con el RPM de Lenovo, elimina el paquete y reinstala el original:

```bash
sudo dnf remove libfprint
sudo dnf install libfprint
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
