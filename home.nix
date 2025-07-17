{
  pkgs,
  tmux-config,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ori";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/${pkgs.config.home.username}"
    else "/home/${pkgs.config.home.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    tmux
  ];

  home.file = {
    ".config/tmux" = {
      source = "${tmux-config}";
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    initContent = ''
      # emacs keybindings
      bindkey -e

      # Edit current command in EDITOR
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey "^X^E" edit-command-line

      # historySubstringSearch settings
      export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
      export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true
    '';
    historySubstringSearch = {
      enable = true;
      searchUpKey = [
        "$terminfo[kcuu1]"
        "^[[A"
      ];
      searchDownKey = [
        "$terminfo[kcud1]"
        "^[[B"
      ];
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
      gnumake
      nodejs_24
      shellcheck
      bash-language-server
      shfmt
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
