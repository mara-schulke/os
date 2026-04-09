{ ... }:

{
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>t";
        action = "gcc";
        options = {
          desc = "Toggle comment";
          remap = true;
        };
      }
    ];
  };
}
