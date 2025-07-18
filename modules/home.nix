{
  nixpkgs,
  home-manager,
  agenix,
  flake-utils,
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
        };
      };
    })
    flake-utils.lib.defaultSystems
  );
}
