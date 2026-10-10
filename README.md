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
| [network-check](agents/network-check/AGENT.md) | Checks which outside services the agent can reach, as a test of its network policy |

## Adding an agent

Add a Markdown file to `agents/` with `name` and `description` frontmatter, then the instructions as the body.

An agent that needs a network policy gets its own folder instead: `agents/<name>/AGENT.md` for the agent and `agents/<name>/policy.rego` for the policy.

## Network policy

When agentsphere runs an agent that has a `policy.rego`, every request the agent makes leaves through agentsphere's egress proxy, which checks it against the policy first. An agent without a policy can reach anything.

The policy is [Rego](https://www.openpolicyagent.org/docs/policy-language) in `package egress`. Each `deny` message blocks the request, and the agent gets a `403` with the messages.

```rego
package egress

hosts := {"hacker-news.firebaseio.com", "github.com"}

deny contains $"{input.request.host} is not allowed" if {
	not input.request.host in hosts
}
```

Requests to the model provider are never checked. Requests to GitHub are, so allow `github.com` for the agent to clone and push its repositories, and `api.github.com` for it to open pull requests.

`input.request` has `scheme` (`https`, `http`, or `tcp` for other ports), `host`, `port`, `method`, `path` (with `.` and `..` resolved), `query` (the raw query string) and `headers` (lowercase names). `input.agent` has the agent's `name` and `source`, and `input.organization` the organization running it. Put tests next to the policy in `policy_test.rego` and run them with `opa test agents/<name>`.

## Credits

See [CREDITS.md](CREDITS.md) for third-party work the agents use.
