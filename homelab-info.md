# NixOS/Nix-based Homelab Infrastructure

This is a project that aims to slowly re-implement my entire homelab with Nix-based tooling and SOPS for secrets management. 

Homelab bones:

- N100 Mini PC
    - Proxmox tinker box
    - Runs AdGuard Home, Home Assistant, Tailscale exit node
    - Probably not going to be touched

- HP T620
    - 24/7 networking
    - Really only used as another Tailscale exit node and AdGuard Home
    - Not touching, it's hard to work with and install things on it
    - Runs Debian 12

- 2U Ryzen Home Server
    - Main horsepower
    - 4650G Pro APU
        - Not chiplet design so great idle
        - ECC UDIMM support
        - Okay integrated graphics for transcoding
        - 6 cores 12 threads
        - Limited PCIe lanes
    - ASRock B450M Pro4 R2.0
        - Not a fan of this motherboard
        - Doesn't expose ASPM settings
        - Doesn't let me turn off certain unused devices like the onboard NIC
        - Shitty IOMMU groups
    - AQC-100 10GbE NIC
        - Great ASPM support
        - Gets full speeds
        - Doesn't support old Linux kernels or FreeBSD, works with modern Windows and Linux
    - ASM1166 M.2 to SATA controller
        - Great ASPM support
        - PCIe x4 slot is more than enough speed
        - Many sources say the chipset is reliable
        - By going M.2 I save an entire physical PCIe slota
    - PicoPSU 160W
        - Just enough for my power needs, fits in the small Supermicro chassis

- 2U Dumb Backup Server
    - Exists for basic backups/redundancy on-site
    - J4125B-ITX motherboard
        - Limited I/O
        - Embedded CPU, cools silently
    - Drives spin down when not in use, sips power

Software stack:

- Home server runs ZFS pool of SSDs and separate pool of HDDs
    - 4x2TB Samsung PM883 SSDs for video editing, also holds PDF documents for work
    - Important data I need for reliability
    - ZFS is fast, reliable, cohesive
    - 2x8TB mirrored pool for media
    - None of this data is mission critical
    - I do not bother backing it up
    - Spindown set up to save power
- Home server uses Docker containers and this will not change because of the benefits of containerization
- No VMs = more efficient resource usage and allocation, no passthrough headaches


- Backup system runs ZFS pool as well
    - 2x8TB mirrored pool for backups
        - Backs up SSD array on home server
        - Backs up computers around the house
    - ZFS overkill but I wanted to use the same software stack everywhere

Why NixOS:

- Current setup is a hodgepodge of Alpine and Debian
- Ansible is slow and has a lot of frustrating boilerplate code
    - Ansible is ultimately a "hack" for non-declarative systems
    - I end up "dirtying" my Ansible nodes by installing random pieces of software on a whim
    - I do not want "pets" that I have to back up and preserve
    - Ansible is very *slow*