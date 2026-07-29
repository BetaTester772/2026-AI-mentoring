# 2026 AI 멘토링 — PyTorch 이미지 분류 실습

Fashion-MNIST와 CIFAR-10으로 CNN 이미지 분류의 기초부터 최적화까지 다루는 3주차 실습 노트북입니다.
각 노트북은 독립적으로 실행되며, 데이터는 torchvision이 자동으로 내려받으므로 Drive 마운트나 파일 업로드가 필요 없습니다.

## 노트북

| 주차 | 주제 | 데이터셋 | Colab |
|---|---|---|---|
| 06주차 | 이미지 분류 기초 — 텐서, 로짓, softmax, 학습 전후 비교 | Fashion-MNIST | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/BetaTester772/2026-AI-mentoring/blob/main/06%EC%A3%BC%EC%B0%A8_PyTorch_%EC%9D%B4%EB%AF%B8%EC%A7%80%EB%B6%84%EB%A5%98_%EA%B8%B0%EC%B4%88.ipynb) |
| 07주차 | 모델 구조와 데이터 증강 — 구조 개선·증강 효과 분리 관찰 | CIFAR-10 | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/BetaTester772/2026-AI-mentoring/blob/main/07%EC%A3%BC%EC%B0%A8_PyTorch_CIFAR10_%EB%AA%A8%EB%8D%B8%EA%B5%AC%EC%A1%B0%EC%99%80_%EB%8D%B0%EC%9D%B4%ED%84%B0%EC%A6%9D%EA%B0%95.ipynb) |
| 08주차 | 최적화 — 학습률, 옵티마이저, BatchNorm·Dropout, Early Stopping | CIFAR-10 | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/BetaTester772/2026-AI-mentoring/blob/main/08%EC%A3%BC%EC%B0%A8_PyTorch_%EC%9D%B4%EB%AF%B8%EC%A7%80%EB%B6%84%EB%A5%98_%EC%B5%9C%EC%A0%81%ED%99%94.ipynb) |

## Colab에서 실행하기

위 배지를 클릭한 뒤 **런타임 → 런타임 유형 변경 → T4 GPU**를 선택하세요.
GPU 없이도 실행되지만 학습이 훨씬 오래 걸립니다.

### 예상 실행 시간

| 노트북 | RTX 3090 (실측) | Colab T4 (예상) |
|---|---|---|
| 06주차 | 0.3분 | 2~3분 |
| 07주차 | 4.6분 | 12~18분 |
| 08주차 | 2.6분 | 8~12분 |

07주차가 가장 오래 걸립니다. 세 실험(기준 모델 / 구조 개선 / 데이터 증강)을 각각 22에포크씩 학습하기 때문입니다.

## 로컬에서 실행하기 (uv)

[uv](https://docs.astral.sh/uv/)로 환경을 구성합니다. CUDA GPU 기준입니다.

```bash
uv sync                 # torch(cu128) 포함 의존성 설치
uv run jupyter lab      # 노트북 열기
```

GPU가 없다면 `pyproject.toml`의 `[[tool.uv.index]]`와 `[tool.uv.sources]` 블록을 지우고 `uv sync`를 다시 실행하면 CPU 빌드가 설치됩니다.

노트북을 원본 그대로 둔 채 일괄 실행해 결과 사본만 `outputs/`에 남기려면:

```bash
./run_notebooks.sh                    # 전체 실행
./run_notebooks.sh 06*.ipynb          # 특정 노트북만
```

데이터를 별도 디스크에 두려면 `data`를 심볼릭 링크로 만들어 두면 됩니다.

```bash
ln -s /경로/to/storage ./data
```

## 학습 목표 요약

**06주차** — Fashion-MNIST 흑백 의류 이미지를 텐서로 읽고 CNN으로 10개 클래스를 분류합니다.
학습·검증·테스트 데이터의 역할을 구분하고, 로짓과 softmax 확률·정확도를 관찰합니다.
학습 전 무작위 예측(우연 수준)과 학습 후 예측을 같은 테스트 이미지에서 비교합니다.

**07주차** — 06주차의 `SmallCNN`을 입력 채널만 3으로 바꿔 CIFAR-10에 적용하고,
더 깊은 `ImprovedCNN`과 데이터 증강이 성능에 주는 영향을 비교합니다.
데이터 분할·옵티마이저·학습률·에포크 수를 모두 고정해, 변화의 원인을 "구조"와 "증강"으로만 좁히는 실험 설계를 연습합니다.
증강의 효과는 과적합이 시작된 뒤에야 드러난다는 점도 함께 관찰합니다.

**08주차** — 학습률, 옵티마이저(SGD·Adam), 배치 정규화, 드롭아웃, Early Stopping이 성능에 주는 영향을 순서대로 관찰합니다.
여러 설정을 짧게 비교하는 실험(고정 부분집합 12,000장)과 찾은 설정을 실제 규모로 학습하는 최종 실험(45,000장)을 구분해 진행합니다.
