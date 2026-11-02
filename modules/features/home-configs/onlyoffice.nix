{...}: {
  flake.homeModules.onlyoffice = {config, ...}: {
    fonts.fontconfig.enable = true;
    programs.onlyoffice = {
      enable = true;

      settings = {
        UITheme = "theme-contrast-dark";
        maximized = true;
      };
    };

    home.activation.linkOnlyOfficeFonts = config.lib.dag.entryAfter ["writeBoundary"] ''
      fontDir="$HOME/.local/share/fonts/onlyoffice"
      mkdir -p "$fontDir"

      if [ -d "/run/current-system/sw/share/X11/fonts" ]; then
        $DRY_RUN_CMD cp -rL /run/current-system/sw/share/X11/fonts/* "$fontDir/"
        $DRY_RUN_CMD chmod -R 644 "$fontDir"/*
      fi
    '';
  };
}
