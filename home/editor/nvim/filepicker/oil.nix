{ lib, ... }:

{
  programs.nixvim = {
    plugins.oil = {
      enable = true;

      settings = {
        columns = [ "icon" ];

        view_options = {
          show_hidden = true;
        };
      };
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "<C-e>";
        action = "<CMD>Oil<CR>";
        options = {
          desc = "Open directory";
        };
      }
      {
        mode = "n";
        key = "_";
        action = "<CMD>Oil<CR>_";
        options = {
          desc = "Open root of project";
        };
      }
    ];
  };
}
