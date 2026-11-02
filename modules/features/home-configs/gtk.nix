{...}: {
  flake.homeModules.gtk = {
    pkgs,
    lib,
    ...
  }: {
    gtk.gtk3 = {
      extraConfig.gtk-decoration-layout = ":";
      extraCss = ''
        * {
          transition: none;
        }
      '';
    };
    gtk.gtk4 = {
      extraConfig.gtk-decoration-layout = ":";
      extraCss = ''
        * {
          transition: none;
        }
      '';
    };
  };
}
