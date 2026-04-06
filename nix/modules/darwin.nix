{ pkgs, ... }: {
  # Determinate Nix を使用しているため nix-darwin の Nix 管理を無効化
  nix.enable = false;

  # システムで使うシェル（/etc/zshrc に per-user profile の PATH を追加）
  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = ''
    export PATH="/etc/profiles/per-user/$USER/bin:$PATH"
  '';

  users.users.s11308 = {
    name = "s11308";
    home = "/Users/s11308";
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 5;
}
