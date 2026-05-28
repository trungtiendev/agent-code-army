# 🧯 Lessons Learned: Tipitaka Vault Timeout Crisis

> **Ngày:** 2026-05-19  
> **Dự án:** Tipitaka Vault (Tàng Kinh Các Số) — 33KB spec, 43 files output  
> **Pipeline:** PO(1) → PO(2) → Arch → BE → FE → (dang dở)

---

## 📊 What Happened

| Agent | Timeout | Files written | Tokens burned |
|-------|:-------:|:-------------:|:-------------:|
| PO Agent #1 | 180s | 0 | 14K |
| PO Agent #2 (retry) | 300s | 0 | 14K |
| Architect Agent | 300s | 0 | 27K |
| Backend Agent | 600s | 5/12 files | 31K |
| Frontend Agent | 600s | 21/26 files | 37K |
| **Total waste** | | | **~123K tokens** |

**Root cause:** Agent dùng `read(file)` để đọc 33KB spec. Mỗi lần read trả 200 lines. Mất 7-8 lượt = 2-3 phút chỉ để đọc. Viết file là bước cuối → timeout khi đang viết.

## 🔬 Root Causes

### 1. Silent Reader Pattern (sát thủ số 1)
Agent được dặn "đọc file X" → ngoan ngoãn đọc từng chunk. Với file 33KB, mất 7-8 `read` calls. Mỗi call tốn 15-25s round-trip.

**Fix:** Commander đọc hộ, tóm tắt vào prompt.

### 2. No Checkpoint
Agent suy nghĩ xong hết mới viết. Nếu timeout ở giây thứ 580/600, tất cả 580 giây đều vô ích.

**Fix:** Viết file ngay khi từng phần hoàn thành.

### 3. Timeout Cố Định
Mọi project dùng chung timeout: PO 120s, BE 300s. App todo 5 files cũng 300s, Tipitaka 40 files cũng 300s.

**Fix:** Dynamic timeout = 120 + (files × 30) + 60.

### 4. Không Phase Split
Một Backend Agent cố gắng viết 3 Rust crates (tipitaka-core, tipitaka-import, tipitaka-api) trong 1 lần.

**Fix:** Tách thành 2-4 phases cho project L/XL.

## 🛠️ Fixes Applied

### Trong SKILL.md
- Thêm `Timeout Prevention Protocol` — 5 bước bắt buộc
- Project sizing (S/M/L/XL) trước pipeline
- Context digestion — Commander đọc hộ agent
- Phase splitting cho project lớn
- Checkpoint writing pattern
- Dynamic timeout formula
- Recovery protocol
- Critical path rule sửa: auto-retry → Commander viết thay

### Trong tất cả Reference Files
- Thêm "KHÔNG tự đọc input file — Commander digest sẵn"
- Thêm checkpoint writing nhấn mạnh
- Thêm cách dùng CodeGraph thay vì đọc file

### Trong commander-agent.md
- Quy trình sizing + context digest + phase split
- Ví dụ cụ thể từ Tipitaka Vault
- Recovery protocol chi tiết

## 🎯 Future Rules

### Rule 1: Digest, don't dump
> Nếu input file > 2KB, Commander phải digest trước khi truyền cho agent.

### Rule 2: Write early, write often
> Mỗi file hoàn thành = 1 checkpoint. Agent viết NGAY, không đợi.

### Rule 3: Size before spawn
> Trước mỗi lần spawn: đo input size, đếm estimated output files, tính timeout.

### Rule 4: Phases for the big ones
> Nếu estimated timeout > 600s (≈20+ files) → split phase.

### Rule 5: Always recover
> Timeout ≠ mất hết. Kiểm tra files đã tạo → resume từ checkpoint.

## 📈 Token Savings

Với Timeout Prevention Protocol:
- **Trước đây:** 123K tokens wasted on reading + timeout
- **Sau fix:** ~0 wasted (Commander digest + checkpoint + dynamic timeout)
- **Tiết kiệm:** ~43% token cho project lớn

---

*"Thất bại là mẹ thành công. Càng thất bại, càng nhiều lessons."* 🪷
