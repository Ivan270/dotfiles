# Dotfiles

Mis archivos para desarrollo web (JS/Vue) y gestión de conocimiento (Obsidian), gestionados con **GNU Stow**. Fedora (Dank Linux) usa Bash/Alacritty; macOS usa Zsh/Ghostty. Ambos comparten Neovim, Tmux, Starship y las reglas de formato.

## Herramientas Principales

- **Tipografía Base:** JetBrains Mono Nerd Font para ligaduras de código e iconografía limpia en la terminal.
- **Editor:** [LazyVim](https://www.lazyvim.org/) (Neovim).
  - Tema estable `tokyonight-night` en ambos equipos, independiente de Dank.
  - Integración nativa con `obsidian.nvim` (Frontmatter automatizado apagado para evitar colisiones de sintaxis YAML).
  - Formateo automático al guardar mediante `conform.nvim`.
  - Corrección ortográfica bilingüe (ES/EN) nativa.
  - Renderizado de Markdown dentro del editor con `render-markdown.nvim`: encabezados, listas, tablas y bloques de código, con el atajo `<leader>um` para alternar la vista.
- **Prompt:** [Starship](https://starship.rs/), con dos líneas, colores discretos para fondos oscuros e información contextual de desarrollo y DevOps. Configuración comentada en español en [`starship/.config/starship.toml`](starship/.config/starship.toml).
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
├── alacritty/.config/alacritty/  # Terminal; Dank genera el tema localmente
├── bash/.bashrc                 # Bash; incluye la inicialización de Starship
├── ghostty/.config/ghostty/config # Terminal de macOS
├── global/                     # .prettierrc y .markdownlint.json
├── nvim/.config/nvim/           # LazyVim y plugins
├── scripts/dotfiles             # Despliegue por perfil o paquete
├── starship/.config/starship.toml # Prompt compartido entre macOS y Fedora
├── tmux/.tmux.conf              # Configuración de Tmux
└── zsh/.zshrc                   # Zsh, Oh My Zsh y Starship
```

Cada directorio de aplicación es un paquete de Stow. `scripts/` contiene herramientas del repositorio y no se despliega. Por ejemplo, `starship` enlaza su configuración en `~/.config/starship.toml`.

| Perfil | Paquetes |
| --- | --- |
| `common` | `global`, `nvim`, `starship`, `tmux` |
| `fedora` | Compartidos + `bash`, `alacritty` |
| `macos` | Compartidos + `zsh`, `ghostty` |

## Dependencias y Requisitos

Antes de aplicar los dotfiles, será necesario asegurarse de tener instalados los siguientes paquetes:

- stow
- Neovim
- Tmux
- Alacritty
- Git
- Starship
- JetBrains Mono Nerd Font instalada y seleccionada en la terminal
- Para la hora a la derecha en Bash: ble.sh 0.4 o superior

### Instalando dependencias en Fedora

```bash
# 1. Herramientas base del sistema
sudo dnf install stow neovim tmux alacritty git

# 2. Entorno de Node.js (Requerido para Mason, Prettier, ESLint y servidores LSP)
sudo dnf install nodejs npm
# Alternativamente, para usar PNPM: npm install -g pnpm
```

### Instalando Starship

En Fedora, la [guía oficial de Starship](https://starship.rs/guide/#step-1-install-starship) ofrece el repositorio COPR `atim/starship`:

```bash
sudo dnf copr enable atim/starship
sudo dnf install starship
```

En macOS, con Homebrew instalado:

```bash
brew install stow starship neovim tmux node ripgrep fd uv
brew install --cask ghostty font-jetbrains-mono-nerd-font
```

Zsh conserva la integración con [Oh My Zsh](https://ohmyz.sh/). Para reproducirla instala también sus plugins externos `zsh-autosuggestions` y `zsh-syntax-highlighting` en `${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/`, siguiendo sus instrucciones oficiales. Si Oh My Zsh no está instalado, se usan las completaciones básicas de Zsh y Starship. Las integraciones con `uv` y Starship solo se cargan si están instalados.

Para Neovim, instala también `ripgrep`, `fd` y un compilador C (en Fedora: `sudo dnf install ripgrep fd-find gcc make`; en macOS: las Command Line Tools de Xcode). Ejecuta `:checkhealth` para comprobar las dependencias de los extras que utilices. Stow y el script no instalan aplicaciones ni plugins del shell.

## Tipografía

El entorno requiere JetBrains Mono Nerd Font para renderizar correctamente los íconos técnicos en Alacritty, Ghostty, Starship, Tmux y Neovim. Selecciona la variante **Nerd Font** en las preferencias de la terminal.

En Fedora:

1. Descargar la fuente pre-parcheada desde [Nerd Fonts](https://www.nerdfonts.com/)
2. Descomprimir los archivos `.ttf` en `~/.local/share/fonts/JetBrainsMono/`
3. Ejecutar `fc-cache -fv` para actualizar la caché del sistema.

En macOS, abre los archivos `.ttf` con Catálogo Tipográfico e instala la fuente; después selecciónala en Ghostty. La variante estándar de JetBrains Mono no incluye todos los iconos de Nerd Fonts.

## Instalación GNU Stow

Desde la raíz del repositorio, selecciona los paquetes que quieres enlazar en tu directorio personal (`~`). Stow no instala las herramientas: instala primero las dependencias correspondientes.

```bash
# Si todavía no tienes el repositorio, clónalo en ~/dotfiles.
git clone git@github.com:Ivan270/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Simular el despliegue en Fedora y revisar posibles conflictos.
./scripts/dotfiles check --profile fedora

# Desplegar los paquetes cuando se hayan resuelto los conflictos.
./scripts/dotfiles apply --profile fedora

# En el Mac:
./scripts/dotfiles check --profile macos
./scripts/dotfiles apply --profile macos
```

Sin `--profile` ni `--package`, el script detecta Fedora o macOS. Usa `--target DIRECTORIO` para probar en otro directorio existente. Es compatible con Bash 3.2 de macOS.

El despliegue usa `--restow --no-folding`: los directorios de destino son reales y cada archivo de configuración es un enlace. Así, los archivos generados por las aplicaciones permanecen fuera del repositorio. Se excluyen temas generados, `.DS_Store` y archivos temporales tanto de Git como de Stow.

Si ya existen archivos o carpetas en los destinos, respáldalos fuera de esas rutas antes de repetir el despliegue. No es necesario borrar tus configuraciones.

Para instalar **solo el prompt**, tanto en macOS como en Fedora:

```bash
cd ~/dotfiles
./scripts/dotfiles check --package starship
./scripts/dotfiles apply --package starship
```

Puedes repetir `--package`, por ejemplo `--package tmux --package starship`. No se combina con `--profile`.

### Actualizar un dotfile

Edita el archivo en este repositorio o mediante su enlace en `$HOME`, revisa `git diff` y realiza `commit/push`. En el otro equipo:

```bash
git pull --ff-only
tmux source-file ~/.tmux.conf  # Si cambió Tmux y tienes una sesión abierta.
```

Para modificaciones de contenido, los enlaces existentes ya reflejan los cambios. Si se añaden, eliminan o mueven archivos, vuelve a desplegar el paquete:

```bash
./scripts/dotfiles check --package tmux
./scripts/dotfiles apply --package tmux
```

Reabre Neovim o la terminal para cargar sus cambios. Mantén `lazy-lock.json` y `lazyvim.json` versionados; tras sincronizar, `:Lazy restore` restaura las versiones del lockfile. Usa `:Lazy update` cuando quieras actualizar plugins deliberadamente y revisa/commitea el lockfile resultante.

### Migrar desde la estructura anterior

El primer `apply` convierte los enlaces de directorios completos en enlaces por archivo. Antes de actualizar, respalda cualquier archivo local creado dentro de esos directorios, en particular `~/.config/alacritty/dank-theme.toml`, fuera del repositorio. Tras `apply`, devuelve el tema a esa ruta: debe ser un archivo local, no un enlace al repositorio.

En macOS, Ghostty se instala ahora en `~/.config/ghostty/config` (antes el paquete contenía `ghostty/config.ghostty`, que Stow habría enlazado incorrectamente como `~/config.ghostty`). Revisa y retira ese enlace antiguo si existe. Respalda también cualquier configuración previa en `~/.config/ghostty/` y `~/Library/Application Support/com.mitchellh.ghostty/`; evita mantener una segunda configuración activa que sobrescriba la del repositorio. El script informa de conflictos con archivos existentes sin adoptarlos ni sobrescribirlos.

### Dank después de reinstalar Fedora

1. Instala DankMaterialShell con tu entorno de escritorio y aplica el perfil `fedora`.
2. Activa la integración de colores de Alacritty en Dank y regenera el tema al seleccionar tu fondo/colores.
3. Comprueba que se haya creado `~/.config/alacritty/dank-theme.toml`.

Alacritty importa ese archivo si existe; si falta, utiliza sus colores predeterminados. El tema generado no se versiona. Neovim usa Tokyo Night y no necesita la integración de Neovim de Dank; puedes desactivarla en sus ajustes. Los archivos DMS que regenere quedan locales y no se despliegan con Stow. Los ajustes completos del escritorio Dank y el fondo de pantalla no se respaldan con este repositorio.

### Reglas globales de formato

Prettier usa `printWidth: 80` y conserva los saltos de los párrafos Markdown con `proseWrap: "preserve"`. `~/.prettierrc` y `~/.markdownlint.json` proporcionan reglas de respaldo para proyectos bajo tu directorio personal cuando sus herramientas las descubren; los proyectos con configuración propia controlan sus reglas. No guardes configuración de proyectos particulares en estos archivos globales.

## Markdown en LazyVim

La configuración de [`render-markdown.nvim`](https://github.com/MeanderingProgrammer/render-markdown.nvim) está en [`nvim/.config/nvim/lua/plugins/render-markdown.lua`](nvim/.config/nvim/lua/plugins/render-markdown.lua). El plugin mejora la visualización de Markdown dentro de Neovim sin modificar el contenido del archivo. Se carga al abrir Markdown, ejecutar `:RenderMarkdown` o utilizar el atajo configurado.

### Instalación y requisitos

Después de desplegar el paquete `nvim` con Stow, abre Neovim y ejecuta:

```vim
:Lazy install
:TSInstall markdown markdown_inline
```

Espera a que finalice la instalación y reinicia Neovim. Los parsers `markdown` y `markdown_inline` son necesarios para el renderizado. La configuración reutiliza `mini.icons` para los iconos y requiere la Nerd Font indicada en la sección de tipografía.

La versión del plugin queda registrada en [`lazy-lock.json`](nvim/.config/nvim/lazy-lock.json); conserva sus cambios junto con la configuración para reproducir la instalación en otros equipos.

### Uso

Abre un archivo Markdown, por ejemplo `README.md`, y utiliza:

| Acción | Atajo o comando |
| --- | --- |
| Alternar el renderizado | `<leader>um` (Espacio → u → m en modo normal) |
| Activar | `:RenderMarkdown enable` |
| Desactivar | `:RenderMarkdown disable` |
| Alternar mediante comando | `:RenderMarkdown toggle` |

Con las opciones predeterminadas, el plugin deja ver la sintaxis original al editar y en los elementos bajo el cursor para facilitar los cambios. Para personalizar su apariencia, añade opciones a `opts` en `render-markdown.lua`.

## Configuración de Starship

El archivo [`starship/.config/starship.toml`](starship/.config/starship.toml) define un prompt de dos líneas con iconos de Nerd Fonts. La primera muestra el contexto; la segunda deja espacio para escribir comandos y muestra la hora a la derecha cuando el shell lo permite.

### Activación del shell

En **Fedora con Bash**, el archivo [`bash/.bashrc`](bash/.bashrc) ya incluye la inicialización. Si instalas únicamente el paquete `starship`, añade esta línea una sola vez al final de tu `~/.bashrc`:

```bash
eval "$(starship init bash)"
```

En **macOS con Zsh**, añade esta línea una sola vez al final de tu `~/.zshrc`:

```zsh
eval "$(starship init zsh)"
```

Abre una terminal nueva para cargar la inicialización. Estos pasos siguen la [guía de configuración del shell de Starship](https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship).

### Información del prompt

| Elemento | Comportamiento |
| --- | --- |
| Equipo y sesión | Hostname siempre visible; usuario e indicador de conexión en SSH. El usuario también aparece como root o cuando difiere del usuario de sesión. |
| Directorio | Ruta completa desde la raíz del repositorio; fuera de Git, últimos tres niveles. Un candado indica que no hay permiso de escritura. |
| Git | Rama, estado de archivos, stash, commits por subir/bajar y operaciones como merge o rebase. En HEAD separado, muestra el hash corto. |
| Node.js | Versión del runtime en directorios con indicadores de JavaScript/TypeScript, Node o pnpm. |
| Python | Versión del Python disponible en PATH y nombre del entorno virtual activo; reconoce proyectos con `uv.lock`. |
| Docker | Contexto en directorios con archivos Docker/Compose/Containerfile o carpeta `.devcontainer`. |
| Kubernetes | Contexto y namespace explícito en directorios con indicadores como `Chart.yaml`, `kustomization.yaml`, `.k8s` o carpeta `k8s`. |
| Duración | Tiempo del último comando a partir de dos segundos. |
| Hora | Hora local en formato `HH:MM`, al dibujar el prompt. |

Los detectores de archivos y carpetas operan sobre el directorio actual; no se heredan automáticamente a subdirectorios. Docker oculta los contextos `default` y `desktop-linux` salvo overrides como `DOCKER_CONTEXT`. Kubernetes requiere un contexto configurado en kubeconfig; puedes marcar un directorio creando un archivo vacío `.k8s`.

pnpm y uv ayudan a detectar proyectos, pero el prompt muestra las versiones de Node.js y Python, no las de sus gestores. Una carpeta `.venv` existente no significa que esté activada: para mostrar el entorno, actívalo con `source .venv/bin/activate`.

### Indicadores de Git

| Indicador | Significado |
| --- | --- |
| `+N` | Archivos preparados para commit |
| `!N` | Archivos modificados |
| `?N` | Archivos sin seguimiento |
| `×N` | Archivos eliminados |
| `»N` | Archivos renombrados |
| `~N` | Cambios de tipo de archivo |
| `=N` | Archivos en conflicto |
| `≡N` | Entradas en stash |
| `↑N` / `↓N` | Commits por subir / bajar respecto al upstream |

Los indicadores de archivos pueden solaparse y no cuentan líneas. La divergencia usa las referencias locales; el prompt no ejecuta `git fetch`.

### Hora a la derecha y personalización

La hora se configura mediante `right_format = '$time'`. **Zsh lo soporta directamente; Bash requiere ble.sh 0.4 o superior**, instalado e integrado con Starship. El repositorio no instala ni carga ble.sh. Consulta la [documentación del Right Prompt](https://starship.rs/advanced-config/#enable-right-prompt).

Para mantener la hora visible en Bash sin ble.sh, cambia `right_format` a `''` y añade `$time` antes de `$line_break` en `format`. Si prefieres alinearla al extremo derecho de la primera línea, añade `$fill$time` en esa posición.

Cada ajuste está comentado en español dentro del TOML. Para simplificar el prompt, elimina del `format` la variable del módulo que no necesites; para mostrar el hostname solo en SSH, cambia `ssh_only` a `true` en `[hostname]`. Los colores están centralizados en `[palettes.discreta]`.
