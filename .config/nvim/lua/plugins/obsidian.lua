return {
    "obsidian-nvim/obsidian.nvim",
    --- modif start ---
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    --- modif end ---
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        ---@module 'obsidian'
        workspaces = {
            {
                name = "Learning",
                path = "~/Dropbox/Obsidian/Learning/",
            },
        },
        -- Sincroniza tus plantillas de Obsidian
        templates = {
            folder = "Plantillas", -- Tu carpeta de plantillas dentro de la bóveda
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            substitutions = {},
        },
        -- Desactivar comandos antiguos ---
        legacy_commands = false,
        frontmatter = {
            enabled = false,
        },
    },
}
