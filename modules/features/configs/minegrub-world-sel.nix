{inputs, ...}: {
  flake.nixosModules.minegrubWorldSel = {pkgs, ...}: {
    imports = [inputs.minegrub-theme.nixosModules.default];
    boot.loader.grub = {
      minegrub-world-sel.enable = true;
    };
  };
}
