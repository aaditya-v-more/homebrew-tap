cask "earmark" do
  version "0.5.0"
  sha256 "b3e79291cc4ea2fe966f35157247fa8564ce697f9a6a66ccfe5bf01a5c72c91b"

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
