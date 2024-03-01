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
    xfce = ./xfce;
  };

  flake.nixosConfigurations = {
    vm = nixosSystemFor "x86_64-linux" ./vm;
    xfce = nixosSystemFor "x86_64-linux" ./xfce;
  };

  perSystem = { system, ... }: {
    apps = {
      vm = vmApp "vm";
      xfce = vmApp "xfce";
    };
  };
}
