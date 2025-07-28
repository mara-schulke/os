{ lib, ... }:

{
  programs.nixvim = {
    plugins = {
      twilight.enable = true;
      aerial.enable = true;
      lz-n.enable = true;
      indent-o-matic.enable = true;
      web-devicons.enable = true;
      nvim-autopairs.enable = true;
      colorizer.enable = true;
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "tc";
        action = "<cmd>ColorizerToggle<CR>";
        options = {
          desc = "Toggle Colorizer";
          noremap = true;
          silent = true;
        };
      }

      {
        mode = "n";
        key = "tf";
        action = "<cmd>Twilight<CR>";
        options = {
          desc = "Toggle Focus-Mode";
          noremap = true;
          silent = true;
        };
      }

      {
        mode = "n";
        key = "ta";
        action = "<cmd>AerialToggle<CR>";
        options = {
          desc = "Toggle Aerial";
          noremap = true;
          silent = true;
        };
      }
    ];
  };
}
