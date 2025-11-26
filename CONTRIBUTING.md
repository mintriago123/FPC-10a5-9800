# Contributing Guide

> 🌐 **Languages:** [English](#english) | [Español](#español)

---

## English

Thank you for your interest in contributing to this project!

### 🤝 How to Contribute

#### Report Issues

If you find a problem or have a suggestion:

1. Check if a similar issue doesn't exist
2. Create a new issue with relevant information:
   - Linux distribution
   - Kernel version (`uname -r`)
   - Laptop model
   - Output of `lsusb`
   - Error logs (`journalctl -xe | grep fprint`)

#### Add Support for New Distributions

If you want to add support for another distribution:

1. Fork the repository
2. Create a new guide in `docs/INSTALL_[DISTRO].md`
3. Follow the format of existing guides
4. Update the main README
5. Create a Pull Request

#### Template for New Guides

```markdown
# FPC 10a5:9800 Fingerprint Reader - [Distribution] Installation Guide

## Prerequisites
- [Distribution] [version]
- FPC Fingerprint Reader ID: 10a5:9800
- Root/sudo access

## Installation

### 1. Verify Reader
\```bash
lsusb | grep 10a5:9800
\```

### 2. [Distribution-specific steps]

## Configuration

## Troubleshooting

## References
```

### 🧪 Testing Changes

Before submitting a PR, make sure to:

1. ✅ Test installation on target distribution
2. ✅ Verify scripts work correctly
3. ✅ Document any special requirements
4. ✅ Update README if necessary

### 📝 Code Style

**Bash Scripts:**
- Use `set -e` at the beginning
- Add explanatory comments
- Check for common errors
- Messages in English and Spanish

**Documentation:**
- Consistent Markdown format
- Bilingual sections (EN/ES)
- Clear code examples
- Links to official sources

### 💬 Communication

- **Issues:** For reporting issues
- **Pull Requests:** For contributing code
- **Discussions:** For general questions

### 📜 License

By contributing, you agree that your contributions will be licensed under the same license as the original project.

### 🙏 Acknowledgments

All contributors will be acknowledged in the main README.

---

## Español

¡Gracias por tu interés en contribuir a este proyecto!

### 🤝 Cómo Contribuir

#### Reportar Problemas

Si encuentras un problema o tienes una sugerencia:

1. Verifica que no exista un issue similar
2. Crea un nuevo issue con la información relevante:
   - Distribución de Linux
   - Versión del kernel (`uname -r`)
   - Modelo de laptop
   - Salida de `lsusb`
   - Logs de error (`journalctl -xe | grep fprint`)

#### Agregar Soporte para Nuevas Distribuciones

Si deseas agregar soporte para otra distribución:

1. Haz fork del repositorio
2. Crea una nueva guía en `docs/INSTALL_[DISTRO].md`
3. Sigue el formato de las guías existentes
4. Actualiza el README principal
5. Crea un Pull Request

#### Plantilla para Nuevas Guías

```markdown
# Instalación del Lector de Huellas FPC 10a5:9800 - Guía para [Distribución]

## Requisitos Previos
- [Distribución] [versión]
- Lector de Huellas FPC ID: 10a5:9800
- Acceso root/sudo

## Instalación

### 1. Verificar el Lector
\```bash
lsusb | grep 10a5:9800
\```

### 2. [Pasos específicos de la distribución]

## Configuración

## Solución de Problemas

## Referencias
```

### 🧪 Probar Cambios

Antes de enviar un PR, asegúrate de:

1. ✅ Probar la instalación en la distribución objetivo
2. ✅ Verificar que los scripts funcionan correctamente
3. ✅ Documentar cualquier requisito especial
4. ✅ Actualizar el README si es necesario

### 📝 Estilo de Código

**Scripts Bash:**
- Usar `set -e` al inicio
- Agregar comentarios explicativos
- Verificar errores comunes
- Mensajes en inglés y español

**Documentación:**
- Formato Markdown consistente
- Secciones bilingües (ES/EN)
- Ejemplos de código claros
- Enlaces a fuentes oficiales

### 💬 Comunicación

- **Issues:** Para reportar problemas
- **Pull Requests:** Para contribuir código
- **Discussions:** Para preguntas generales

### 📜 Licencia

Al contribuir, aceptas que tus contribuciones se licenciarán bajo la misma licencia que el proyecto original.

### 🙏 Agradecimientos

Todos los contribuidores serán reconocidos en el README principal.

---

**Thank you for helping improve this project!**
**¡Gracias por ayudar a mejorar este proyecto!**
