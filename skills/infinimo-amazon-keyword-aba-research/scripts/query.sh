#!/usr/bin/env bash
set -euo pipefail

MARKETPLACE="${1:?Usage: query.sh <marketplace> [includeKeywords] [date]}"
INCLUDEKEYWORDS="${2:-}"
DATE="${3:-}"
API_KEY="${INFINIMO_API_KEY:?Set the INFINIMO_API_KEY environment variable}"

_KEYS='["marketplace", "includeKeywords", "date"]'
_REQUIRED='["marketplace"]'
PAYLOAD=$(KEYS="$_KEYS" REQUIRED="$_REQUIRED" python3 - "${MARKETPLACE}" "${INCLUDEKEYWORDS}" "${DATE}" <<'PY'
import json, os, sys
keys = json.loads(os.environ["KEYS"])
required = set(json.loads(os.environ["REQUIRED"]))
vals = sys.argv[1:]
body = {}
date_keys = {"month", "date", "historyDate", "availableMonth"}
for k, v in zip(keys, vals):
    v = (v or "").strip()
    if not v:
        if k in required:
            raise SystemExit(f"{k} must not be empty")
        continue
    if k == "marketplace":
        v = v.upper()
    if k in date_keys and (len(v) != 6 or not v.isdigit()):
        raise SystemExit(f"{k} must be yyyyMM, for example 202507")
    body[k] = v
print(json.dumps(body, ensure_ascii=False))
PY
)

curl -s -X POST "https://infinimo.ai/api/aigc/ec/amazon/data/keyword/aba_research" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "$PAYLOAD"
