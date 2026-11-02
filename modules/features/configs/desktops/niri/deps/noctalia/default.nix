{self, ...}: {
  flake.nixosModules.noctaliaDeps = {
    imports = [
      self.nixosModules.noctaliaProcesses
      self.nixosModules.noctaliaGeneral
    ];
  };
}
