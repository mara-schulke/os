{ ... }:

{
  imports = [ ./tabs.nix ];

  programs.nixvim.keymaps = [
    {
      key = "<C-c>";
      action = ":wincmd q<CR>";
    }
    {
      key = "<C-h>";
      mode = "n";
      action = "<C-w>h";
    }
    {
      key = "<C-j>";
      mode = "n";
      action = "<C-w>j";
    }
    {
      key = "<C-k>";
      mode = "n";
      action = "<C-w>k";
    }
    {
      key = "<C-l>";
      mode = "n";
      action = "<C-w>l";
    }
    {
      key = "<C-,>";
      mode = "n";
      action = ":new<CR>";
    }
    {
      key = "<C-.>";
      mode = "n";
      action = ":vnew<CR>";
    }
  ];
}
