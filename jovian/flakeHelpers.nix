inputs:
let
    homeManagerCfg = userPackages: extraImports: {
        home-manager.
    }
in
{
    mkNixos = machineHostname: nixpkgsVersion: extraModules: rec {
        deploy.nodes.${machineHostname} = {
            hostname = machineHostname;
            profiles.system = {
                user = "root";
                sshUser = "micah";
                path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos nixosConfigurations.${machineHostname};
            };
        };
    }
}