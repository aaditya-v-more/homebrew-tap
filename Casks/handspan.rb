cask "handspan" do
  version "0.1.3"
  sha256 "75fde83abd2d981e78ab3c1ec294a889449a01dfdad7d5134e50275aac7ca6d2"

  url "https://tinkerfold.com/download/handspan/#{version}/Handspan-#{version}-mac.zip"
  name "Handspan"
  desc "Uses one keyboard and mouse on other devices over Bluetooth"
  homepage "https://tinkerfold.com/handspan"

  depends_on macos: :ventura

  app "Handspan.app"

  # The app is signed with Tinkerfold's own certificate but not notarised, and
  # macOS refuses a quarantined app that is not notarised. Clearing the
  # attribute Homebrew sets on the download is what a user would otherwise do
  # by hand (Open Anyway).
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Handspan.app"],
        must_succeed: false
  end

  # It lives in the menu bar, so it is usually running; quitting it releases
  # any keys held on a device and gives input back to this Mac.
  uninstall quit: "com.tinkerfold.handspan"

  # Settings (devices, shortcuts, options), logs and crash reports.
  zap trash: [
    "~/Library/Logs/DiagnosticReports/Handspan-*.ips",
    "~/Library/Logs/Handspan",
    "~/Library/Preferences/com.tinkerfold.handspan.plist",
  ]
end
