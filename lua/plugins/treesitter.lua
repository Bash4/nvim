-- Treesitter: Advanced syntax highlighting and code parsing for improved syntax awareness and code navigation
return {
 "nvim-treesitter/nvim-treesitter",
 build = ":TSUpdate",
 config = function()
   local configs = require("nvim-treesitter.configs")
   configs.setup({
     -- A list of parser names, or "all"
     ensure_installed = {
       -- Core languages
       "c",
       "lua", 
       "vim",
       "vimdoc",
       "query",

       -- Web development
       "html",
       "css",
       "javascript",
       "typescript",
       "tsx", -- React
       "json",
       "yaml",
       "php",
       "go",
       "python",
       "ruby",

       -- Web Frameworks
       "vue",
       "svelte",
       "angular",

       -- Markup/Style
       "scss",
       "markdown",
       "xml",

       -- Backend/Server
       "java",
       "sql",
       "prisma",
       "dockerfile",
       "graphql",

       -- Config files
       "toml",
       "ini",
       "regex",
     },

     -- Install parsers synchronously (only applied to `ensure_installed`)
     sync_install = false,

     -- Automatically install missing parsers when entering buffer
     auto_install = true,

     highlight = {
       enable = true,
       -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
       additional_vim_regex_highlighting = false,
     },

     indent = {
       enable = true
     },

     -- Optional: Enable incremental selection
     incremental_selection = {
       enable = true,
       keymaps = {
         init_selection = "gnn", -- set to `false` to disable one of the mappings
         node_incremental = "grn",
         scope_incremental = "grc",
         node_decremental = "grm",
       },
     },
   })
 end,
}
