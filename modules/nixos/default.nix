{ self, lib, withSystem, ... }:

let
  nixosSystemFor = system: module:
    let
      pkgs = withSystem system ({ pkgs, ... }: pkgs);

    in lib.nixosSystem {
      inherit system;
      specialArgs = { inherit lib; };
      modules = [
        {
          _module.args = {
            # inherit examples;
            pkgs = lib.mkForce pkgs;
          };
        }
        self.nixosModules.default
        module
      ];
    };

  vmApp = name: {
    type = "app";
    program = "${self.nixosConfigurations.${name}.config.system.build.vm}/bin/run-nixos-vm";
  };

in {
  flake.nixosModules = rec {
    default = {
      imports = [ ];
    };

    vm = ./vm;
    xfce-gui = ./xfce-gui;
  };

  flake.nixosConfigurations = {
    vm = nixosSystemFor "x86_64-linux" ./vm;
    xfce-gui = nixosSystemFor "x86_64-linux" ./xfce-gui;
  };

  perSystem = { system, ... }: {
    apps = {
      vm = vmApp "vm";
      xfce-gui = vmApp "xfce-gui";
    };
  };
}
