return {
    "mfussenegger/nvim-lint",
    opts = {
        -- Sobreescribe los eventos por defecto de LazyVim
        events = { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged", "TextChangedI" },
    },
}
