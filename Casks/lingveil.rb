cask "lingveil" do
  version "0.1.1"
  sha256 "50d4becdf4c5af4e4bb5e3d95655206c1f21464920db1c66684e9459140d9e6b"

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
  # plugin list, settings including any Google Cloud or DeepL key, download
  # caches and crash reports. Not Google voices: those belong to the
  # google-tts-local formula, which Earmark uses too.
  zap trash: [
    "~/Library/Application Support/CrashReporter/Lingveil_*.plist",
    "~/Library/Application Support/Lingveil",
    "~/Library/Caches/com.aadityavmore.lingveil",
    "~/Library/HTTPStorages/com.aadityavmore.lingveil",
    "~/Library/Logs/DiagnosticReports/Lingveil-*.ips",
    "~/Library/Preferences/com.aadityavmore.lingveil.plist",
  ]
end
