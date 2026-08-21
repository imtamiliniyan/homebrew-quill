cask "quill" do
  version "0.9.0"
  sha256 "bee6e95956674382c0f807b6008850eef203812b9d6a3f889e6aec279fccfc7a"

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
