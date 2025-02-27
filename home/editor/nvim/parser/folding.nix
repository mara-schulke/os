{ ... }:

{
  programs.nixvim = {
    opt = {
      foldenable = true;
      foldexpr = "nvim_treesitter#foldexpr()";
      foldlevel = 5;
      foldlevelstart = 5;
      foldmethod = "expr";
    };

    keymaps =
      let
        mode = [
          "n"
          "v"
        ];
      in
      [
        {
          inherit mode;
          key = "zk";
          action = "zc";
          options.desc = "Fold";
        }
        {
          inherit mode;
          key = "zj";
          action = "zo";
          options.desc = "Unfold";
        }
        {
          inherit mode;
          key = "zz";
          action = "za";
          options.desc = "Fold/Unfold";
        }
        {
          inherit mode;
          key = "z,";
          action = "zm";
          options.desc = "Decrease Fold Level";
        }
        {
          inherit mode;
          key = "z.";
          rction = "zr";
          options.desc = "Increase Fold Level";
        }
      ];
  };
}
