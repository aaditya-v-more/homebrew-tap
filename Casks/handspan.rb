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

  # Finder can give the running app a UUID-suffixed launch label that Homebrew doesn't match.
  # TERM follows Handspan's normal quit path and releases held keys before removal.
  uninstall early_script: {
    executable: "/bin/sh",
    args:       ["-s", "--", "#{appdir}/Handspan.app/Contents/MacOS/Handspan"],
    input:      <<~'SH',
      executable=$1
      [ -f "$executable" ] || exit 0

      is_installed_copy() {
        running=$(/bin/ps -ww -p "$1" -o comm= 2>/dev/null) || return 1
        [ "$running" -ef "$executable" ]
      }

      candidates=$(/usr/bin/pgrep -x -u "$(/usr/bin/id -u)" Handspan) || {
        [ "$?" -eq 1 ] && exit 0
        exit 1
      }
      for pid in $candidates; do
        is_installed_copy "$pid" || continue
        kill -TERM "$pid" || { is_installed_copy "$pid" && exit 1; }
        tries=0
        while is_installed_copy "$pid"; do
          if [ "$tries" -ge 50 ]; then
            echo "Handspan is still running. Choose Quit Handspan and retry." >&2
            exit 1
          fi
          /bin/sleep 0.1
          tries=$((tries + 1))
        done
      done
      exit 0
    SH
  }

  # Settings (devices, shortcuts, options), logs and crash reports.
  zap trash: [
    "~/Library/Logs/DiagnosticReports/Handspan-*.ips",
    "~/Library/Logs/Handspan",
    "~/Library/Preferences/com.tinkerfold.handspan.plist",
  ]
end
