#!/usr/bin/env bash
# Devin starts MCP servers from a non-interactive login shell. That shell skips
# the ~/.bashrc lines that put a version manager's Node.js on PATH, so a bare
# `node` is not found on a box where Node.js comes from nvm, fnm, volta, asdf
# or mise. Find it, put its directory on PATH (the server also runs `npx` and
# `claude` from there) and start the server.

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v node >/dev/null 2>&1; then
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    # Selects the user's default version.
    . "$NVM_DIR/nvm.sh" >/dev/null 2>&1
  fi
fi

if ! command -v node >/dev/null 2>&1; then
  newest() { ls -d "$@" 2>/dev/null | sort -V | tail -n 1; }
  for dir in \
    "$(newest "$NVM_DIR"/versions/node/*/bin)" \
    "$HOME/.local/share/fnm/aliases/default/bin" \
    "$HOME/.volta/bin" \
    "$HOME/.asdf/shims" \
    "$HOME/.local/share/mise/shims" \
    "$(newest /opt/hostedtoolcache/node/*/*/bin)" \
    "$HOME/.local/bin" \
    /opt/homebrew/bin \
    /usr/local/bin; do
    if [ -n "$dir" ] && [ -x "$dir/node" ]; then
      PATH="$dir:$PATH"
      break
    fi
  done
  export PATH
fi

if ! command -v node >/dev/null 2>&1; then
  echo "Claude Code: Node.js was not found on this machine. Install Node.js 22 or later in the environment's blueprint." >&2
  exit 127
fi

exec node "$here/server.mjs"
