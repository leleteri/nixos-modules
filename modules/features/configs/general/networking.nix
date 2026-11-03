{...}: {
  flake.nixosModules.generalNetworking = {pkgs, ...}: {
    networking.hostName = "nixos";
    networking.networkmanager = {
      enable = true;
      wifi.powersave = false;
      dns = "systemd-resolved";
    };
    networking.nftables.enable = true;
    # networking.nameservers = ["1.1.1.1"];

    services.dnscrypt-proxy = {
      enable = true;
      settings = {
        listen_addresses = ["127.0.0.1:5300"];
        require_dnssec = true;
      };
    };

    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNS = "127.0.0.1:5300";
        Domains = "~.";
        FallbackDNS = "";
        DNSOverTLS = "false";
        DNSSEC = false;
        LLMNR = false;
        MulticastDNS = false;
      };
    };

    services.openssh = {
      enable = true;
      settings.X11Forwarding = true;
    };

    services.tor.enable = true;
    services.tailscale.enable = true;
    services.mullvad-vpn.enable = true;
  };
}
