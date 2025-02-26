{
  pkgs,
  ...
}:

let
  nerdcommenter = pkgs.vimUtils.buildVimPlugin {
    pname = "nerdcommenter";
    version = "2.6.0";
    src = pkgs.fetchFromGitHub {
      owner = "preservim";
      repo = "nerdcommenter";
      rev = "master";
      sha256 = "sha256-IW4RToMGwOSX0GbNXpBkOqtZ2C9Mgbk6iZWPGX5jDr4=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ nerdcommenter ];

    keymaps = [
      {
        key = "<leader>t";
        action = ":call nerdcommenter#Comment('n', 'toggle')<CR>";
        options.desc = "Toggle comment";
      }
    ];
  };
}
