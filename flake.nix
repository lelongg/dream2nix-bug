{
  inputs = {
    dream2nix.url =
      "github:yusdacra/dream2nix/6d2a50459c51e4ffef5a3ce9165f9c682cd8fd22";
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-21.05";
  };
  outputs = { self, dream2nix, nixpkgs }@inputs:
    let
      dream2nix = inputs.dream2nix.lib.init {
        systems = [ "x86_64-linux" ];
        config.projectRoot = ./.;
      };
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in dream2nix.makeFlakeOutputs {
      source = ./.;
      packageOverrides = {
        ws_stream = {
          add-pre-build-steps = {
            nativeBuildInputs = old: old ++ (with pkgs; [ pkg-config ]);
            buildInputs = old: old ++ (with pkgs; [ openssl ]);
          };
        };
      };
    };
}
