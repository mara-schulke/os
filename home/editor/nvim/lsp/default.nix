{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./completions.nix
    ./diagnostics.nix
  ];

  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          clangd = {
            enable = true;
            filetypes = [
              "c"
              "cpp"
              "objc"
              "objcpp"
              "cuda"
              "hpp"
            ];
          };

          nixd = {
            enable = true;
            settings =
              #let
              #  flake = ''(builtins.getFlake "github:mara-schulke/os)""'';
              #in
              #  nixpkgs = {
              #    expr = "import ${flake}.inputs.nixpkgs { }";
              #  };
              {
                formatting = {
                  command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
                };
                options = {
                  #nixos.expr = ''${flake}.nixosConfigurations.default.options'';
                  nixpkgs.expr = "import <nixpkgs> { }";
                };
              };
          };

          cssls.enable = true;
          eslint.enable = true;
          gopls.enable = true;
          html.enable = true;
          lua_ls.enable = true;
          markdown_oxide.enable = true;
          pyright.enable = true;
          tailwindcss.enable = true;
          terraformls.enable = true;
          ts_ls.enable = true;

          yamlls = {
            enable = true;
            settings = {
              schemaStore = {
                enable = false;
                url = "";
              };
            };
          };
        };
      };

      none-ls = {
        enable = true;
        enableLspFormat = true;
        settings = {
          should_attach = ''
            function(bufnr)
              return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
            end
          '';
        };
        sources = {
          completion = {
            spell.enable = true;
          };

          formatting = {
            prettier.enable = true;
            prettier.disableTsServerFormatter = true;
            black.enable = true;
            mdformat.enable = true;
            isort.enable = true;
            sqlfluff.enable = true;
          };

          diagnostics = {
            protolint.enable = true;
          };
        };
      };

      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      lspkind.enable = true;

      lspsaga = {
        enable = true;
        lightbulb.virtualText = false;
        ui = {
          codeAction = "";
        };
        definition = {
          keys = {
            edit = "<CR>";
            vsplit = "v";
            split = "h";
            tabe = "t";
            quit = "q";
            # close = "k";
          };
        };
      };

      trouble.enable = true;

      rustaceanvim = {
        enable = true;
        settings = {
          server = {
            cmd = [ "rust-analyzer" ];
            default_settings = {
              rust-analyzer = {
                check = {
                  command = "clippy";
                };
                inlayHints = {
                  enable = "always";

                  lifetimeElisionHints = {
                    enable = "always";
                  };
                };
              };
            };
            standalone = false;
          };
        };
      };
      crates.enable = true;
      fidget.enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "gh";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      }
      #{
      #mode = "n";
      #key = "g";
      #action = ":Lspsaga outline<cr>";
      #}
      {
        mode = "n";
        key = "g?";
        action = ":Trouble toggle diagnostics<CR>";
      }
      {
        mode = "n";
        key = "gf";
        action = "<cmd> lua vim.diagnostic.open_float(nil, {focusable=false, source='always', border='rounded'})<cr>";
      }
      {
        mode = "n";
        key = "gj";
        action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
      }
      {
        mode = "n";
        key = "gk";
        action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
      }
      {
        mode = "n";
        key = "ga";
        # action = "<cmd> lua vim.lsp.buf.code_action()<cr>";
        action = ":Lspsaga code_action<cr>";
      }
      {
        mode = "n";
        key = "gd";
        # action = "<cmd>lua require('telescope.builtin').lsp_definitions({})<cr>";
        action = ":Lspsaga goto_definition<cr>";
        # action = ":Lspsaga peek_definition<cr>";
      }
      {
        mode = "n";
        key = "gi";
        # action = "<cmd>lua require('telescope.builtin').lsp_implementations({})<cr>";
        action = ":Lspsaga finder imp<cr>";
      }
      {
        mode = "n";
        key = "gp";
        # action = "<cmd>lua require('telescope.builtin').lsp_type_definitions({})<cr>";
        # action = ":Lspsaga goto_type_definition<cr>";
        action = ":Lspsaga peek_type_definition<cr>";
      }
      {
        mode = "n";
        key = "gf";
        action = "<cmd>lua require('telescope.builtin').lsp_references({})<cr>";
      }
      {
        mode = "n";
        key = "ge";
        action = "<cmd>lua require('telescope.builtin').diagnostics({})<cr>";
      }
      #{
      #mode = "n";
      #key = "<leader>so";
      ## action = "<cmd>lua require('telescope.builtin').lsp_outgoing_calls({})<cr>";
      #action = ":Lspsaga outgoing_calls<cr>";
      #}
      #{
      #mode = "n";
      #key = "gii";
      ## action = "<cmd>lua require('telescope.builtin').lsp_incoming_calls({})<cr>";
      #action = ":Lspsaga incoming_calls<cr>";
      #}
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.rename()<cr>";
      }
    ];
  };
}
