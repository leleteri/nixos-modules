{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.waydroidBindMounts = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.virtualisation.waydroid.bindMounts;
    esc = lib.escapeShellArg;

    forEachFolder = f:
      lib.concatStringsSep "\n" (lib.mapAttrsToList f cfg.folders);
  in {
    options.virtualisation.waydroid.bindMounts = {
      enable = lib.mkEnableOption "automatic bind mounts from host folders to Waydroid storage";

      hostPath = lib.mkOption {
        type = lib.types.str;
        description = "Absolute path of the host directory that the names in `folders` are relative to.";
        example = "/home/alice";
      };

      waydroidDataPath = lib.mkOption {
        type = lib.types.str;
        description = "Absolute path to Waydroid's emulated internal storage root.";
        example = "/home/alice/.local/share/waydroid/data/media/0";
      };

      folders = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {
          Shared = "Shared";
        };
        description = ''
          Attribute set mapping host folder names (relative to `hostPath`)
          to Waydroid internal storage folder names.
          Default Android names: Download (not Downloads), Movies (for Videos).
        '';
        example = lib.literalExpression ''
          {
            Documents = "Documents";
            Downloads = "Download";
            Music     = "Music";
            Pictures  = "Pictures";
            Videos    = "Movies";
          }
        '';
      };
    };

    config = lib.mkIf cfg.enable {
      virtualisation.waydroid.enable = true;

      systemd.services.waydroid-bind-mounts = {
        description = "Bind mount host folders into Waydroid storage";
        after = ["waydroid-container.service"];
        requires = ["waydroid-container.service"];
        # Restart/stop this unit whenever the container is restarted/stopped
        partOf = ["waydroid-container.service"];
        wantedBy = ["multi-user.target"];
        path = with pkgs; [util-linux coreutils];

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;

          ExecStart = pkgs.writeShellScript "waydroid-bind-mounts-start" ''
            set -euo pipefail

            DATA=${esc cfg.waydroidDataPath}

            # Don't create Waydroid's data tree ourselves (we'd own it as root)
            if [ ! -d "$DATA" ]; then
              echo "Waydroid data dir $DATA not found (init Waydroid and start a session once); skipping." >&2
              exit 0
            fi

            ${forEachFolder (hostName: droidName: ''
              src=${esc "${cfg.hostPath}/${hostName}"}
              dst="$DATA"/${esc droidName}

              # Host folders must already exist (creating them as root would
              # leave them root-owned inside the user's home)
              if [ ! -d "$src" ]; then
                echo "Host folder $src does not exist; skipping." >&2
              else
                mkdir -p "$dst"

                # Idempotency
                if mountpoint -q "$dst"; then
                  umount "$dst"
                fi

                mount --bind "$src" "$dst"
                echo "Bound $src -> $dst"
              fi
            '')}
          '';

          ExecStop = pkgs.writeShellScript "waydroid-bind-mounts-stop" ''
            set -uo pipefail

            DATA=${esc cfg.waydroidDataPath}

            ${forEachFolder (hostName: droidName: ''
              dst="$DATA"/${esc droidName}
              if mountpoint -q "$dst"; then
                umount "$dst" || true
                echo "Unmounted $dst"
              fi
            '')}
          '';
        };
      };
    };
  };
}
