#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   query.sh '<json-body>'
#   query.sh @payload.json
# JSON must include at least marketplace

INPUT="${1:?Usage: query.sh '<json-body>' or query.sh @payload.json}"
API_KEY="${INFINIMO_API_KEY:?Set the INFINIMO_API_KEY environment variable}"

PAYLOAD=$(INPUT="$INPUT" python3 <<'PY'
import json, os
raw = os.environ["INPUT"]
if raw.startswith("@"):
    with open(raw[1:], encoding="utf-8") as f:
        body = json.load(f)
else:
    body = json.loads(raw)
if not str(body.get("marketplace", "")).strip():
    raise SystemExit("marketplace must not be empty")
body["marketplace"] = str(body["marketplace"]).strip().upper()
print(json.dumps(body, ensure_ascii=False))
PY
)

curl -s -X POST "https://infinimo.ai/api/aigc/ec/amazon/data/product/research" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "$PAYLOAD"
