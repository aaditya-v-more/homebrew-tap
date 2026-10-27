cask "earmark" do
  version "0.4.0"
  sha256 "d0367cf28191ee8244b50b398ce24518f23ecdb2ddffd772ee8881a31413b489"

  url "https://github.com/aaditya-v-more/earmark/releases/download/v#{version}/Earmark.zip"
  name "Earmark"
  desc "Reads EPUB, PDF and text books aloud, highlighting each sentence and word"
  homepage "https://github.com/aaditya-v-more/earmark"

  depends_on macos: :sonoma

  app "Earmark.app"

  # The app is ad-hoc signed rather than notarised, and macOS refuses a
  # quarantined app that is not notarised. Clearing the attribute Homebrew sets
  # on the download is what a user would otherwise type by hand.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Earmark.app"],
        must_succeed: false
  end

  # Unpacked books, plugin settings, and the reading position in each book.
  zap trash: [
    "~/Library/Application Support/Earmark",
    "~/Library/Caches/Earmark",
    "~/Library/Preferences/com.aadityavmore.earmark.plist",
  ]
end
