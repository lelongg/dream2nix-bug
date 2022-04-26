{
  inputs.dream2nix.url =
    "github:nix-community/dream2nix/c93972bd52977de332812fcc97ff77f8b85bcf42";
  outputs = { self, dream2nix }@inputs:
    let
      pkgs = inputs.dream2nix.nixpkgs.legacyPackages.x86_64-linux;
      dream2nix = inputs.dream2nix.lib.init {
        systems = [ "x86_64-linux" ];
        config.projectRoot = ./.;
      };
    in dream2nix.makeFlakeOutputs { source = ./.; };
}
