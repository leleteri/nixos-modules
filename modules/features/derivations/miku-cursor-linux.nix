{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    releaseVersion = "1.2.6";
  in {
    packages.mikuCursorLinux = pkgs.stdenv.mkDerivation {
      pname = "miku-cursor-linux";
      version = releaseVersion;

      src = pkgs.fetchFromGitHub {
        owner = "supermariofps";
        repo = "hatsune-miku-windows-linux-cursors";
        rev = releaseVersion;

        hash = "sha256-OQjjOc9VnxJ7tWNmpHIMzNWX6WsavAOkgPwK1XAMwtE=";
      };

      installPhase = ''
        mkdir -p $out/share/icons/miku-cursor-linux
        cp -r ./miku-cursor-linux/* $out/share/icons/miku-cursor-linux
      '';
    };
  };
}
