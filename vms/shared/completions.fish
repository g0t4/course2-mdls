
# TODO how do I wanna present this
if not test -f ~/.config/fish/completions/docker.fish
  if not command -q docker
      echo "[WARN]: docker not found, cannot generate fish completions"
      # FYI will use stock completions (if installed)
      # how to tell: docker c<TAB> gives you a few options (3, not including container)
  else
      echo "[INFO]: generating docker completions for fish shell..."
      docker completion fish >~/.config/fish/completions/docker.fish
      # how to tell: docker c<TAB> includes container and 7 more subcommands
  end
end
