#!/usr/bin/env bash
# 노트북을 원본은 그대로 둔 채 실행하고, 결과가 담긴 사본을 outputs/에 저장합니다.
# 사용법: ./run_notebooks.sh            (전체 실행)
#         ./run_notebooks.sh 06*.ipynb  (특정 노트북만)
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p outputs

targets=("$@")
if [ ${#targets[@]} -eq 0 ]; then
  targets=(0*.ipynb)
fi

for nb in "${targets[@]}"; do
  echo "=== 실행: $nb ==="
  uv run jupyter nbconvert \
    --to notebook --execute \
    --ExecutePreprocessor.timeout=7200 \
    --output-dir outputs \
    --output "$(basename "${nb%.ipynb}")_executed.ipynb" \
    "$nb"
done
echo "완료. 결과: outputs/"
