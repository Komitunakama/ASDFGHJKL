# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
   enable = true;
   efiSupport = true;
   device = "nodev";
   useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  
  services.xserver.enable = true;
  
  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm = {
  enable = true;
  greeters.gtk.enable = true;
  };
  services.xserver.displayManager.lightdm.background = "/etc/WALLPAPERDOLIGHTDM/nix-wallpaper-nineish-dark-gray.png";
  services.xserver.desktopManager.xfce.enable = true;

  environment.xfce.excludePackages = with pkgs; [
  ristretto
  parole
  xfce4-taskmanager
  xfce4-icon-theme
];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.enzo = {
    isNormalUser = true;
    description = "enzo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.dbus.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     unzip
     wget
     #flatpak
     corectrl
     vim
     neovim
     fastfetch
     imagemagick
     alacritty
     zapzap
     ffmpeg
     papirus-icon-theme
     git
     mpv
     btop
     xdg-desktop-portal-gtk
     gcc
     keepassxc
     xclip
     gparted
     xfce4-whiskermenu-plugin
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  #
 
programs.bash = {
  enable = true;

  shellAliases = {
    ls = "ls -lah --color=auto";
    clear = "clear && fastfetch";
  };

  interactiveShellInit = ''
    fastfetch
  '';
};

 # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  fileSystems."/mnt/NEGao" = {
  device = "/dev/disk/by-uuid/99f0363f-a459-4d7d-8347-082b91f8399d";
  fsType = "ext4";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.flatpak.enable = false;
  #services.flatpak.enable = true;

xdg.portal = {
  enable = true;
  extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal
  ];
};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # Samba / SMB

 services.samba.enable = false;
   services.samba-wsdd.enable = false;

   programs.gamemode.enable = true;
   services.udisks2.enable = true;
   services.gvfs.enable = true;
   programs.appimage.enable = true;
   programs.appimage.binfmt = true;
   
   # Impressão
   
   services.avahi.enable = false;
   systemd.sockets.cups.enable = false;

   # Scanner (se existir)
   hardware.sane.enable = false;
  
  system.stateVersion = "25.11"; # Did you read the comment?
  
  programs.steam.enable = true;
  hardware.graphics.enable32Bit = true; 
}
