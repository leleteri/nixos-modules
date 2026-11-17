{...}: {
  flake.nixosModules.niriConfigEnv = {
    pkgs,
    lib,
    ...
  }: {
    settings = {
      spawn-at-startup = [
        [(lib.getExe pkgs.wl-gammarelay-rs) "run"]
      ];
      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
      input.keyboard.xkb.layout = "us,ua";
      input.touchpad = {
        dwt = _: {};
        tap = _: {};
        natural-scroll = _: {};
      };
    };
  };
}
