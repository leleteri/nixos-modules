{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: let
    themes = {
      CherryBlossom = {
        settings.layout.border = {
          active-color = "#2A1A23";
          inactive-color = "#4E3945";
        };
        extraSettings = [
          {
            cursor = {
              xcursor-theme = "miku-cursor-linux";
              xcursor-size = 48;
            };
          }
        ];
      };
      Tokyonight = {
        settings.layout.border = {
          active-color = "#1A1B26";
          inactive-color = "#24283b";
        };
        extraSettings = [
          {
            cursor = {
              xcursor-theme = "miku-cursor-linux";
              xcursor-size = 48;
            };
          }
        ];
      };
    };

    mkNiri = name: settings:
      inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        imports = [self.nixosModules.niriConfig settings];
        settings = {
          spawn-at-startup = [
            [
              "env"
              "LIBVA_DRIVER_NAME=none"
              (lib.getExe self'.packages."noctalia${name}")
            ]
          ];
        };
      };
  in {
    packages =
      lib.mapAttrs' (
        name: settings: lib.nameValuePair "niri${name}" (mkNiri name settings)
      )
      themes;
  };
}
