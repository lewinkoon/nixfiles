{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # list packages installed in system profile
  environment.systemPackages = with pkgs; [
    curl
    google-chrome
    hugo
    obsidian
    syncthing
    vscode
  ];

  environment.shells = [ pkgs.zsh ];

  # setup neovim editor
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # setup source control
  programs.git.enable = true;
  programs.git.config.user.name = "lewin";
  programs.git.config.user.email = "lewinkoon+github@gmail.com";
  programs.git.config.init.defaultBranch = "main";


  # setup shell
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.enableLsColors = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.thefuck.enable = true;
  programs.starship.enable = true;

  # setup desktop manager
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.excludePackages = [ pkgs.xterm ];

  environment.gnome.excludePackages = [
    pkgs.gnome.epiphany
    pkgs.gnome.simple-scan
    pkgs.gnome.seahorse
    pkgs.gnome.yelp
    pkgs.gnome.gnome-terminal
    pkgs.gnome-connections
    pkgs.gnome-tour
  ];

  # define a user account
  users.defaultUserShell = pkgs.zsh;
  users.users.lewin = {
    isNormalUser = true;
    description = "Lewin";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # enable networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # set your time zone.
  time.timeZone = "Europe/Madrid";

  # select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # set gpu config
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.nvidia.open = false;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  # setup display manager
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "lewin";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;


  # configure keymap in X11
  services.xserver.xkb.layout = "es";
  services.xserver.xkb.variant = "";

  # configure console keymap
  console.keyMap = "es";

  # enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";

}
