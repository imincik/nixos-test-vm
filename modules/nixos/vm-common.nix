{ pkgs, modulesPath, ... }:
{
  imports = [
    # Import qemu-vm directly to avoid using vmVariant since this config
    # is only intended to be used as a VM. Using vmVariant will emit assertion
    # errors regarding `fileSystems."/"` and `boot.loader.grub.device`.
    (modulesPath + "/virtualisation/qemu-vm.nix")
  ];

  users.users.root = {
    initialHashedPassword = null;
    password = "root";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    vim
  ];

  virtualisation = {
    memorySize = 4096;
    cores = 4;
    graphics = false;
    diskImage = null;
  };

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];

  system.stateVersion = "23.11";
}
