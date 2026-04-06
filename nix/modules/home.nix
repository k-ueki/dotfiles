{ pkgs, ... }: {
  home.username = "s11308";
  home.homeDirectory = "/Users/s11308";
  home.stateVersion = "24.05";

  # まずは brew と重複しない小さいものから試す
  home.packages = with pkgs; [
    # 検索・ファイル操作
    ripgrep
    fd
    fzf
    bat
    tree
    unzip
    watch
    procs

    # Git
    git
    gh
    lazygit
    difftastic

    # エディタ
    neovim

    # データ処理
    jq

    # ネットワーク・HTTP
    curl

    # クラウド・インフラ
    awscli2
    kubectl
    kubectx
    k9s
    terraform

    # 言語・ランタイム管理
    go
    python3

    # ビルド・開発ツール
    protobuf

    # その他
    tmux
    tldr
    wget
  ];

  programs.home-manager.enable = true;
}
