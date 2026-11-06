# Infinimo Agents

## About Infinimo

**Infinimo** is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets. Hand the repetitive work of research, analysis, content, and operations to Infinimo, and keep judgment and creativity for yourself.

Website: [https://infinimo.ai/?source=q-github-agent](https://infinimo.ai/?source=q-github-agent)

## This Repository

**Infinimo Agents** is the open-source Agent repository for Infinimo: **AI Agent** definitions and install scripts for cross-border e-commerce. Each Agent understands the business request, calls platform APIs under `.infinimo/skills/`, and returns results in a consistent format. Install into Cursor, Claude Code, and other mainstream AI coding tools.

The skills cover **Amazon / TikTok / Shopee / Ozon**: **91** API skills in total (product research, rankings, trends, details, traffic keywords, creators, live, brands, and more).

## Agents

Aligned with the default in-product assistants (chat entry includes `item_id`):

| Agent | Description | Skills | In-product chat | Definition |
|-------|-------------|--------|-----------------|------------|
| **infinimo-amazon** | Amazon: product research, ABA/keywords, category concentration, competitors, ASIN detail/trend/forecast/reviews, traffic analysis | 20 | [/chat?item_id=a7111554-68ee-4e90-bfc7-bb2e14d7a9c3&source=q-github-agent](https://infinimo.ai/chat?item_id=a7111554-68ee-4e90-bfc7-bb2e14d7a9c3&source=q-github-agent) | [agents/infinimo-amazon/AGENT.md](agents/infinimo-amazon/AGENT.md) |
| **infinimo-tiktok** | TikTok: products, shops, creators, live, video, category market, and bestseller/new-product rankings | 33 | [/chat?item_id=34b45822-8376-40d0-ab03-f408e7c9f72b&source=q-github-agent](https://infinimo.ai/chat?item_id=34b45822-8376-40d0-ab03-f408e7c9f72b&source=q-github-agent) | [agents/infinimo-tiktok/AGENT.md](agents/infinimo-tiktok/AGENT.md) |
| **infinimo-shopee** | Shopee: product, shop, brand, and hot-keyword search, rankings, trends, and details | 21 | [/chat?item_id=f78a4cc6-2f07-43fa-a703-1fe97dbedc32&source=q-github-agent](https://infinimo.ai/chat?item_id=f78a4cc6-2f07-43fa-a703-1fe97dbedc32&source=q-github-agent) | [agents/infinimo-shopee/AGENT.md](agents/infinimo-shopee/AGENT.md) |
| **infinimo-ozon** | Ozon: category, product, shop, brand, and keyword rankings, details, trend snapshots, and traffic keywords | 17 | [/chat?item_id=94745faf-20e5-4a38-b027-9f180a2e3084&source=q-github-agent](https://infinimo.ai/chat?item_id=94745faf-20e5-4a38-b027-9f180a2e3084&source=q-github-agent) | [agents/infinimo-ozon/AGENT.md](agents/infinimo-ozon/AGENT.md) |

## Repository Layout

```text
infinimo-agents/
├── README.md
├── agents/                    # Agent source definitions
│   └── infinimo-<agent-name>/AGENT.md
├── skills/                    # Infinimo API skills (synced to .infinimo/skills/ on install)
│   └── infinimo-<skill-name>/SKILL.md
└── scripts/install.sh
```

---

## Install and Use

### Supported Tools

| Tool | Output | Install command |
|------|--------|-----------------|
| **Cursor** | `.cursor/skills/<agent>/SKILL.md` | `./scripts/install.sh --tool cursor .` |
| **Claude Code** | `.claude/agents/*.md` (optional `--global` → `~/.claude/agents/`) | `./scripts/install.sh --tool claude-code .` |
| **Codex** | `.agents/skills/<agent>/SKILL.md` | `./scripts/install.sh --tool codex .` |
| **GitHub Copilot** | `~/.github/agents/` + `~/.copilot/agents/` | `./scripts/install.sh --tool copilot .` |
| **Antigravity** | `~/.gemini/antigravity/skills/infinimo-<agent>/` | `./scripts/install.sh --tool antigravity .` |
| **Gemini CLI** | `~/.gemini/extensions/infinimo-agents/` | `./scripts/install.sh --tool gemini-cli .` |
| **OpenCode** | `.opencode/agents/` | `./scripts/install.sh --tool opencode .` |
| **Aider** | `./CONVENTIONS.md` | `./scripts/install.sh --tool aider .` |
| **Windsurf** | `./.windsurfrules` | `./scripts/install.sh --tool windsurf .` |
| **OpenClaw** | `~/.openclaw/infinimo-agents/<agent>/` | `./scripts/install.sh --tool openclaw .` |
| **Qwen Code** | `.qwen/agents/` | `./scripts/install.sh --tool qwen .` |
| **Kimi Code** | `~/.config/kimi/agents/<agent>/` | `./scripts/install.sh --tool kimi .` |

Interactive multi-tool install (detects tools already on this machine):

```bash
./scripts/install.sh --tool all
# non-interactive: ./scripts/install.sh --no-interactive --tool all
# parallel:        ./scripts/install.sh --no-interactive --tool all --parallel
```

Unless `--rules-only` is set, every install syncs this repo's **`skills/`** into the target project's **`.infinimo/skills/`** (API docs; links inside Agents are rewritten to that path). Copilot / Antigravity / Gemini CLI / Kimi / OpenClaw Agent files are installed in the user directory. Cursor / Claude Code / Codex / OpenCode / Qwen / Aider / Windsurf install into the **project directory** (the `.` or path at the end of the command).

**Quick install:**

```bash
git clone https://github.com/uni-infiniteai/infinimo-agents.git
cd your-ecommerce-project

# Cursor
/path/to/infinimo-agents/scripts/install.sh --tool cursor .

# Claude Code
/path/to/infinimo-agents/scripts/install.sh --tool claude-code .
```

One-liner install:

```bash
export INFINIMO_SKILLS_GIT="https://github.com/uni-infiniteai/infinimo-agents.git"
curl -fsSL https://raw.githubusercontent.com/uni-infiniteai/infinimo-agents/main/scripts/install.sh | bash -s -- --tool claude-code .
```

Update Agent definitions only (when `.infinimo/skills/` already exists): `./scripts/install.sh --tool <tool> . --rules-only`

### Prerequisites

- macOS / Linux / WSL with `bash`
- Run the install from the **project root** (`.` or your project path in the command)
- An **Infinimo API key** is configured (see below)

### API Key and Environment Variables

Every call under `.infinimo/skills/` needs an Infinimo API key. Agents and scripts read **`INFINIMO_API_KEY`**. Do not put the key in code or commit it to git.

#### 1. Get a key

1. Open the [Infinimo sign-up page](https://infinimo.ai/?source=q-github-agent) and create an account
2. After login, open the [API Key page](https://infinimo.ai/api-key?source=q-github-agent) and create or copy a key

#### 2. Set the environment variable

**Current shell session (temporary):**

```bash
export INFINIMO_API_KEY="your-key"
```

**Persistent (recommended, macOS / Linux zsh):**

```bash
echo 'export INFINIMO_API_KEY="your-key"' >> ~/.zshrc
source ~/.zshrc
```

## License

This project is licensed under the [MIT License](https://github.com/uni-infiniteai/infinimo-agents?tab=MIT-1-ov-file#readme).
