{
  inputs.dream2nix.url =
    "github:nix-community/dream2nix/72f35bb94e45928b8ce3426448dd8fb990d41034";
  outputs = { self, dream2nix }@inputs:
    let
      dream2nix = inputs.dream2nix.lib.init {
        systems = [ "x86_64-linux" ];
        config.projectRoot = ./.;
      };
    in dream2nix.makeFlakeOutputs { source = ./.; };
}
