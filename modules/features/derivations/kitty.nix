{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.kittyConfig = {
    pkgs,
    lib,
    ...
  }: {
    font = {
      name = "JetBrainsMono NF Medium";
      size = 14;
    };

    settings = {
      cursor_shape = "block";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      background_opacity = 0.8;
      # background_blur = 1;
      hide_window_decorations = "yes";
      confirm_os_window_close = 0;
    };
  };

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.kitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      imports = [
        self.nixosModules.kittyConfig
      ];
    };

    packages.kittyCorvine = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      themeFile = "Corvine";
      imports = [
        self.nixosModules.kittyConfig
      ];
    };

    packages.kittyTokyonight = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      themeFile = "tokyo_night_storm";
      imports = [
        self.nixosModules.kittyConfig
      ];
    };
  };
}
