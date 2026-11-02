{self, ...}: {
  flake.nixosModules.niri = {
    imports = [
      self.nixosModules.niriDeps
    ];
    programs.niri.enable = true;
  };
}
