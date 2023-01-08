{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        my-python-packages = python-packages: with python-packages; [
          pkgs.python310Packages.jmespath
        ];

        python-with-my-packages = pkgs.python310.withPackages my-python-packages;
      in {
        devShell = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.ansible-lint
            pkgs.pre-commit
          ];
          buildInputs = [
            pkgs.ansible
            python-with-my-packages
          ];
        };
      });
}
