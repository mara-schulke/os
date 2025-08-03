{ pkgs, ... }:

let
  smartpath = {
    __unkeyed.__raw = ''
      function()
          local max_length = 30
          local filepath = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.')
          local cwd = vim.fn.fnamemodify(vim.fn.getcwd() .. "/", ':~:.')

          if filepath:match("^term://") then
              local num = filepath:match("#toggleterm#(%d+)")
              if num then
                  return "zsh (" .. num .. ")"
              else
                  return "zsh"
              end
          end

          if filepath:match("^oil://") then
              filepath = filepath:gsub("^oil://", "")
              filepath = vim.fn.fnamemodify(filepath, ':~:.')
              filepath = filepath:gsub("^" .. cwd, "")
          end
          
          if not filepath or #filepath <= max_length then
              return filepath or ""
          end
          
          local segments = {}

          for segment in string.gmatch(filepath, "[^/\\]+") do
              table.insert(segments, segment)
          end
          
          local count = #segments
          
          if #filepath <= max_length or count <= 3 then
              return filepath
          end
          
          local abbreviated = segments[1] .. "/../" .. segments[count-1] .. "/" .. segments[count]

          if filepath:match("^/") then
              return "/" .. abbreviated
          end
          
          return abbreviated
      end
    '';
  };
in
{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          icons_enabled = true;
          section_separators = "";
          component_separators = "";
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ smartpath ];
          lualine_c = [
            {
              __unkeyed = "aerial";
            }
            {
              __unkeyed = "diagnostics";
              sources = [ "nvim_diagnostic" ];
              symbols = {
                error = "⊝ ";
                warn = "⚡";
                info = "⊙ ";
                hint = "⟲ ";
              };
            }
          ];
          lualine_x = [ "filetype" ];
        };
        inactive_sections = {
          lualine_a = [ ];
          lualine_b = [ ];
          lualine_c = [ smartpath ];
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
          "fugitive"
        ];
      };
    };
    extraPlugins = with pkgs.vimPlugins; [ lualine-lsp-progress ];
  };
}
