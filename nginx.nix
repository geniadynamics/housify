{ config, pkgs, lib, inputs, ... }:

{
    imports =
        [
        ./hardware-configuration.nix
        ];

    services.nginx = {
        enable = true;
        package = pkgs.nginxQuic;
        recommendedProxySettings = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedTlsSettings = true;

        logError = "stderr info";

        virtualHosts = {
            "housify.geniadynamics.org" = {
                http3 = true;
                quic = true;
                forceSSL = true;
                enableACME = true;
                kTLS = true;
                listen = [
                {
                    addr = "0.0.0.0";
                    port = 443;
                    ssl = true;
                }
                ];
                locations."/" = {
                    proxyPass = "http://192.168.0.00:0000"; # !TODO change
                    proxyWebsockets = true;
                };
                locations."/static/" = {
                    alias = "/var/web/housify/static/";
                };
                locations."/media/" = {
                    alias = "/var/web/housify/media/";
                };
            };
        };

        system.stateVersion = "23.05";
    }
}
