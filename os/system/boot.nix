{ ... }:

{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
      };
    };

    plymouth = {
      enable = true;
      theme = "spinner";
      # TODO logo = "/path/to/logo.png";
    };

    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
    ];
  };
}
