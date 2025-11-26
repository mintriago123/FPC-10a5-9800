# FPC 10a5:9800 Fingerprint Reader - Ubuntu Installation Guide

> 🌐 **Languages:** [English](#english) | [Español](#español)

---

## English

### Prerequisites
- Ubuntu 20.04 or higher
- FPC Fingerprint Reader ID: 10a5:9800
- Root/sudo access

### Installation via Official PPA

This method uses the official PPA from the libfprint-tod1-group, which provides updated support for Touch-on-Display (TOD) fingerprint readers.

#### 1. Verify Fingerprint Reader
First, confirm you have the correct FPC 10a5:9800 fingerprint reader:
```bash
lsusb
```
Look for a line containing "10a5:9800" in the output.

#### 2. Add the PPA
```bash
sudo add-apt-repository ppa:libfprint-tod1-group/ppa
sudo apt update
```

#### 3. Install libfprint-2-tod1-fpc
```bash
sudo apt install libfprint-2-tod1-fpc fprintd
```

This package provides specific support for FPC Touch-on-Display sensors.

#### 4. Reboot the System
```bash
sudo reboot
```

#### 5. Configure Fingerprint
**On GNOME:**
1. Go to **Settings** → **Users** → **Fingerprint Login**
2. Click **Enable**
3. Follow the on-screen instructions to scan your fingerprints

**On other desktop environments:**
```bash
sudo authselect enable-feature with-fingerprint
```

### Troubleshooting

#### Device not showing in lsusb
- Verify the fingerprint reader is enabled in BIOS/UEFI
- Make sure Secure Boot is disabled

#### Error adding the PPA
If you get an error adding the PPA, check your internet connection and ensure your Ubuntu version is compatible.

#### Reader not working after installation
1. Check fprintd service status:
```bash
systemctl status fprintd
```

2. Review system logs:
```bash
journalctl -xe | grep fprint
```

3. Try restarting the service:
```bash
sudo systemctl restart fprintd
```

#### Issues with updates
Updates are handled automatically through the PPA. The `libfprint-2-tod1-fpc` package will receive security updates and bug fixes.

### References
- Official PPA: https://launchpad.net/~libfprint-tod1-group/+archive/ubuntu/ppa/
- Original Lenovo driver: [Lenovo Support](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477-fpc-fingerprint-driver-for-ubuntu-2004-ubuntu-2204-thinkpad-e14-gen-4-e15-gen-4)

### Additional Notes
- The `libfprint-2-tod1-fpc` package is specifically designed for FPC Touch-on-Display sensors
- This method receives automatic security updates through the PPA
- Compatible with:
  - ThinkPad E14 Gen 4, E15 Gen 4
  - ThinkBook 13s Gen 4 ARB
  - Other Lenovo models with FPC 10a5:9800 sensor
- **Important note:** Lenovo's manual drivers **do not work correctly** on Ubuntu. Always use the official PPA.

---

## Español

### Requisitos Previos
- Ubuntu 20.04 o superior
- Lector de Huellas FPC con ID: 10a5:9800
- Acceso root/sudo

### Instalación mediante PPA Oficial

Este método utiliza el PPA oficial del grupo libfprint-tod1, que proporciona soporte actualizado para lectores de huellas Touch-on-Display (TOD).

#### 1. Verificar el Lector de Huellas
Primero, confirma que tienes el lector de huellas correcto FPC 10a5:9800:
```bash
lsusb
```
Busca una línea que contenga "10a5:9800" en la salida.

#### 2. Agregar el PPA
```bash
sudo add-apt-repository ppa:libfprint-tod1-group/ppa
sudo apt update
```

#### 3. Instalar libfprint-2-tod1-fpc
```bash
sudo apt install libfprint-2-tod1-fpc fprintd
```

Este paquete proporciona soporte específico para los sensores FPC Touch-on-Display.

#### 4. Reiniciar el Sistema
```bash
sudo reboot
```

#### 5. Configurar Huella Dactilar
**En GNOME:**
1. Ve a **Configuración** → **Usuarios** → **Inicio de sesión con huella dactilar**
2. Haz clic en **Activar**
3. Sigue las instrucciones en pantalla para escanear tus huellas dactilares

**En otros entornos de escritorio:**
```bash
sudo authselect enable-feature with-fingerprint
```

### Solución de Problemas

#### El dispositivo no aparece en lsusb
- Verifica que el lector de huellas esté habilitado en BIOS/UEFI
- Asegúrate de que Secure Boot esté deshabilitado

#### Error al agregar el PPA
Si obtienes un error al agregar el PPA, verifica tu conexión a internet y asegúrate de que tu versión de Ubuntu sea compatible.

#### El lector no funciona después de la instalación
1. Verifica el estado del servicio fprintd:
```bash
systemctl status fprintd
```

2. Revisa los logs del sistema:
```bash
journalctl -xe | grep fprint
```

3. Intenta reiniciar el servicio:
```bash
sudo systemctl restart fprintd
```

#### Problemas con actualizaciones
Las actualizaciones se manejan automáticamente a través del PPA. El paquete `libfprint-2-tod1-fpc` recibirá actualizaciones de seguridad y correcciones de errores.

### Referencias
- PPA oficial: https://launchpad.net/~libfprint-tod1-group/+archive/ubuntu/ppa/
- Driver original de Lenovo: [Lenovo Support](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477-fpc-fingerprint-driver-for-ubuntu-2004-ubuntu-2204-thinkpad-e14-gen-4-e15-gen-4)

### Notas Adicionales
- El paquete `libfprint-2-tod1-fpc` está específicamente diseñado para sensores FPC Touch-on-Display
- Este método recibe actualizaciones de seguridad automáticas a través del PPA
- Compatible con:
  - ThinkPad E14 Gen 4, E15 Gen 4
  - ThinkBook 13s Gen 4 ARB
  - Otros modelos Lenovo con sensor FPC 10a5:9800
- **Nota importante:** Los drivers manuales de Lenovo **no funcionan correctamente** en Ubuntu. Usa siempre el PPA oficial.
