{ inputs, envVars, pkgs, ... }:

{

    environment.systemPackages = [
        inputs.compose2nix.packages.x86_64-linux.default
    ];

		virtualisation = {
			containers.enable = true;
			podman = {
				enable = true;
				dockerCompat = true;
				defaultNetwork.settings.dns_enabled = true;
			};
		};

    virtualisation.docker.enable = true;

    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };

    virtualisation.oci-containers = {
        backend = "docker";
        containers = {
            #
        };
    };

    users.users.${envVars.rootlessDockerUser}.extraGroups = [ "docker" ];

}
