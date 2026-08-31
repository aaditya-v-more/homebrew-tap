# Homebrew tap for claude-ollama

    brew install aaditya-v-more/claude-ollama/claude-ollama
    claude-ollama install-app

[claude-ollama](https://github.com/aaditya-v-more/claude-ollama) runs Claude
Desktop against a local Ollama gateway: environment overrides for the retry,
concurrency and context-window settings a small self-hosted endpoint needs,
plus a pacing proxy that keeps in-flight requests under the gateway's limit and
repairs the context windows and the double-slashed model URL it reports.

Homebrew asks you to trust the formula the first time, because a tap can run
code of its own at install time and this one is not an official Homebrew tap.
Answer it once and it is remembered by name.
`brew trust --tap aaditya-v-more/claude-ollama` covers anything else added here
later.

## What the formula runs at install time

`Tools/make-app.sh`, from the source tarball, which assembles
`Claude (Ollama).app` inside the keg — an `Info.plist`, an icon and a shell
script that calls `claude-ollama run`. It is a Dock icon with no logic of its
own, and it is built rather than shipped so the path to the installed wrapper
can be baked into it.

Nothing is written outside the keg. `claude-ollama install-app` is what links
the bundle into `~/Applications`, and it is left for you to run.

## Everything else

The tuning, the proxy's flags, verification and uninstall are documented in the
[source repository](https://github.com/aaditya-v-more/claude-ollama).
