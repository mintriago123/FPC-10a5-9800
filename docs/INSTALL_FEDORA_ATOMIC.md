# Fedora Atomic Installation Guide / Guía de Instalación para Fedora Atomic

> 🌐 **Languages:** [English](#english) | [Español](#español)

---

## English

### ℹ️ What is Fedora Atomic?

Fedora Atomic (also known as Fedora Immutable or OSTree-based) distributions use a read-only, immutable base system. Because of this, the standard driver installation scripts **will not work**. Instead, the `libfprint` package must be replaced using `rpm-ostree`.

This guide covers the **uBlue** family of images built on Fedora Atomic:

| Distribution | Variant | Status |
|---|---|---|
| **Aurora** | Standard | ✅ Tested |
| **Aurora** | DX (Developer Experience) | ✅ Tested |
| **Bluefin** | Standard | ✅ Tested |
| **Bluefin** | DX (Developer Experience) | ✅ Tested |
| **Bazzite** | Standard | ✅ Tested |
| **Bazzite** | DX (Developer Experience) | ✅ Tested |

> ✅ **Compatibility:** The included RPM package (`libfprint-1.94.10-1.lenovo.fc42.x86_64.rpm`) is named after Fedora 42 but works on both **Fedora 42 and Fedora 43** based images.

---

### 📋 Prerequisites

1. Verify your device has the FPC 10a5:9800 sensor:

```bash
lsusb | grep 10a5:9800
```

2. Make sure you have the RPM package. It is located in the repository at:

```
drivers/Fedora Atomic/libfprint-1.94.10-1.lenovo.fc42.x86_64.rpm
```

---

### 🚀 Installation

**Step 1:** Navigate to the directory containing the RPM:

```bash
cd "drivers/Fedora Atomic"
```

**Step 2:** Override the system `libfprint` package with the Lenovo-patched version:

```bash
rpm-ostree override replace libfprint-1.94.10-1.lenovo.fc42.x86_64.rpm
```

**Step 3:** Reboot for the override to take effect:

```bash
systemctl reboot
```

**Step 4 (optional):** Verify the override was applied:

```bash
rpm-ostree status
```

You should see the `libfprint` package listed under overrides.

---

### ⚙️ Post-Installation Setup

**GNOME (Bluefin, Aurora):**
Settings → Users → Fingerprint Login

**KDE (Aurora):**
System Settings → Users → Configure Fingerprint Authentication

**Bazzite:**
- **Desktop mode (KDE):** System Settings → Users → Configure Fingerprint Authentication
- **Desktop mode (GNOME variant):** Settings → Users → Fingerprint Login
- **Big Picture / Game mode** (no DE available):
```bash
fprintd-enroll
```

---

### 🛠️ Troubleshooting

**Device not detected after reboot:**
- Check BIOS/UEFI: make sure the fingerprint reader is enabled
- Disable Secure Boot

**Verify `fprintd` service:**
```bash
systemctl status fprintd
journalctl -xe | grep fprint
```

**Restart the service:**
```bash
sudo systemctl restart fprintd
```

**Roll back the override (if needed):**
```bash
rpm-ostree override reset libfprint
systemctl reboot
```

---

### ℹ️ Technical Notes

- `rpm-ostree override replace` layers the package on top of the base image without modifying it permanently; it is safe and fully reversible.
- The Lenovo-patched `libfprint` (`1.94.10`) adds support for the FPC 10a5:9800 sensor which is absent from upstream releases.
- After a **system image update** (e.g., `ujust update`), the override will be preserved. However, if the base image ships a newer `libfprint` and the versions are incompatible, you may need to re-apply or remove the override.

---

> 🔧 **Override stopped working after a system update?**
> See the [RPM recompilation guide](REBUILD_RPM.md) for step-by-step instructions using Toolbox or Distrobox.

---

## Español

### ℹ️ ¿Qué es Fedora Atomic?

Las distribuciones Fedora Atomic (también conocidas como Fedora Inmutable o basadas en OSTree) usan un sistema base de solo lectura. Por este motivo, los scripts de instalación estándar de drivers **no funcionan**. En su lugar, el paquete `libfprint` debe reemplazarse usando `rpm-ostree`.

Esta guía cubre la familia de imágenes **uBlue** construidas sobre Fedora Atomic:

| Distribución | Variante | Estado |
|---|---|---|
| **Aurora** | Normal | ✅ Probado |
| **Aurora** | DX (Developer Experience) | ✅ Probado |
| **Bluefin** | Normal | ✅ Probado |
| **Bluefin** | DX (Developer Experience) | ✅ Probado |
| **Bazzite** | Normal | ✅ Probado |
| **Bazzite** | DX (Developer Experience) | ✅ Probado |

> ✅ **Compatibilidad:** El paquete RPM incluido (`libfprint-1.94.10-1.lenovo.fc42.x86_64.rpm`) lleva el nombre de Fedora 42, pero funciona tanto en imágenes basadas en **Fedora 42 como en Fedora 43**.

---

### 📋 Requisitos Previos

1. Verifica que tu dispositivo tenga el sensor FPC 10a5:9800:

```bash
lsusb | grep 10a5:9800
```

2. Asegúrate de tener el paquete RPM. Se encuentra en el repositorio en:

```
drivers/Fedora Atomic/libfprint-1.94.10-1.lenovo.fc42.x86_64.rpm
```

---

### 🚀 Instalación

**Paso 1:** Navega al directorio que contiene el RPM:

```bash
cd "drivers/Fedora Atomic"
```

**Paso 2:** Reemplaza el paquete `libfprint` del sistema con la versión parcheada por Lenovo:

```bash
rpm-ostree override replace libfprint-1.94.10-1.lenovo.fc42.x86_64.rpm
```

**Paso 3:** Reinicia para que el reemplazo tome efecto:

```bash
systemctl reboot
```

**Paso 4 (opcional):** Verifica que el reemplazo fue aplicado:

```bash
rpm-ostree status
```

Deberías ver el paquete `libfprint` listado bajo los overrides.

---

### ⚙️ Configuración Post-Instalación

**GNOME (Bluefin, Aurora):**
Configuración → Usuarios → Inicio de sesión con huella dactilar

**KDE (Aurora):**
Configuración del Sistema → Usuarios → Configurar Autenticación por Huella

**Bazzite:**
- **Modo escritorio (KDE):** Configuración del Sistema → Usuarios → Configurar Autenticación por Huella
- **Modo escritorio (variante GNOME):** Configuración → Usuarios → Inicio de sesión con huella dactilar
- **Modo Big Picture / Gaming** (sin entorno de escritorio disponible):
```bash
fprintd-enroll
```

---

### 🛠️ Solución de Problemas

**El dispositivo no aparece tras el reinicio:**
- Verifica BIOS/UEFI: asegúrate de que el lector de huellas esté habilitado
- Deshabilita Secure Boot

**Verificar el servicio `fprintd`:**
```bash
systemctl status fprintd
journalctl -xe | grep fprint
```

**Reiniciar el servicio:**
```bash
sudo systemctl restart fprintd
```

**Revertir el reemplazo (si es necesario):**
```bash
rpm-ostree override reset libfprint
systemctl reboot
```

---

### ℹ️ Notas Técnicas

- `rpm-ostree override replace` superpone el paquete sobre la imagen base sin modificarla permanentemente; es seguro y completamente reversible.
- El `libfprint` parcheado por Lenovo (`1.94.10`) agrega soporte para el sensor FPC 10a5:9800, que no está presente en las versiones upstream.
- Tras una **actualización de la imagen del sistema** (p. ej., `ujust update`), el override se preservará. Sin embargo, si la imagen base incluye una versión más nueva de `libfprint` incompatible, es posible que necesites reaplicar o quitar el override.

---

> 🔧 **¿El override dejó de funcionar tras una actualización del sistema?**
> Consulta la [guía de recompilación del RPM](REBUILD_RPM.md) para instrucciones paso a paso usando Toolbox o Distrobox.
