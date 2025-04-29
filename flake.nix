{
  description = "Builds the T4EQ website using hugo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    theme = {
      url = "git+file:themes/ananke";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      theme,
    }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      forEachSystem =
        fn:
        nixpkgs.lib.genAttrs systems (
          system:
          let
            pkgs = import nixpkgs { inherit system; };
          in
          fn pkgs
        );

      buildHugoPackage =
        {
          pkgs,
          pname,
          version,
          src,
          extraBuildArgs ? "",
        }:
        (pkgs.stdenvNoCC.mkDerivation {
          inherit pname version src;

          nativeBuildInputs = [
            pkgs.hugo
          ];

          patchPhase = ''
            mkdir -p themes/
            cp -r ${theme}/ themes/ananke
          '';

          buildPhase = ''
            hugo ${extraBuildArgs}
          '';

          installPhase = ''
            cp -r public $out
          '';
        });

    in
    {
      packages = forEachSystem (pkgs: rec {
        t4eq = buildHugoPackage {
          inherit pkgs;
          pname = "t4eq";
          version = "1.0.0";
          src = self;
          extraBuildArgs = "--minify";
        };

        default = t4eq;
      });

      devShells = forEachSystem (pkgs: rec {
        t4eq = pkgs.mkShellNoCC {
          nativeBuildInputs = [
            pkgs.hugo
          ];
        };

        default = t4eq;
      });
    };
}
