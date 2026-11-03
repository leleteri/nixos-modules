{...}: {
  flake.homeModules.desktop = {
    pkgs,
    lib,
    ...
  }: {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
    };

    home.packages = [
      pkgs.hicolor-icon-theme
    ];

    gtk = {
      colorScheme = "dark";
      gtk3 = {
        extraConfig.gtk-decoration-layout = ":";
        extraCss = ''
          * {
            transition: none;
          }
        '';
      };
      gtk4 = {
        extraConfig.gtk-decoration-layout = ":";
        extraCss = ''
          * {
            transition: none;
          }
        '';
      };
    };
  };
}
