local config = function()
  require("nvim-treesitter.configs").setup({
    indent = {
      enable = true,
    },
    autotag = {
      enable = true
    },
    ensure_installed = {
      "markdown",
      "markdown_inline",
      "json",
      "javascript",
      "typescript",
      "html",
      "css",
      "scss",
      "lua",
      "gitignore",
      "c_sharp",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "regex",
      "sql",
      "xml"
    },
    auto_intall = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true
    }
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  config = config,
  lazy = false,
}
