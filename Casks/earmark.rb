cask "earmark" do
  version "1.2.1"
  sha256 "3ad4455c5ce6c8d73882e73d403a002c10a72412c6fec1009f62c951b060ed02"

  url "https://tinkerfold.com/download/earmark/#{version}/Earmark.zip"
  name "Earmark"
  desc "Reads EPUB, PDF and text books aloud, highlighting each sentence and word"
  homepage "https://tinkerfold.com/#earmark"

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

  # Unpacked books, plugin settings, the reading position in each book, and the
  # cookies and other HTTP state macOS keeps for the app.
  zap trash: [
    "~/Library/Application Support/Earmark",
    "~/Library/Caches/Earmark",
    "~/Library/Caches/com.aadityavmore.earmark",
    "~/Library/HTTPStorages/com.aadityavmore.earmark",
    "~/Library/Logs/Earmark",
    "~/Library/Preferences/com.aadityavmore.earmark.plist",
    "~/Library/Saved Application State/com.aadityavmore.earmark.savedState",
    "~/Library/WebKit/com.aadityavmore.earmark",
  ]
end
