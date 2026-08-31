cask "claude-ollama" do
  version "1.1.0"
  sha256 "fe357c349e15d09e76b6e41209ec2f5be18a654e55773620465f24e241e628f7"

  url "https://github.com/aaditya-v-more/claude-ollama/releases/download/v#{version}/ClaudeOllama-#{version}.zip",
      verified: "github.com/aaditya-v-more/claude-ollama/"
  name "Claude (Ollama)"
  desc "Runs Claude Desktop against a local Ollama gateway, paced and untouched"
  homepage "https://github.com/aaditya-v-more/claude-ollama"

  depends_on macos: :big_sur

  # The app is a launcher with no logic of its own: a Dock icon that calls
  # claude-ollama. Installing it as an app rather than leaving it in the keg is
  # the point — it has to be somewhere Launchpad and Spotlight will find it.
  app "Claude (Ollama).app"
  binary "bin/claude-ollama"
  binary "bin/claude-ollama-pace"

  # Homebrew quarantines everything it downloads and, since Homebrew 6, offers
  # no way to ask it not to. This bundle is a shell script and an icon with no
  # signature at all, so macOS refuses a quarantined copy outright and every
  # user would otherwise have to clear the attribute by hand before the first
  # launch. This is the same thing they would type, done once at install time
  # and visible here, under the trust `brew trust` already asked for.
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
  ]

  caveats <<~EOS
    Claude (Ollama) is now in your Applications folder. It drives an existing
    Claude Desktop install at /Applications/Claude.app and an Ollama gateway on
    127.0.0.1:11435 — it installs neither.

      claude-ollama doctor          check both, and everything in between
      claude-ollama config --init   write a settings file the app reads too

    The bundle is a shell script and an icon with no Apple signature, so this
    cask clears the quarantine attribute Homebrew sets on its download. Nothing
    else about it changes.
  EOS
end
