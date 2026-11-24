cask "toldit" do
  version "2.2.0"
  sha256 "b4b66ea45d9b02493c571b9009e7f89b14774f56167d8d5bdefd17a214827cea"

  url "https://tinkerfold.com/download/toldit/#{version}/ToldIt.zip"
  name "ToldIt"
  name "Earmark"
  desc "Reads EPUB, PDF and text books aloud, highlighting each sentence and word"
  homepage "https://tinkerfold.com/toldit"

  depends_on macos: :sonoma

  app "ToldIt.app"

  # The app is ad-hoc signed rather than notarised, and macOS refuses a
  # quarantined app that is not notarised. Clearing the attribute Homebrew sets
  # on the download is what a user would otherwise type by hand.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/ToldIt.app"],
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
