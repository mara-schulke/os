{ ... }:

{
  programs.nixvim = {
    extraConfigLua = ''
      vim.fn.sign_define("DiagnosticSignError", {
        texthl = "DiagnosticSignError",
        text = "E",
        numhl = "DiagnosticSignError",
      })

      vim.fn.sign_define("DiagnosticSignWarn", {
        texthl = "DiagnosticSignWarn",
        text = "W",
        numhl = "DiagnosticSignWarn",
      })

      vim.fn.sign_define("DiagnosticSignInfo", {
        texthl = "DiagnosticSignInfo",
        text = "I",
        numhl = "DiagnosticSignInfo",
      })

      vim.fn.sign_define("DiagnosticSignHint", {
        texthl = "DiagnosticSignHint",
        text = "H",
        numhl = "DiagnosticSignHint",
      })

      vim.diagnostic.config({
        underline = true,
        virtual_text = {
          prefix = ">",
          spacing = 2,
          source = "always",
        },
        signs = true,
        update_in_insert = false,
        severity_sort = true,
      })
    '';
  };
}
