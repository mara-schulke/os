{ ... }:

{
  imports = [
    ./comments.nix
    ./hints.nix
    ./search.nix
  ];

  programs.nixvim = {
    keymaps = [
      # Save
      {
        key = "<C-s>";
        action = ":w<CR>";
        options.desc = "Save";
      }
      # Move
      {
        key = "q";
        mode = "n";
        action = "gqq";
      }
      {
        key = "j";
        mode = "n";
        action = "gj";
      }
      {
        key = "k";
        mode = "n";
        action = "gk";
      }
      # Move Line Up
      {
        key = "<A-j>";
        mode = "n";
        action = ":m +1<CR>==";
        options.desc = "Move Line Up";
      }
      {
        key = "<A-j>";
        mode = "v";
        options.desc = "Move Line Up";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        key = "<A-j>";
        mode = "i";
        options.desc = "Move Line Up";
        action = "<Esc>:m +1<CR>==gi";
      }
      # Move Line Down
      {
        key = "<A-k>";
        mode = "n";
        action = ":m -2<CR>==";
        options.desc = "Move Line Up";
      }
      {
        key = "<A-k>";
        mode = "v";
        options.desc = "Move Line Up";
        action = ":m '<-2<CR>gv=gv";
      }
      {
        key = "<A-k>";
        mode = "i";
        options.desc = "Move Line Up";
        action = "<Esc>:m -2<CR>==gi";
      }
    ];
  };
}
