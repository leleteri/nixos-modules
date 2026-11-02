{...}: {
  flake.nixosModules.niriExtras = {lib, ...}: {
    extraSettings = [
      {hotkey-overlay.skip-at-startup = _: {};}
      {prefer-no-csd = _: {};}
      {
        blur = {
          off = _: {};
        };
      }
    ];
  };
}
