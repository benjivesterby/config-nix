{ lib
, config
, pkgs
, ...
}:
let
  cfg = config.plusultra.desktop.addons.foot;
in
{
  options.plusultra.desktop.addons.foot = {
    enable = lib.mkEnableOption "Foot";
  };

  config = lib.mkIf cfg.enable {
    plusultra.desktop.addons.term = {
      enable = true;
      package = pkgs.foot;
    };

    plusultra.home.configFile."foot/foot.ini".text = ''
      [main]
      font=Hack Nerd Font Mono:size=13
      #,Noto Color Emoji:size=12
      line-height=14
      underline-offset=2
      pad=2x2 center
      term=xterm-256color

      [scrollback]
      lines=2000

      [cursor]
      blink=yes

      [colors]
      foreground=D8DEE9
      background=2E3440

      regular0=2E3440
      regular1=BF616A
      regular2=A3BE8C
      regular3=EBCB8B
      regular4=81A1C1
      regular5=B48EAD
      regular6=88C0D0
      regular7=E5E9F0

      bright0=4C566A
      bright1=BF616A
      bright2=A3BE8C
      bright3=EBCB8B
      bright4=8FBCBB
      bright5=B48EAD
      bright6=8FBCBB
      bright7=ECEFF4

      [csd]
      size=0
    '';
  };
}
