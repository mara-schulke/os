{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./completions.nix
    ./diagnostics.nix
    ./formatter.nix
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

      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      lspkind.enable = true;
      nix.enable = true;
      crates.enable = true;
      typescript-tools.enable = true;
      trouble.enable = true;
      fidget.enable = true;

      rustaceanvim = {
        enable = true;
        settings = {
          server = {
            cmd = [ "rust-analyzer" ];
            default_settings = {
              rust-analyzer = {
                completion = {
                  limit = 50;
                  postfix = {
                    enable = false;
                  };
                };

                inlayHints = {
                  maxLength = 20;
                  lifetimeElisionHints = {
                    enable = "skip_trivial";
                    useParameterNames = false;
                  };
                  closureReturnTypeHints = {
                    enable = "with_block";
                  };
                  typeHints = {
                    hideClosureInitialization = true;
                    hideNamedConstructor = true;
                  };
                  chainingHints = {
                    maxLength = 15; # Custom limit for performance
                  };
                  parameterHints = {
                    maxLength = 15; # Custom limit for performance
                  };
                };

                lens = {
                  references = {
                    adt.enable = false;
                    enumVariant.enable = false;
                    method.enable = false;
                    trait.enable = false;
                  };
                };

                cargo = {
                  buildScripts = {
                    features = "all"; # Enable all feature flags
                    invocationStrategy = "once"; # Default is "per_workspace", faster caching
                  };
                };

                checkOnSave = true;

                imports = {
                  granularity = {
                    group = "module";
                  };
                  prefix = "crate";
                };

                workspace = {
                  symbol = {
                    search = {
                      kind = "only_types";
                      limit = 64;
                    };
                  };
                };

                files = {
                  excludeDirs = [
                    "target"
                    "node_modules"
                    ".git"
                    "dist"
                    "build"
                  ];
                };

                diagnostics = {
                  experimental = {
                    enable = false;
                  };
                };
              };
            };
            standalone = false;
          };
        };
      };
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
