# Claude Code on Devin

A Devin plugin that lets Devin delegate coding tasks to Claude Code as a subagent, using your own Claude subscription or Anthropic API key.

It runs the unmodified Claude Code CLI on the session machine. Not made or endorsed by Anthropic.

## Contents

- `.devin-plugin/plugin.json`: the plugin manifest, including the setup steps shown on the install form.
- `server/launch.sh`: starts the MCP server. It finds Node.js first, because Devin starts MCP servers from a shell that does not load version managers such as nvm.
- `server/server.mjs`: the MCP server that starts, polls, resumes and cancels Claude Code runs.
- `rules/using-claude-code-subagent.md`: guidance for Devin on when and how to delegate.

## Requirements

Node.js 22 or later on the session machine. Claude Code is fetched with `npx` on first use unless it is already installed.
