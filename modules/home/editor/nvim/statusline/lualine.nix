{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          icons_enabled = false;
          section_separators = "";
          component_separators = "";
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            {
              __unkeyed-1 = "filename";
              file_status = true;
              path = 1;
            }
          ];
          lualine_c = [
            {
              __unkeyed-1 = "diff";
              symbols = {
                added = "+ ";
                modified = "= ";
                removed = "- ";
              };
            }
            {
              __unkeyed-1 = "diagnostics";
              sources = [ "nvim_diagnostic" ];
              symbols = {
                error = "E ";
                warn = "W ";
                info = "I ";
                hint = "H ";
              };
            }
          ];
          lualine_x = [ "filetype" ];
        };
        inactive_sections = {
          lualine_a = [ ];
          lualine_b = [ ];
          lualine_c = [
            {
              __unkeyed-1 = "filename";
              path = 1;
            }
          ];
          lualine_x = [ "location" ];
          lualine_y = [ ];
          lualine_z = [ ];
        };
        tabline = {
          lualine_a = [
            {
              __unkeyed-1.__raw = ''
                function()
                  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
                end
              '';
              icon = "";
            }
          ];
          lualine_b = [
            {
              __unkeyed-1 = "tabs";
              mode = 2;
              separator = "nil";
              padding = 1;
            }
          ];
          lualine_z = [
            {
              __unkeyed-1 = "branch";
              icon = "";
            }
          ];
        };
        extensions = [
          "fzf"
          "toggleterm"
          "fugitive"
        ];
      };
    };
    extraPlugins = with pkgs.vimPlugins; [ lualine-lsp-progress ];
  };
}
