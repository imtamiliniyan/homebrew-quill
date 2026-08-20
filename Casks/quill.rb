cask "quill" do
  version "0.8.0"
  sha256 "5d0747ab0a0a82f1f837ca76c3176a7b2d9c0a90e15c389c237572c56efeb3da"

  url "https://github.com/imtamiliniyan/quill/releases/download/v#{version}/Quill.OSS.#{version}.dmg"
  name "Quill"
  desc "Free, local-first dictation for macOS — speak, and it's typed"
  homepage "https://iniyan.pro/quill"

  # Quill isn't notarized (no Apple Developer Program enrollment yet), so a
  # browser-downloaded copy gets Gatekeeper's hard "cannot verify" block
  # with no override option. Homebrew Cask installs don't carry that same
  # quarantine friction, since brew itself is the trusted delivery
  # mechanism, not an arbitrary browser download — this is the actual
  # reason this tap exists rather than just linking the .dmg directly.
  app "Quill.app"

  # `brew uninstall --zap --cask quill` — for anyone who wants a clean
  # removal, not just the app bundle itself.
  zap trash: [
    "~/Library/Application Support/Quill",
    "~/Library/LaunchAgents/com.tamiliniyan.quill.plist",
    "~/Library/Caches/com.tamiliniyan.quill",
    "~/Library/HTTPStorages/com.tamiliniyan.quill",
  ]
end
