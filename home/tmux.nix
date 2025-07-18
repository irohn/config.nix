{
  pkgs,
  tmux-config,
  ...
}: {
  home.packages = [pkgs.tmux];
  home.file.".config/tmux" = {
    source = "${tmux-config}";
    recursive = true;
  };

  programs.zsh.initContent = ''if [ -z "$TMUX" ]; then tmux -u new-session -A -s default; fi '';
}
