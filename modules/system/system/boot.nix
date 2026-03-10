{ ... }:

{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
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
