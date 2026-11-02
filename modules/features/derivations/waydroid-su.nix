{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.waydroidSu = pkgs.rustPlatform.buildRustPackage rec {
      pname = "WaydroidSU";
      version = "0.1.2";

      src = pkgs.fetchFromGitHub {
        owner = "mistrmochov";
        repo = "WaydroidSU";
        rev = version;
        # Replace with real hash after: nix-prefetch-git --url https://github.com/mistrmochov/WaydroidSU --rev 0.1.2
        hash = "sha256-ICC/lTUSUpeg/RZOfLJzplt3aQBXlNg1ng8yANGVMgA=";
      };

      # Replace with real hash after first build attempt (it will fail and tell you the correct hash)
      cargoHash = "sha256-kweqiD7UyS8Tm9bPvjGx6V91uUf2xLQtxw5L5frFuOw=";

      nativeBuildInputs = [
        pkgs.makeWrapper
        pkgs.pkg-config
      ];

      buildInputs = [
        pkgs.openssl
        pkgs.dbus
      ];

      postInstall = ''
        wrapProgram $out/bin/wsu \
          --prefix PATH : "${lib.makeBinPath [
          pkgs.waydroid
          pkgs.android-tools
          pkgs.libnotify
          pkgs.sudo
          pkgs.coreutils
          pkgs.gnugrep
          pkgs.gnused
          pkgs.gawk
          pkgs.curl
          pkgs.wget
          pkgs.unzip
          pkgs.util-linux
          pkgs.gnutar
          pkgs.xz
        ]}"
      '';

      meta = with lib; {
        description = "Magisk installer for Waydroid with modern Zygisk support";
        homepage = "https://github.com/mistrmochov/WaydroidSU";
        license = licenses.gpl3Only;
        platforms = platforms.linux;
      };
    };
  };
}
