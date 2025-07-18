{
  description = "Nix Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs: let
    homeModule = import ./modules/home.nix inputs;
    darwinModule = import ./modules/darwin.nix inputs;
    # nixosModule = import ./modules/nixos.nix inputs;
  in
    homeModule
    // darwinModule
    # // nixosModule
    // inputs.flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = import ./shell.nix;
    });
}
