cask "lingveil" do
  version "0.2.5"
  sha256 "898163a0c0090b2169801195c9c8661d6bee3d4c367a94c5fa606c994b8f9b90"

  url "https://tinkerfold.com/download/lingveil/#{version}/Lingveil-#{version}-mac.zip"
  name "Lingveil"
  desc "Translates text on screen in place, matching each app's colors and type"
  homepage "https://tinkerfold.com/#lingveil"

  depends_on macos: :sequoia

  app "Lingveil.app"

  # The app is signed with an Apple Development certificate but not notarised,
  # and macOS refuses a quarantined app that is not notarised. Clearing the
  # attribute Homebrew sets on the download is what a user would otherwise type
  # by hand.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Lingveil.app"],
        must_succeed: false
  end

  # It lives in the menu bar, so it is usually running. Its text recognition,
  # model server and voice helpers end on their own once it quits.
  uninstall quit: "com.aadityavmore.lingveil"

  # Downloaded translation models and voices (these run to gigabytes), the voice
  # plugin registrations and list, settings including any Google Cloud or DeepL
  # key, download caches and crash reports. A voice plugin's own files belong to
  # whatever installed it.
  zap trash: [
    "~/Library/Application Support/CrashReporter/Lingveil_*.plist",
    "~/Library/Application Support/Lingveil",
    "~/Library/Caches/com.aadityavmore.lingveil",
    "~/Library/HTTPStorages/com.aadityavmore.lingveil",
    "~/Library/Logs/DiagnosticReports/Lingveil-*.ips",
    "~/Library/Preferences/com.aadityavmore.lingveil.plist",
  ]
end
