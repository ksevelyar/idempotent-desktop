{
  description = "25.11";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:rycee/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    flake-programs-sqlite,
    agenix,
  }: let
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
      };
    };

    live-usb-x = {
      name = "live-usb-x";
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-base.nix"
          nixpkgs.nixosModules.notDetected
          home-manager.nixosModules.home-manager
          (import ./live-usb/x.nix)
        ];
      };
    };

    live-usb-tui = {
      name = "live-usb-tui";
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          nixpkgs.nixosModules.notDetected
          (import ./live-usb/tui.nix)
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
        ++ [live-usb-x live-usb-tui]
      )
    );
  };
}
