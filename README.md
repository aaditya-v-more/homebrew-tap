# aaditya-v-more/tap

[![Support this on Ko-fi](https://img.shields.io/badge/Ko--fi-support%20this-FF5E5B?logo=kofi&logoColor=white)](https://ko-fi.com/aadityavmore)

A Homebrew tap for my own tools.

    brew tap aaditya-v-more/tap

Or name it inline and skip the tap step:

    brew install aaditya-v-more/tap/<name>

## What's here

| | |
| --- | --- |
| [claude-ollama](https://github.com/aaditya-v-more/claude-ollama) (cask) | Runs Claude Desktop against a local Ollama gateway — environment overrides for the retry, concurrency and context-window settings a small self-hosted endpoint needs, plus a pacing proxy that keeps in-flight requests under the gateway's limit. |
| [earmark](https://github.com/aaditya-v-more/earmark) (cask) | A small reader for EPUB, PDF and text that reads books aloud, highlighting the sentence and the word being spoken. Works with system voices and plugin TTS engines. |
| [google-tts-local](https://github.com/aaditya-v-more/google-tts-local) (formula) | Runs Google's on-device text-to-speech voices locally on Apple Silicon, with a CLI and optional HTTP server. |

Each entry is built from its own repository; this one holds only the formulae
and casks. Bugs and feature requests belong on the source repository, anything
about the packaging itself here.

## Trust

Homebrew asks you to trust a tap the first time you install from it, because a
tap can run code of its own at install time and this is not an official
Homebrew tap. Answering once covers this tap by name, including anything added
to it later; `brew trust --tap aaditya-v-more/tap` does the same up front.

What runs at install time is visible in the files here. For the casks that is
one line each: `claude-ollama` and `earmark` each clear the quarantine
attribute from the app Homebrew just downloaded. Those apps are ad-hoc signed
rather than notarised, and macOS
refuses to open a quarantined app that is not notarised, so without it every
install would end with the user typing `xattr -dr` by hand. Nothing about the
app's signing changes.

The `google-tts-local` formula builds from source and ad-hoc signs the engine
helper with Apple's custom x18 ABI and hypervisor entitlements. The helper is
not notarised. The formula does not include or download Google engine or voice
files at install time; run `gtts fetch` separately.

## Supporting it

Everything here is free and staying that way. If it saved you the trouble,
there's a [tip jar](https://ko-fi.com/aadityavmore).
