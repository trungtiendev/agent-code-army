#!/bin/bash
# setup.sh — Bootstrap script để phục hồi Agent Code Army
# Dùng khi cài lại OpenClaw hoặc clone repo ra máy mới

set -e

# <!-- FIXED: CR1 — Xác định SKILL_DIR để trỏ đúng vào references/ thay vì agent-army/roles/ -->
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🪷 Agent Code Army — Bootstrap Setup${NC}"
echo ""

# Kiểm tra workspace
WORKSPACE="${HOME}/.openclaw/workspace"
if [ ! -d "$WORKSPACE" ]; then
    echo -e "${YELLOW}⚠ Workspace chưa tồn tại, đang tạo...${NC}"
    mkdir -p "$WORKSPACE"
fi

cd "$WORKSPACE"

# Kiểm tra Git remote
REMOTE=$(git remote get-url origin 2>/dev/null || echo "")
if [ -z "$REMOTE" ]; then
    echo ""
    echo -e "${YELLOW}⚠ Chưa có Git remote.${NC}"
    echo "   Để đồng bộ lên GitHub, chạy:"
    echo "   cd $WORKSPACE"
    echo "   git remote add origin <repo-url>"
    echo "   git push -u origin master"
    echo ""
    echo "   Nếu clone từ GitHub về máy mới:"
    echo "   git clone <repo-url> $WORKSPACE"
    echo ""
fi

# Kiểm tra cấu trúc
echo -e "${GREEN}✓ Đang kiểm tra cấu trúc đội quân...${NC}"

MISSING=0
for role in commander po architect backend frontend tester reviewer devops doc; do
    if [ -f "${SKILL_DIR}/references/${role}-agent.md" ]; then
        echo "  ✓ references/${role}-agent.md"
    else
        echo "  ✗ references/${role}-agent.md — THIẾU"
        MISSING=$((MISSING + 1))
    fi
done

if [ -f "${SKILL_DIR}/SKILL.md" ]; then
    echo "  ✓ SKILL.md"
else
    echo "  ✗ SKILL.md — THIẾU"
    MISSING=$((MISSING + 1))
fi

echo ""
if [ $MISSING -eq 0 ]; then
    echo -e "${GREEN}✅ Đội quân đầy đủ! Sẵn sàng chiến đấu.${NC}"
else
    echo -e "${YELLOW}⚠ Thiếu $MISSING files. Cần clone lại từ GitHub.${NC}"
fi

echo ""
echo "📋 Hướng dẫn:"
echo "  Mở OpenClaw và nói: 'Làm app [tên app]'"
echo "  Hoặc đọc: cat agent-army/README.md"
echo ""
