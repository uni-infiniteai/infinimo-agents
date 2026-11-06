#!/usr/bin/env bash
set -euo pipefail

REGION="${1:?Usage: query.sh <region> [category_id] [author_product_type]}"
CATEGORY_ID="${2:-}"
AUTHOR_PRODUCT_TYPE="${3:-}"
API_KEY="${INFINIMO_API_KEY:?Set the INFINIMO_API_KEY environment variable}"

_KEYS='["region", "category_id", "author_product_type"]'
_REQUIRED='["region"]'
PAYLOAD=$(KEYS="$_KEYS" REQUIRED="$_REQUIRED" python3 - "${REGION}" "${CATEGORY_ID}" "${AUTHOR_PRODUCT_TYPE}" <<'PY'
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

curl -s -X POST "https://infinimo.ai/api/aigc/ec/tiktok/data/creator/rank/top_ecommerce" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "$PAYLOAD"
