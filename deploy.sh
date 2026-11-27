#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-$(git rev-parse --short HEAD)}"
IMAGE="localhost:5000/pagosya-api:$TAG"

docker build --build-arg APP_VERSION="$TAG" -t "$IMAGE" app/
docker push "$IMAGE"
TAG="$TAG" docker compose up -d

for i in $(seq 1 30); do
  if curl -fsS localhost:8080/ >/dev/null 2>&1; then
    echo "$TAG" > .last-good
    echo "OK $TAG"
    exit 0
  fi
  sleep 0.5
done

echo "smoke falló con $TAG" >&2
if [ -f .last-good ]; then
  TAG="$(cat .last-good)" docker compose up -d
  echo "vuelto a $(cat .last-good)" >&2
fi
exit 1
