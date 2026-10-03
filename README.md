# agentsphere agents

Subagents for AI coding tools, installable with the [agentsphere CLI](https://github.com/nikoz99/agentsphere/tree/main/cli).

```sh
npx agentsphere add nikoz99/agentsphere-agents
```

Installs into Claude Code, Cursor, Codex, OpenCode, Gemini CLI and GitHub Copilot.

## Agents

| Agent | What it does |
| --- | --- |
| [spell-check](agents/spell-check.md) | Finds spelling mistakes and typos in prose, comments, docs and UI strings |
| [humanizer](agents/humanizer.md) | Finds AI-sounding prose in docs and suggests rewrites, using the [humanizer skill](https://github.com/blader/humanizer) |

## Adding an agent

Add a Markdown file to `agents/` with `name` and `description` frontmatter, then the instructions as the body.

## Credits

See [CREDITS.md](CREDITS.md) for third-party work the agents use.
