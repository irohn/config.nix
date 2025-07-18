{pkgs, ...}: {
  home.packages = with pkgs; [
    cargo # for avante
    fd
    gcc
    gnumake
    neovim
    nodejs # for copilot
    ripgrep
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    vim = "nvim";
  };
}
