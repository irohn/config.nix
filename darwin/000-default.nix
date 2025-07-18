{
  self,
  system,
  settings,
  name,
  ...
}: {
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = settings.hosts."${name}".stateVersion;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "${system}";
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  imports = settings.hosts."${name}".imports ++ settings.hosts.shared_imports;
}
