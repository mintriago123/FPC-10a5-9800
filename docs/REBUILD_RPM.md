# Recompiling the RPM for Fedora Atomic / Recompilar el RPM para Fedora Atomic

[![Fedora Atomic](https://img.shields.io/badge/Fedora%20Atomic%20(uBlue)-Advanced-51A2DA.svg?logo=fedora)](INSTALL_FEDORA_ATOMIC.md)

> 🌐 **Languages:** [English](#english) | [Español](#español)

---

## English

> ⚠️ **This guide is only needed if the pre-built RPM stops working** after a base image update (e.g., ABI change in a future Fedora release).
>
> If `rpm-ostree override replace libfprint-1.94.10-1.lenovo.fc42.x86_64.rpm` still works on your system, **you do not need this guide**. Go back to the [standard installation guide](INSTALL_FEDORA_ATOMIC.md).

### Why recompile?

The pre-built RPM targets Fedora 42/43. If a future base image update introduces an incompatible `libfprint` version or ABI change, the override may fail with a conflict. Recompiling against the new Fedora release resolves this.

### Prerequisites

Because Fedora Atomic is immutable, build tools are not available on the host by default. The recommended approach is to use **Toolbox** (included by default on all uBlue images) or **Distrobox**.

---

### Step 1 — Enter a Fedora build container

```bash
# Using Toolbox (recommended, included by default)
toolbox create --distro fedora --release 42   # or 43/44/..., match your base image
toolbox enter fedora-toolbox-42

# --- OR using Distrobox ---
distrobox create --name fedora-build --image fedora:42
distrobox enter fedora-build
```

### Step 2 — Install build tools inside the container

```bash
sudo dnf install -y rpm-build rpmdevtools
```

### Step 3 — Set up the build tree and copy sources

Run this from inside the container. Toolbox/Distrobox mount your home directory automatically, so the repository is accessible:

```bash
# Adjust the path to where you cloned the repository
REPO="$HOME/FPC-10a5-9800"

rpmdev-setuptree   # creates ~/rpmbuild/{SPECS,SOURCES,BUILD,RPMS,SRPMS}

cp -r "$REPO/rpmbuild/SOURCES/fpc" ~/rpmbuild/SOURCES/
cp "$REPO/rpmbuild/SPECS/libfprint.spec" ~/rpmbuild/SPECS/
```

### Step 4 — Adjust the `Release` tag (if needed)

Open the spec file and update the `Release` line to match the target Fedora version:

```bash
nano ~/rpmbuild/SPECS/libfprint.spec
```

Change:
```spec
Release: 1.lenovo%{?dist}
```
To (example for Fedora 44):
```spec
Release: 1.lenovo.fc44
```

> You can also leave `%{?dist}` and let `rpmbuild` resolve it automatically based on the container's Fedora release.

### Step 5 — Build the RPM

```bash
rpmbuild -bb ~/rpmbuild/SPECS/libfprint.spec
```

The resulting RPM will be at:
```
~/rpmbuild/RPMS/x86_64/libfprint-1.94.10-1.lenovo.fcXX.x86_64.rpm
```

### Step 6 — Apply the new RPM on the host

Exit the container and apply the freshly built package:

```bash
exit   # leave toolbox/distrobox

# Reset any existing override first
rpm-ostree override reset libfprint

# Apply the new one (adjust the filename to match the actual version)
rpm-ostree override replace ~/rpmbuild/RPMS/x86_64/libfprint-1.94.10-1.lenovo.fcXX.x86_64.rpm

systemctl reboot
```

---

## Español

> ⚠️ **Esta guía solo es necesaria si el RPM precompilado deja de funcionar** tras una actualización de la imagen base (p. ej., cambio de ABI en una futura versión de Fedora).
>
> Si `rpm-ostree override replace libfprint-1.94.10-1.lenovo.fc42.x86_64.rpm` sigue funcionando en tu sistema, **no necesitas esta guía**. Vuelve a la [guía de instalación estándar](INSTALL_FEDORA_ATOMIC.md).

### ¿Por qué recompilar?

El RPM precompilado está diseñado para Fedora 42/43. Si una futura actualización de la imagen base introduce una versión de `libfprint` o un ABI incompatible, el override puede fallar con un conflicto. Recompilar contra la nueva versión de Fedora resuelve el problema.

### Requisitos Previos

Como Fedora Atomic es inmutable, las herramientas de compilación no están disponibles en el host por defecto. El enfoque recomendado es usar **Toolbox** (incluido por defecto en todas las imágenes uBlue) o **Distrobox**.

---

### Paso 1 — Entrar en un contenedor Fedora para compilar

```bash
# Usando Toolbox (recomendado, incluido por defecto)
toolbox create --distro fedora --release 42   # o 43/44/..., debe coincidir con la imagen base
toolbox enter fedora-toolbox-42

# --- O usando Distrobox ---
distrobox create --name fedora-build --image fedora:42
distrobox enter fedora-build
```

### Paso 2 — Instalar herramientas de compilación dentro del contenedor

```bash
sudo dnf install -y rpm-build rpmdevtools
```

### Paso 3 — Preparar el árbol de compilación y copiar las fuentes

Ejecuta esto desde dentro del contenedor. Toolbox/Distrobox montan tu directorio home automáticamente, por lo que el repositorio es accesible:

```bash
# Ajusta la ruta a donde clonaste el repositorio
REPO="$HOME/FPC-10a5-9800"

rpmdev-setuptree   # crea ~/rpmbuild/{SPECS,SOURCES,BUILD,RPMS,SRPMS}

cp -r "$REPO/rpmbuild/SOURCES/fpc" ~/rpmbuild/SOURCES/
cp "$REPO/rpmbuild/SPECS/libfprint.spec" ~/rpmbuild/SPECS/
```

### Paso 4 — Ajustar la etiqueta `Release` (si es necesario)

Abre el spec y actualiza la línea `Release` para que coincida con la versión de Fedora objetivo:

```bash
nano ~/rpmbuild/SPECS/libfprint.spec
```

Cambia:
```spec
Release: 1.lenovo%{?dist}
```
A (ejemplo para Fedora 44):
```spec
Release: 1.lenovo.fc44
```

> También puedes dejar `%{?dist}` y dejar que `rpmbuild` lo resuelva automáticamente según la versión de Fedora del contenedor.

### Paso 5 — Compilar el RPM

```bash
rpmbuild -bb ~/rpmbuild/SPECS/libfprint.spec
```

El RPM resultante estará en:
```
~/rpmbuild/RPMS/x86_64/libfprint-1.94.10-1.lenovo.fcXX.x86_64.rpm
```

### Paso 6 — Aplicar el nuevo RPM en el host

Sal del contenedor y aplica el paquete recién compilado:

```bash
exit   # salir de toolbox/distrobox

# Quitar el override existente primero
rpm-ostree override reset libfprint

# Aplicar el nuevo (ajusta el nombre del archivo a la versión real)
rpm-ostree override replace ~/rpmbuild/RPMS/x86_64/libfprint-1.94.10-1.lenovo.fcXX.x86_64.rpm

systemctl reboot
```
