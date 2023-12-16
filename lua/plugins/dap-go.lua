return {
  "leoluz/nvim-dap-go",
  config = function()
    require("dap-go").setup({
      delve = {
        args = { "--check-go-version=false" }
      }
    })
  end,
  dependencies = {
    "mfusseneger/nvim-dap",
    "rcarriga/nvim-dap-ui"
  }
}
