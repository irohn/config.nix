{
  description = "Nix Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";

    tmux-config = {
      url = "github:irohn/config.tmux";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    agenix,
    flake-utils,
    tmux-config,
    ...
  }:
    {
      homeConfigurations = builtins.listToAttrs (
        map (system: {
          name = system;
          value = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${system};
            modules = [
              agenix.homeManagerModules.default
              ./home.nix
            ];
            extraSpecialArgs = {
              inherit tmux-config;
            };
          };
        })
        flake-utils.lib.defaultSystems
      );

      # # Darwin configurations for each Darwin system
      # darwinConfigurations = builtins.listToAttrs (
      #   map (system: {
      #     name = system;
      #     value = darwin.lib.darwinSystem {
      #       inherit system;
      #       modules = [
      #         agenix.darwinModules.default
      #         home-manager.darwinModules.home-manager
      #         ./darwin.nix
      #       ];
      #       specialArgs = {
      #         inherit tmux-config;
      #       };
      #     };
      #   }) (builtins.filter (system: builtins.match ".*-darwin" system != null) flake-utils.lib.defaultSystems)
      # );

      # # NixOS configurations for each Linux system
      # nixosConfigurations = builtins.listToAttrs (
      #   map (system: {
      #     name = system;
      #     value = nixpkgs.lib.nixosSystem {
      #       inherit system;
      #       modules = [
      #         agenix.nixosModules.default
      #         home-manager.nixosModules.home-manager
      #         ./nixos.nix
      #       ];
      #       specialArgs = {
      #         inherit tmux-config;
      #       };
      #     };
      #   }) (builtins.filter (system: builtins.match ".*-linux" system != null) flake-utils.lib.defaultSystems)
      # );
    }
    # this // is needed to combine the outputs
    // flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixd
            nixfmt-rfc-style
            alejandra
          ];
        };
      }
    );
}
