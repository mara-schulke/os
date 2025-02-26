{ ... }:

{
  programs.nixvim.keymaps = [
    {
      key = "<C-w>";
      action = ":wq<cr>";
      options.silent = true;
      options.desc = "Close Tab";
    }
    {
      key = "<C-t>";
      action = ":tabnew<cr>";
      options.silent = true;
      options.desc = "New Tab";
    }
    {
      key = "<Tab>";
      mode = "n";
      action = ":tabnext<CR>";
      options.silent = true;
      options.desc = "Next Tab";
    }
    {
      key = "<S-Tab>";
      mode = "n";
      action = ":tabprev<CR>";
      options.silent = true;
      options.desc = "Previous Tab";
    }
  ];
}
