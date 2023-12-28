{ config, pkgs, lib, inputs, ... }:

{
    imports =
        [
        ./hardware-configuration.nix
        ];

    networking = {
        networkmanager.enable = true;

        hostName = "server-01";

        dhcpcd.extraConfig = "nohook resolv.conf";

        networkmanager.dns = "none";


        #!TODO change hostname.domain
        extraHosts = ''
            127.0.0.1 hostname.domain
            127.0.0.1 mail.hostname.domain
            127.0.0.1 smpt.hostname.domain
            '';

        networkmanager.insertNameservers = [ "1.1.1.1" "1.0.0.1" "192.168.1.1" ];
    };

	time.timeZone = "Europe/Lisbon";

    services.nscd.enableNsncd = true;

	services.openssh.enable = true;

	networking.firewall = {
		enable = true;
		allowedTCPPorts = [ 22 80 443 587 993 10021];
		allowedUDPPorts = [ 443 ]; # Http3!
		# allowedTCPPortRanges = [{ from = 0; to = 60000; }];
		# allowedUDPPortRanges = [{ from = 0; to = 10000; }];
	};

    system.stateVersion = "23.05";
}
