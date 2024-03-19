{ inputs, pkgs, ...}:
let 
  hyprPkgFromFlake = inputs.hyprland.packages.${pkgs.system}.hyprland;
in
{
  # https://wiki.hyprland.org/nix/hyprland-on-nixos/
  # 需要在 flake.nix 中添加 hyprland 源
  programs.hyprland = {
    enable = true;
    package = hyprPkgFromFlake;
    xwayland.enable = true;
  };

  #services.xserver.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        #command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
        #command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${hyprPkgFromFlake}/share/wayland-sessions";
        user = "physails"; 
      };	
    };
  };
}

