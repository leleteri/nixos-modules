{inputs, ...}: {
  flake.homeModules.nixowos = {
    pkgs,
    lib,
    ...
  }: {
    imports = [inputs.nixowos.homeModules.nixowos];
    nixowos.enable = true;
  };
}
