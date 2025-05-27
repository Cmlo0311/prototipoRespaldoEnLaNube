# 💾 Sistema de Respaldo Automático en la Nube

Este repositorio contiene un prototipo funcional de un sistema de respaldo automatizado desarrollado para una droguería. Utiliza [Rclone](https://rclone.org/) para sincronizar archivos locales con una nube privada montada en Nextcloud.

---

## 🛠️ Características

- 🗂️ Organización automática de archivos por extensión.
- ☁️ Sincronización inteligente con almacenamiento en la nube (Nextcloud).
- 🗑️ Sistema de papelera de reciclaje con retención configurable.
- 📥 Cliente interactivo para navegar y descargar archivos o carpetas.
- 🧱 Modular: dividido en scripts reutilizables (`main.sh`, `utils.sh`, `respaldo.conf`, etc.)

---

## 🧩 Estructura del Proyecto

```bash
sistemaDeRespaldo/
├── main.sh              # Script principal que organiza y respalda los archivos
├── utils.sh             # Funciones auxiliares como verificación de dependencias
├── config/
│   └── respaldo.conf    # Archivo de configuración con rutas y parámetros
│   └── excluir.txt      # Lista de archivos/patrones a excluir del respaldo
├── cliente_descarga.py  # Script interactivo en Python para descargar desde la nube
├── respaldo.log         # Registro de eventos del respaldo (generado en ejecución)
└── README.md            # Este documento
