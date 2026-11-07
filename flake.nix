{
  description = "26.05";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
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
    nixpkgs-unstable,
  } @ inputs: let
    pkgs = (import nixpkgs) {
      system = "x86_64-linux";
    };
    pkgs-unstable = import nixpkgs-unstable {
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
        specialArgs = {
          inherit inputs pkgs-unstable;
        };
      };
    };

    usb-image = {
      name = "usb-image";
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          nixpkgs.nixosModules.notDetected
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
          (import ./users/root.nix)
          (import ./usb/usb-image.nix)
        ];
        specialArgs = {
          inherit inputs pkgs-unstable;
        };
      };
    };

    usb-tui = {
      name = "usb-tui";
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixpkgs.nixosModules.notDetected
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
          disko.nixosModules.disko
          (import ./users/root.nix)
          (import ./usb/usb-tui.nix)
        ];
        specialArgs = {
          inherit inputs pkgs-unstable;
        };
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
          (import ./usb/usb-hyprland.nix)
        ];
        specialArgs = {
          inherit inputs pkgs-unstable;
        };
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
