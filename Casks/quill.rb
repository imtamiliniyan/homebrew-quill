cask "quill" do
  version "0.11.2"
  sha256 "b33091fe87d175bb5a722cd88ca1e0f01ef305b6b32e4402fc3f5f4107fbd75a"

  url "https://github.com/imtamiliniyan/quill/releases/download/v#{version}/Quill.OSS.#{version}.dmg"
  name "Quill"
  desc "Free, local-first dictation for macOS — speak, and it's typed"
  homepage "https://iniyan.pro/quill"

  # Quill isn't notarized (no Apple Developer Program enrollment yet), so a
  # browser-downloaded copy gets Gatekeeper's hard "cannot verify" block
  # with no override option — confirmed directly: com.apple.quarantine
  # survives brew's own download-and-copy path too (`cp`/`ditto` preserve
  # xattrs by default), so a plain `app "Quill.app"` stanza alone still
  # left the installed copy quarantined and `spctl --assess` rejecting it.
  # The postflight below is the actual fix, not the cask mechanism itself.
  app "Quill.app"

  postflight do
    system_command "/usr/bin/xattr",
                    args: ["-dr", "com.apple.quarantine", "#{appdir}/Quill.app"],
                    sudo: false
  end

  # `brew uninstall --zap --cask quill` — for anyone who wants a clean
  # removal, not just the app bundle itself.
  zap trash: [
    "~/Library/Application Support/Quill",
    "~/Library/LaunchAgents/com.tamiliniyan.quill.plist",
    "~/Library/Caches/com.tamiliniyan.quill",
    "~/Library/HTTPStorages/com.tamiliniyan.quill",
  ]
end
