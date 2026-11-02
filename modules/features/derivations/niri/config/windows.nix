{...}: {
  flake.nixosModules.niriWindows = {
    settings = {
      layout = {
        focus-ring.off = _: {};
        gaps = 10;
        border = {
          width = 10;
        };
      };

      window-rules = [
        {draw-border-with-background = false;}
        {
          matches = [
            {app-id = "steam_app_*";}
          ];
          open-floating = false;
        }
        {
          matches = [
            {app-id = "steam_proton";}
          ];
          open-floating = false;
        }
        {geometry-corner-radius = 14;}
        {clip-to-geometry = true;}
      ];
    };
  };
}
