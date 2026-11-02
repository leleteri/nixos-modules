{...}: {
  flake.nixosModules.printing = {
    pkgs,
    lib,
    ...
  }: {
    services.printing.enable = true;

    hardware.sane.enable = true;
    hardware.sane.extraBackends = [
      pkgs.sane-airscan
      pkgs.epkowa
    ];

    environment.systemPackages = [
      pkgs.epson-escpr
      pkgs.epson-escpr2
      pkgs.simple-scan
    ];
  };
}
