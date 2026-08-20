# homebrew-quill

Homebrew tap for [Quill](https://github.com/imtamiliniyan/quill), a free, local-first dictation app for macOS.

## Install

```bash
brew install --cask imtamiliniyan/quill/quill
```

This is the recommended way to install Quill: Quill isn't notarized yet (no Apple Developer Program enrollment), so a `.dmg` downloaded directly from a browser gets blocked by Gatekeeper with no override option. Installing via Homebrew avoids that entirely.

## Uninstall

```bash
brew uninstall --cask quill
```

Add `--zap` to also remove dictation history, settings, and downloaded models (`~/Library/Application Support/Quill`) and the launch-at-login registration.
