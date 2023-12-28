
{ config, pkgs, lib, inputs, ... }:

{
    imports =
        [
        ./hardware-configuration.nix
        ];

    services.postgresql = {
        enable = true;
        package = pkgs.postgresql_16;

        initialScript = pkgs.writeText "init-script" ''
            ALTER USER postgres WITH LOGIN PASSWORD 'postgresPassword'
            ''; #! TODO change
        authentication = pkgs.lib.mkOverride 10 ''
            #type database  DBuser  auth-method
            local all       all     trust
            host    all             all             ::1/128                 md5
            '';
    };

    system.stateVersion = "23.05";
}
