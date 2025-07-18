{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alt-tab-macos
    mos
    karabiner-elements
    raycast
    xquartz
    iina
    rectangle
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
