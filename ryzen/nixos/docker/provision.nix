{

    environment.systemPackages = [
        inputs.compose2nix.packages.x86_64-linux.default
    ]

    virtualisation.docker.enable = true;

    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    }

    virtualisation.oci-containers = {
        backend = "docker";
        containers = {
            #
        }
    }

    users.users.${rootlessDockerUser}.extraGroups = [ "docker" ];

}