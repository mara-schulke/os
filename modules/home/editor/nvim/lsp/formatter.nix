{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [
      biome
      prettierd
      nixfmt-rfc-style
      rustfmt
      shfmt
      yamlfmt
    ];

    plugins.conform-nvim = {
      enable = true;

      lazyLoad.settings = {
        event = [
          "BufReadPre"
          "BufNewFile"
        ];
      };

      settings = {
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };

        notify_on_error = true;

        formatters_by_ft = {
          bash = [ "shfmt" ];
          css = [ "biome" ];
          html = [ "biome" ];
          javascript = [ "biome" ];
          javascriptreact = [ "biome" ];
          markdown = [ "biome" ];
          nix = [ "nixfmt" ];
          rust = [ "rustfmt" ];
          sh = [ "shfmt" ];
          toml = [ "taplo" ];
          typescript = [ "prettierd" ];
          typescriptreact = [ "prettierd" ];
          yaml = [ "yamlfmt" ];
        };
      };
    };
  };
}
