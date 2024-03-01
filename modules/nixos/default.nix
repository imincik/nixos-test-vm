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
    k3s = ./k3s;
    xfce = ./xfce;
  };

  flake.nixosConfigurations = {
    vm = nixosSystemFor "x86_64-linux" ./vm;
    k3s = nixosSystemFor "x86_64-linux" ./k3s;
    xfce = nixosSystemFor "x86_64-linux" ./xfce;
  };

  perSystem = { system, ... }: {
    apps = {
      vm = vmApp "vm";
      k3s = vmApp "k3s";
      xfce = vmApp "xfce";
    };
  };
}
