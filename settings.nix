{
  username = "ori";
  email = "orisneh@gmail.com";
  work-email = "orisne@greeneye.ag";
  home = {
    imports = [
      ./home/age.nix
      ./home/direnv.nix
      ./home/eza.nix
      ./home/fd.nix
      ./home/fzf.nix
      ./home/ghostty.nix
      ./home/git.nix
      ./home/k8s.nix
      ./home/neovim.nix
      ./home/ripgrep.nix
      ./home/starship.nix
      ./home/tmux.nix
      ./home/zoxide.nix
      ./home/zsh.nix
    ];
  };
  darwin = {
    imports = [];
  };
  nixos = {
    imports = [];
  };
}
