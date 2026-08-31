# aaditya-v-more/tap

A Homebrew tap for my own tools.

    brew tap aaditya-v-more/tap

Or name it inline and skip the tap step:

    brew install aaditya-v-more/tap/<name>

## What's here

| | |
| --- | --- |
| [claude-ollama](https://github.com/aaditya-v-more/claude-ollama) | Runs Claude Desktop against a local Ollama gateway — environment overrides for the retry, concurrency and context-window settings a small self-hosted endpoint needs, plus a pacing proxy that keeps in-flight requests under the gateway's limit. |

Each entry is built from its own repository; this one holds only the formulae
and casks. Bugs and feature requests belong on the source repository, anything
about the packaging itself here.

## Trust

Homebrew asks you to trust a tap the first time you install from it, because a
tap can run code of its own at install time and this is not an official
Homebrew tap. Answering once covers this tap by name, including anything added
to it later; `brew trust --tap aaditya-v-more/tap` does the same up front.

What runs at install time is visible in the formula files here. At the moment
that is one line: `claude-ollama` builds its `Claude (Ollama).app` launcher
inside the keg, so the path to the installed wrapper can be baked into it.
Nothing is written outside the keg — linking that bundle into `~/Applications`
is a separate command you run yourself.
