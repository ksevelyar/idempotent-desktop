{
  description = "25.11";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-programs-sqlite.url = "github:wamserma/flake-programs-sqlite";
    flake-programs-sqlite.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    flake-programs-sqlite,
    agenix,
    disko,
  } @ inputs: let
    pkgs = (import nixpkgs) {
      system = "x86_64-linux";
    };

    hosts = map (pkgs.lib.removeSuffix ".nix") (
      pkgs.lib.attrNames (
        pkgs.lib.filterAttrs
        (_: entryType: entryType == "regular")
        (builtins.readDir ./hosts)
      )
    );

    build-target = host: {
      name = host;

      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          nixpkgs.nixosModules.notDetected
          home-manager.nixosModules.home-manager
          flake-programs-sqlite.nixosModules.programs-sqlite
          agenix.nixosModules.default

          (import (./hosts + "/${host}.nix"))
        ];
        specialArgs.inputs = inputs;
      };
    };

    usb-image = {
      name = "usb-image";
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          nixpkgs.nixosModules.notDetected
          agenix.nixosModules.default
          (import ./usb/image.nix)
        ];
      };
    };

    usb-tui = {
      name = "usb-tui";
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixpkgs.nixosModules.notDetected
          agenix.nixosModules.default
          disko.nixosModules.disko
          (import ./usb/persistent-tui.nix)
        ];
      };
    };

    usb-hyprland = {
      name = "usb-hyprland";
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixpkgs.nixosModules.notDetected
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
          (import ./usb/persistent.nix)
        ];
      };
    };
  in {
    nixosConfigurations = builtins.listToAttrs (
      pkgs.lib.flatten (
        map
        (
          host: [
            (build-target host)
          ]
        )
        hosts
        ++ [usb-image usb-tui usb-hyprland]
      )
    );
  };
}
