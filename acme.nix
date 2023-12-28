
{ config, pkgs, lib, inputs, ... }:

{
    imports =
        [
        ./hardware-configuration.nix
        ];

    security.acme = {
        acceptTerms = true;
        defaults.email = "security@hostname.domain";
        certs."mail.hostname.domain" = {
            webroot = "/var/lib/acme/challenges-mail.hostname";
            group = "nginx";
            extraDomainNames = [
                "smtp.hostname.domain"
            ];
        };
    };

    system.stateVersion = "23.05";
}
