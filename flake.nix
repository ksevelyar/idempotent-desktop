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
  in {
    formatter.x86_64-linux = pkgs.alejandra;

    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [
        (pkgs.writeShellApplication {
          name = "size";
          runtimeInputs = with pkgs; [coreutils gawk];
          text = ''
            system_path="$(readlink -f /run/current-system)"
            nix path-info -rSh "$system_path" | tail -n 1 | awk '{print $2, $3}'
          '';
        })
        (pkgs.writeShellApplication {
          name = "format";
          text = ''
            nix fmt -- --exclude ./.git .
          '';
        })
      ];
    };

    nixosConfigurations = builtins.listToAttrs (map build-target hosts);
  };
}
