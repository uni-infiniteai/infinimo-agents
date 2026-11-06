#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   query.sh '<json-body>'
#   query.sh @payload.json

INPUT="${1:?Usage: query.sh '<json-body>' or query.sh @payload.json}"
API_KEY="${INFINIMO_API_KEY:?Set the INFINIMO_API_KEY environment variable}"

PAYLOAD=$(INPUT="$INPUT" REQUIRED_KEYS='["period"]' python3 <<'PY'
import json, os
raw = os.environ["INPUT"]
required = json.loads(os.environ["REQUIRED_KEYS"])
if raw.startswith("@"):
    with open(raw[1:], encoding="utf-8") as f:
        body = json.load(f)
else:
    body = json.loads(raw)
if not isinstance(body, dict):
    raise SystemExit("JSON body must be an object")
for k in required:
    if not str(body.get(k, "")).strip():
        raise SystemExit(f"{k} must not be empty")
print(json.dumps(body, ensure_ascii=False))
PY
)

curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/keyword/hot-ranking" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "$PAYLOAD"
