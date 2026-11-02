{...}: {
  flake.nixosModules.generalHardware = {
    config,
    pkgs,
    lib,
    ...
  }: {
    zramSwap = {
      enable = true;
      memoryPercent = 100;
      algorithm = "zstd";
    };
  };
}
