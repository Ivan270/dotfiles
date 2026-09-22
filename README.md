# Dotfiles

Mis archivos para mi propio entorno de desarrollo, optimizado para el desarrollo web (JS/Vue) y la gestión de conocimiento (Obsidian). Construido sobre **Dank Linux (Fedora)** y gestionado con **GNU Stow**.

## Herramientas Principales

- **Tipografía Base:** JetBrains Mono Nerd Font para ligaduras de código e iconografía limpia en la terminal.
- **Editor:** [LazyVim](https://www.lazyvim.org/) (Neovim).
  - Integración nativa con `obsidian.nvim` (Frontmatter automatizado apagado para evitar colisiones de sintaxis YAML).
  - Formateo automático al guardar mediante `conform.nvim`.
  - Corrección ortográfica bilingüe (ES/EN) nativa.
- **Multiplexor:** Tmux.
  - Diseño brutalista sin bordes ni separadores invasivos.
  - Barra de estado dinámica que hereda nativamente los códigos de color del emulador de terminal.
  - Indicadores visuales de estado (Modo Comando) basados puramente en bloques de color sólido para reducir el ruido visual.
  - Soporte completo para True Color (Tc) y diagnósticos LSP (undercurls).
- **Formato Global:** Reglas centralizadas de Prettier (`.prettierrc`) optimizadas para mantener historiales de Git limpios (`trailingComma: "all"`, `singleQuote: true`) con reglas de sobrescritura estrictas para proteger la legibilidad de Markdown.

## Estructura del Repositorio

Este entorno utiliza `stow` para desplegar la configuración creando enlaces simbólicos exactos hacia el directorio raíz (`~`), manteniendo el control de versiones completamente aislado.

```text
~/dotfiles/
├── nvim/           # .config/nvim (LazyVim)
├── tmux/           # .tmux.conf
├── prettier/       # .prettierrc globalio entorno de desarrollo, optimizado para el desarrollo web (JS/Vue) y la gestión de conocimiento (Obsidian).
```
