{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alt-tab-macos
    iina
    karabiner-elements
    mos
    raycast
    rectangle
    xquartz
  ];

  homebrew = {
    enable = true;
    # 'zap': uninstalls all formulae(and related files) not listed here.
    onActivation.cleanup = "zap";
    taps = [];
    brews = [];
    casks = [
      "keepingyouawake" # Prevent screen from turning off
      "stremio"
      "docker-desktop"
    ];
  };
}
