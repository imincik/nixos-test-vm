{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
  };

  users.users.test = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      xterm
      firefox
    ];
    initialPassword = "test";
  };

  virtualisation.vmVariant = {
    virtualisation.memorySize = 2048;
  };

  system.stateVersion = "23.11";
}
