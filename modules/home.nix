{
  nixpkgs,
  home-manager,
  agenix,
  flake-utils,
  tmux-config,
  ...
}: let
  settings = import ../settings.nix;
in {
  homeConfigurations = builtins.listToAttrs (
    map (system: {
      name = system;
      value = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          agenix.homeManagerModules.default
          ../home/000-default.nix
        ];
        extraSpecialArgs = {
          inherit settings;
          inherit tmux-config;
        };
      };
    })
    flake-utils.lib.defaultSystems
  );
}
