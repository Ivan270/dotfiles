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
.
├── .bashrc             # Configuración del shell base
├── .config/
│   ├── alacritty/      # Emulador de terminal acelerado por GPU (incluye dank-theme)
│   └── nvim/           # Configuración de LazyVim (tema DMS, Obsidian, formateo y linting)
├── .prettierrc         # Reglas globales de Prettier (optimizado para Git y Markdown)
└── .tmux.conf          # Multiplexor con diseño brutalista y responsivo
```

## Dependencias y Requisitos

Antes de aplicar los dotfiles, será necesario asegurarse de tener instalados los siguientes paquetes:

- stow
- Neovim
- Tmux
- Alacritty
- Git

### Instalando dependencias en Fedora

```bash
# 1. Herramientas base del sistema
sudo dnf install stow neovim tmux alacritty git

# 2. Entorno de Node.js (Requerido para Mason, Prettier, ESLint y servidores LSP)
sudo dnf install nodejs npm
# Alternativamente, para usar PNPM: npm install -g pnpm
```

## Tipografía

El entorno requiere JetBrains Mono Nerd Font para renderizar correctamente los íconos técnicos en Alacritty, Tmux y Neovim.

1. Descargar la fuente pre-parcheada desde [Nerd Fonts](https://www.nerdfonts.com/)
2. Descomprimir los archivos `.ttf` en `~/.local/share/fonts/JetBrainsMono/`
3. Ejecutar `fc-cache -fv` para actualizar la caché del sistema.

> [!tip]
> También se puede instalar con el gestor de paquetes `dnf`:
> [Link al paquete](https://packages.fedoraproject.org/pkgs/jetbrains-mono-fonts/jetbrains-mono-fonts-all/)

## Instalación GNU Stow

Al ejecutar Stow desde la raíz de este repositorio, se crearán enlaces simbólicos inteligentes de todos los archivos y carpetas directamente hacia el directorio raíz personal (`~`), fusionando los contenidos de `.config` de manera segura.

```bash
# 1. Clonar el repositorio en tu directorio home
git clone git@github.com:TuUsuario/dotfiles.git ~/dotfiles

# 2. Entrar al directorio
cd ~/dotfiles

# 3. Eliminar configuraciones existentes para evitar conflictos (ejecutar con precaución)
rm ~/.bashrc ~/.tmux.conf
rm -rf ~/.config/alacritty ~/.config/nvim

# 4. Desplegar los enlaces simbólicos en tu directorio raíz
stow -t .
```
