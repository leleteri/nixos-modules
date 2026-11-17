{...}: {
  flake.nixosModules.niriDepsGuiApps = {pkgs, ...}: {
    environment.systemPackages = [
      # media
      pkgs.swayimg
      pkgs.mpv

      pkgs.vivaldi
      pkgs.vivaldi-ffmpeg-codecs
      pkgs.nautilus
      pkgs.xarchiver
    ];

    # ublock origin for vivaldi (manifest v3)
    environment.etc."vivaldi/policies/managed/ublock-mv3.json".text = builtins.toJSON {
      ExtensionInstallForcelist = [
        "blockddmmcjpfkbhanlgegpmjpfpfjka;https://ublock.r58playz.dev/update.xml"
      ];
    };

    # vivaldi deps (for impermanence mainly)
    nixpkgs.config.vivaldi = {
      proprietaryCodecs = true;
      enableWidevine = true;
    };
  };
}
