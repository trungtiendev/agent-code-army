# 🎒 BACKPACK.md — Ký Ức Đội Quân Agent Code

> File này là **phao cứu sinh**. Khi mở phiên mới, nếu không thấy agent-army/, hãy đọc file này.

## ⚡ Kích hoạt nhanh

Khi mở phiên mới, chạy:

```bash
cd ~/.openclaw/workspace
cat agent-army/README.md   # Đọc tổng quan
bash agent-army/setup.sh   # Kiểm tra sức khỏe
```

Nếu **agent-army/** không tồn tại → clone từ GitHub:

```bash
cd ~/.openclaw
mv workspace workspace.bak  # backup nếu có
git clone <repo-url> workspace
cd workspace
bash agent-army/setup.sh
```

## 🧠 Những gì cần nhớ về Đội Quân

**Đây là đội AI Agent tự động tạo phần mềm, chạy native trên OpenClaw.**

### Cấu trúc
- `agent-army/roles/` — 9 prompt templates (commander + 8 agents chuyên biệt)
- `agent-army/projects/` — nơi chứa code được tạo ra
- Mỗi agent là một vai trò: PO, Architect, Backend, Frontend, Tester, Reviewer, DevOps, Documenter

### Cách gọi đội quân
Chỉ cần nói trong main session một câu như:
> "Làm app quản lý chi tiêu"
> "Tạo website bán hàng online"
> "Làm app todo list"

Tôi sẽ tự động orchestrate pipeline:
1. PO Agent → PRD
2. Architect Agent → spec
3. Backend + Frontend (song song) → code
4. Tester Agent → test
5. Reviewer Agent → review
6. DevOps Agent → Docker + CI/CD
7. Documenter Agent → docs
8. Báo cáo lại

### Cách kích hoạt lại sau reset
1. Nếu workspace còn nguyên → chạy `bash agent-army/setup.sh`
2. Nếu workspace mới toanh → clone từ GitHub
3. Nếu quên hết → đọc file này

## 🔗 Git Remote (thiết lập sau)
```bash
cd ~/.openclaw/workspace
git remote add origin <GitHub-repo-url>
git push -u origin master
```
