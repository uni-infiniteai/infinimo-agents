#!/usr/bin/env bash
set -euo pipefail

BRANDNAMES="${1:?Usage: query.sh <brandNames>}"
API_KEY="${INFINIMO_API_KEY:?Set the INFINIMO_API_KEY environment variable}"

_KEYS='["brandNames"]'
_REQUIRED='["brandNames"]'
PAYLOAD=$(KEYS="$_KEYS" REQUIRED="$_REQUIRED" python3 - "${BRANDNAMES}" <<'PY'
import json, os, sys
keys = json.loads(os.environ["KEYS"])
required = set(json.loads(os.environ["REQUIRED"]))
vals = sys.argv[1:]
body = {}
for k, v in zip(keys, vals):
    v = (v or "").strip()
    if not v:
        if k in required:
            raise SystemExit(f"{k} must not be empty")
        continue
    body[k] = v
print(json.dumps(body, ensure_ascii=False))
PY
)

curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/brand/detail" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "$PAYLOAD"
