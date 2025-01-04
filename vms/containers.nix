{ pkgs, ... }:
{
    virtualisation = {
        oci-containers.backend = "podman";
        oci-containers.containers = {
            hello = {
                image = "docker.io/nginxdemos/hello"
                autoStart = true;
                ports = [ "0.0.0.0:80:80" ];
            }
        }
        containers.enable = true;
        podman = {
            enable = true;

            dockerCompat = true;

            defaultNetwork.settings.dns_enabled = true;
        };
    };

    environment.systemPackages = with pkgs; [ 
        dive
        podman-tui 
        docker-compose
    ];

    environment.extraInit = ''
        if [ -z "$DOCKER_HOST" -a -n "$XDG_RUNTIME_DIR" ]; then
            export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
        fi
    '';
}