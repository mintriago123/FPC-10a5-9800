# FPC 10a5:9800 Fingerprint Reader - Deepin 25 Installation Guide

> 🌐 **Languages:** [English](#english) | [Español](#español)

---

## English

### Prerequisites
- Deepin 25
- FPC Fingerprint Reader ID: 10a5:9800
- Root/sudo access

### Installation

#### 1. Verify Fingerprint Reader
First, confirm you have the correct FPC 10a5:9800 fingerprint reader:
```bash
lsusb
```
Look for a line containing "10a5:9800" in the output.

#### 2. Download Original Lenovo Driver
Download the FPC FingerPrint Driver (r1slm02w.zip) from Lenovo's website:
[Lenovo FPC Driver Download](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477)

**Alternative:** The original file is also included in this repository at `drivers/original/r1slm02w.zip` for your convenience.

Unzip the file:
```bash
unzip r1slm02w.zip
```

#### 3. Disable System Immutability
Deepin 25 has an immutable file system by default. You must disable it to install the driver:

**Official method:**
```bash
sudo deepin-immutable-writable enable
```

**Alternative tool (use at your own risk):**

If the official method doesn't work, there's a community tool:
- [immutable-deepin-tools](https://github.com/deepin-espanol/immutable-deepin-tools)

⚠️ **Warning:** This is a third-party tool. Use at your own risk.

#### 4. Reboot the System (Mandatory)
After disabling immutability, it's necessary to reboot:
```bash
sudo reboot
```

⚠️ **Important:** Do NOT continue with the installation without rebooting first.

#### 5. Navigate to Installation Directory
```bash
cd r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc
```

**Note:** If you unzipped from `drivers/original/r1slm02w.zip`, the path will be the same as the content is identical.

#### 6. Install First Driver Component
```bash
chmod +x install.sh
sudo ./install.sh
```

#### 7. Install Second Driver Component
```bash
cd ../../FPC_driver_linux_libfprint/install_libfprint
chmod +x install.sh
sudo ./install.sh
```

#### 8. Reboot the System (Mandatory)
It's necessary to reboot for the driver changes to take effect:
```bash
sudo reboot
```

### Configuration

#### On Deepin:
1. Go to **Control Center** → **Accounts** → **Fingerprint**
2. Click **Add Fingerprint**
3. Follow the on-screen instructions to scan your fingerprints

#### Via command line:
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

#### Error installing the driver
Verify immutability is disabled:
```bash
sudo deepin-immutable-writable status
```

If it's active, disable it again:
```bash
sudo deepin-immutable-writable enable
```

#### fprintd service doesn't start
Check service status:
```bash
systemctl status fprintd
```

Review logs:
```bash
journalctl -xe | grep fprint
```

Restart the service:
```bash
sudo systemctl restart fprintd
```

#### Reader not working after installation
1. Verify you've rebooted the system after installation
2. Make sure the drivers were installed correctly:
```bash
ls -la /usr/lib/x86_64-linux-gnu/libfprint-2*
ls -la /usr/lib/x86_64-linux-gnu/libfpcbep.so
```

### Uninstall

If you need to uninstall the driver:

```bash
# Enable writing
sudo deepin-immutable-writable enable

# Remove installed libraries
sudo rm /usr/lib/x86_64-linux-gnu/libfpcbep.so
sudo rm /usr/lib/x86_64-linux-gnu/libfprint-2.so.2*

# Unlock libfprint
echo "libfprint-2-2 install" | sudo dpkg --set-selections

# Reinstall original libfprint
sudo apt reinstall libfprint-2-2

# Reboot
sudo reboot
```

### Additional Notes
- **Important:** Deepin 25 uses an immutable file system. You must always disable immutability before installing or updating the driver.
- **Recommendation:** Always use the original Lenovo driver (download it or use `drivers/original/r1slm02w.zip`). Do not use files in `drivers/modified/fedora-nobara/` as they are specifically adapted for Fedora.
- Original Lenovo scripts work correctly on Deepin 25 since it's based on Debian.
- After each major system update, verify the driver still works.
- Compatible with:
  - ThinkPad E14 Gen 4, E15 Gen 4
  - ThinkBook 13s Gen 4 ARB
  - Other Lenovo models with FPC 10a5:9800 sensor

### References
- [Official Deepin documentation](https://www.deepin.org/)
- [Original Lenovo driver (r1slm02w.zip)](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477)

### Immutable System Information
Deepin 25 implements an immutable root file system for enhanced security and stability. To make system changes, you must:
1. Run `deepin-immutable-writable enable` to disable immutability
2. Reboot the system
3. After rebooting, you can apply changes (install drivers, modify system files, etc.)

The system will remain writable until you manually re-enable immutability with the corresponding command.

### Additional Tools
If you experience issues with Deepin's immutable system, the community has developed useful tools:

- **[immutable-deepin-tools](https://github.com/deepin-espanol/immutable-deepin-tools)** - Tools to manage Deepin's immutable system
  - ⚠️ **Important note:** Third-party, unofficial tool. Use at your own risk.
  - Developed by the Spanish Deepin community
  - May provide additional functionality for working with the immutable system

---

## Español

### Requisitos Previos
- Deepin 25
- Lector de Huellas FPC con ID: 10a5:9800
- Acceso root/sudo

### Instalación

#### 1. Verificar el Lector de Huellas
Primero, confirma que tienes el lector de huellas correcto FPC 10a5:9800:
```bash
lsusb
```
Busca una línea que contenga "10a5:9800" en la salida.

#### 2. Descargar el Driver Original de Lenovo
Descarga el driver FPC FingerPrint Driver (r1slm02w.zip) del sitio web de Lenovo:
[Lenovo FPC Driver Download](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477)

**Alternativa:** El archivo original también está incluido en este repositorio en `drivers/original/r1slm02w.zip` para tu conveniencia.

Descomprime el archivo:
```bash
unzip r1slm02w.zip
```

#### 3. Desactivar la Inmutabilidad del Sistema
Deepin 25 tiene un sistema de archivos inmutable por defecto. Debes desactivarlo para instalar el driver:

**Método oficial:**
```bash
sudo deepin-immutable-writable enable
```

**Herramienta alternativa (usar bajo tu propia responsabilidad):**

Si el método oficial no funciona, existe una herramienta de la comunidad:
- [immutable-deepin-tools](https://github.com/deepin-espanol/immutable-deepin-tools)

⚠️ **Advertencia:** Esta es una herramienta de terceros. Úsala bajo tu propia responsabilidad.

#### 4. Reiniciar el Sistema (Obligatorio)
Después de desactivar la inmutabilidad, es necesario reiniciar:
```bash
sudo reboot
```

⚠️ **Importante:** NO continúes con la instalación sin reiniciar primero.

#### 5. Navegar al Directorio de Instalación
```bash
cd r1slm02w/FPC_driver_linux_27.26.23.39/install_fpc
```

**Nota:** Si descomprimiste desde `drivers/original/r1slm02w.zip`, la ruta será la misma ya que el contenido es idéntico.

#### 6. Instalar el Primer Componente del Driver
```bash
chmod +x install.sh
sudo ./install.sh
```

#### 7. Instalar el Segundo Componente del Driver
```bash
cd ../../FPC_driver_linux_libfprint/install_libfprint
chmod +x install.sh
sudo ./install.sh
```

#### 8. Reiniciar el Sistema (Obligatorio)
Es necesario reiniciar para que los cambios del driver surtan efecto:
```bash
sudo reboot
```

### Configuración

#### En Deepin:
1. Ve a **Centro de Control** → **Cuentas** → **Huella dactilar**
2. Haz clic en **Añadir huella dactilar**
3. Sigue las instrucciones en pantalla para escanear tus huellas dactilares

#### Mediante línea de comandos:
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

#### Error al instalar el driver
Verifica que la inmutabilidad esté desactivada:
```bash
sudo deepin-immutable-writable status
```

Si está activa, desactívala nuevamente:
```bash
sudo deepin-immutable-writable enable
```

#### El servicio fprintd no inicia
Verifica el estado del servicio:
```bash
systemctl status fprintd
```

Revisa los logs:
```bash
journalctl -xe | grep fprint
```

Reinicia el servicio:
```bash
sudo systemctl restart fprintd
```

#### El lector no funciona después de la instalación
1. Verifica que hayas reiniciado el sistema después de la instalación
2. Asegúrate de que los drivers se instalaron correctamente:
```bash
ls -la /usr/lib/x86_64-linux-gnu/libfprint-2*
ls -la /usr/lib/x86_64-linux-gnu/libfpcbep.so
```

### Desinstalar

Si necesitas desinstalar el driver:

```bash
# Activar escritura
sudo deepin-immutable-writable enable

# Eliminar bibliotecas instaladas
sudo rm /usr/lib/x86_64-linux-gnu/libfpcbep.so
sudo rm /usr/lib/x86_64-linux-gnu/libfprint-2.so.2*

# Desbloquear libfprint
echo "libfprint-2-2 install" | sudo dpkg --set-selections

# Reinstalar libfprint original
sudo apt reinstall libfprint-2-2

# Reiniciar
sudo reboot
```

### Notas Adicionales
- **Importante:** Deepin 25 usa un sistema de archivos inmutable. Siempre debes desactivar la inmutabilidad antes de instalar o actualizar el driver.
- **Recomendación:** Usa siempre el driver original de Lenovo (descárgalo o usa `drivers/original/r1slm02w.zip`). No uses los archivos en `drivers/modified/fedora-nobara/` ya que están adaptados específicamente para Fedora.
- Los scripts originales de Lenovo funcionan correctamente en Deepin 25 ya que está basado en Debian.
- Después de cada actualización importante del sistema, verifica que el driver siga funcionando.
- Compatible con:
  - ThinkPad E14 Gen 4, E15 Gen 4
  - ThinkBook 13s Gen 4 ARB
  - Otros modelos Lenovo con sensor FPC 10a5:9800

### Referencias
- [Documentación oficial de Deepin](https://www.deepin.org/)
- [Driver original de Lenovo (r1slm02w.zip)](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds563477)

### Información del Sistema Inmutable
Deepin 25 implementa un sistema de archivos raíz inmutable para mayor seguridad y estabilidad. Para hacer cambios en el sistema, debes:
1. Ejecutar `deepin-immutable-writable enable` para desactivar la inmutabilidad
2. Reiniciar el sistema
3. Después de reiniciar, puedes aplicar los cambios (instalar drivers, modificar archivos del sistema, etc.)

El sistema permanecerá escribible hasta que manualmente reactives la inmutabilidad con el comando correspondiente.

### Herramientas Adicionales
Si experimentas problemas con el sistema inmutable de Deepin, la comunidad ha desarrollado herramientas útiles:

- **[immutable-deepin-tools](https://github.com/deepin-espanol/immutable-deepin-tools)** - Herramientas para gestionar el sistema inmutable de Deepin
  - ⚠️ **Nota importante:** Herramienta de terceros, no oficial. Úsala bajo tu propia responsabilidad.
  - Desarrollada por la comunidad de Deepin en español
  - Puede proporcionar funcionalidades adicionales para trabajar con el sistema inmutable
