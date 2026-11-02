{inputs, ...}: {
  flake.nixosModules.nixowos = {
    pkgs,
    lib,
    ...
  }: {
    imports = [inputs.nixowos.nixosModules.nixowos];
    nixowos.enable = true;
    nixowos.overlays.fastfetch = false;
    nixowos.overlays.hyfetch = false;
  };
}
