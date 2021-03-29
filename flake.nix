{
  description = "Unstable + HM";

  inputs = {
    home-manager = {
      url = "github:rycee/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, home-manager, nixpkgs }:
    let
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
            home-manager.nixosModules.home-manager
            (import (./hosts + "/${host}.nix"))
          ];
        };
      };

    in
      {
        nixosConfigurations = builtins.listToAttrs (
          pkgs.lib.flatten (
            map
              (
                host: [
                  (build-target host)
                ]
              )
              hosts
          )
        );
      };

  # outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: {
  #   nixosConfigurations.hk47 = {
  #     athena = nixpkgs.lib.nixosSystem {
  #       system = "x86_64-linux";
  #       modules =
  #         [
  #           (import ./hosts/hk47.nix)
  #           home-manager.nixosModules.home-manager
  #           nixpkgs.nixosModules.notDetected
  #         ];
  #       specialArgs = { inherit inputs; };
  #     };
  #   };
  # };
}
