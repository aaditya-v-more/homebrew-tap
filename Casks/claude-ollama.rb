cask "claude-ollama" do
  version "1.2.1"
  sha256 "5cbbdf5c4e499c2970500746bdc28487a2b4b934ab2ff07d227a2266808dfe4a"

  url "https://github.com/aaditya-v-more/claude-ollama/releases/download/v#{version}/ClaudeOllama-#{version}.zip",
      verified: "github.com/aaditya-v-more/claude-ollama/"
  name "Claude (Ollama)"
  desc "Runs Claude Desktop against a local Ollama gateway, paced and untouched"
  homepage "https://github.com/aaditya-v-more/claude-ollama"

  # The app carries Sparkle and installs its own updates when Claude quits, so
  # Homebrew should not also try. Without this the two race over the bundle and
  # brew reinstalls whatever the tap last named, undoing a newer self-update.
  # `brew upgrade --cask --greedy claude-ollama` still works for anyone who
  # would rather Homebrew did it.
  auto_updates true

  depends_on macos: :big_sur

  # The app starts Claude and then stays in the menu bar showing what the proxy
  # is doing. Installing it as an app rather than leaving it in the keg is the
  # point — it has to be somewhere Launchpad and Spotlight will find it.
  app "Claude (Ollama).app"
  # Both commands live inside the bundle and are symlinked out of it. That is
  # what lets one replaced bundle move all three at once, so the claude-ollama
  # on PATH is never a different version from the app that was opened.
  binary "#{appdir}/Claude (Ollama).app/Contents/Resources/bin/claude-ollama"
  binary "#{appdir}/Claude (Ollama).app/Contents/Resources/bin/claude-ollama-pace"

  # Homebrew quarantines everything it downloads and, since Homebrew 6, offers
  # no way to ask it not to. This bundle is ad-hoc signed rather than notarised
  # — notarising means a paid Apple developer account — and macOS refuses a
  # quarantined app that is not notarised, so every user would otherwise have to
  # clear the attribute by hand before the first launch. This is the same thing
  # they would type, done once at install time and visible here, under the trust
  # `brew trust` already asked for.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Claude (Ollama).app"],
                   must_succeed: false
  end

  # The settings file and the proxy's log. Not the Claude-3p profile: that is
  # Claude Desktop's own folder and holds the chats, so nothing here touches it.
  zap trash: [
    "~/.config/claude-ollama",
    "~/.local/state/claude-ollama-pace.log",
    "~/.local/state/claude-ollama-pace.port",
  ]

  caveats <<~EOS
    Claude (Ollama) is now in your Applications folder. It drives an existing
    Claude Desktop install at /Applications/Claude.app and an Ollama gateway on
    127.0.0.1:11435 — it installs neither.

      claude-ollama doctor          check both, and everything in between
      claude-ollama status          what the proxy is doing right now
      claude-ollama config --init   write a settings file the app reads too

    Opened from the app rather than the terminal, it also puts an item in the
    menu bar with the proxy's port, load and pushback while Claude is running.

    The app is ad-hoc signed rather than notarised, so this cask clears the
    quarantine attribute Homebrew sets on its download. Nothing about its
    signing changes: `spctl` still rejects it.
  EOS
end
