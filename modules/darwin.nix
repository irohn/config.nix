{nix-darwin, ...}: let
  settings = import ../settings.nix;
  hosts =
    builtins.filterAttrs (
      name: host: builtins.match ".*darwin.*" host.system != null
    )
    settings.hosts;
in {
  darwinConfigurations =
    builtins.mapAttrs (
      name: host:
        nix-darwin.lib.darwinSystem {
          modules = [
            ../darwin/000-default.nix
          ];
          specialArgs = {
            inherit settings name;
            system = host.system;
          };
        }
    )
    hosts;
}
