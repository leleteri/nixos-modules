{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    toml = pkgs.formats.toml {};

    mkNoctalia = {
      package ? pkgs.noctalia,
      files ? [],
      settings ? {},
    }: let
      entries =
        lib.imap0 (i: f: {
          name = "noctalia/${lib.fixedWidthNumber 2 i}-file.toml";
          path = f;
        })
        files
        ++ lib.optional (settings != {}) {
          name = "noctalia/99-settings.toml";
          path = toml.generate "noctalia-settings.toml" settings;
        };
      configDir = pkgs.linkFarm "noctalia-config" entries;
    in
      pkgs.symlinkJoin {
        name = "${package.pname or "noctalia"}-wrapped";
        paths = [package];
        nativeBuildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/noctalia \
            --set NOCTALIA_CONFIG_HOME ${configDir}
        '';
        passthru = {
          inherit configDir;
          unwrapped = package;
        };
        meta = (package.meta or {}) // {mainProgram = "noctalia";};
      };
  in {
    packages = {
      noctalia = mkNoctalia {};
      noctaliaCherryBlossom = mkNoctalia {
        files = [./toml/leleteri.toml];
        settings.theme.source = "community";
      };
      noctaliaTokyonight = mkNoctalia {
        files = [./toml/leleteri.toml];
        settings.theme.source = "builtin";
      };
    };
  };
}
