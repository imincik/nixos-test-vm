{ lib, pkgs, ... }:

{
  imports = [
    ./../vm-common.nix
  ];

  virtualisation = {
    graphics = lib.mkForce true;
    resolution = lib.mkForce {
      x = 1600;
      y = 900;
    };
  };

  services.xserver = {
    enable = true;
    displayManager.autoLogin.user = "test";
    desktopManager.xfce.enable = true;
  };

  users.users.test = {
    isNormalUser = true;
    initialPassword = "test";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };
}
