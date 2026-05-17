# 🪷 Agent Code Army — COMMANDS.md

> Toàn bộ cách ra lệnh cho đội quân 8 Agent.
> Chỉ cần nói trong main session, tôi (Commander) sẽ lo phần còn lại.

---

## 1. DỰ ÁN MỚI

### 1.1 Tạo app mới (full pipeline)

> "Làm app **quản lý chi tiêu cá nhân**"
> "Tạo **website bán hàng online**"
> "Làm **app todo list cho nhà chùa**"

Pipeline tự động chạy:
```
PO → Architect → Backend + Frontend (song song) → Tester → Reviewer → DevOps → Doc
```

### 1.2 Tạo app + chỉ định tech stack

> "Làm app **quản lý công việc** dùng **React + Node.js + MongoDB**"
> "Tạo **blog cá nhân** với **Next.js + PostgreSQL**"

### 1.3 Tạo app + giới hạn scope

> "Làm app **chat realtime**, nhưng chỉ cần **MVP: gửi tin nhắn cơ bản + user online**"
> "Tạo **app đặt lịch hẹn**, phase 1 chỉ cần **CRUD lịch hẹn, không cần thanh toán**"

### 1.4 Tạo app + code luôn, bỏ qua thiết kế

> "Làm app **note-taking** dùng **Python Flask + SQLite**, code luôn khỏi cần PO với Architect"

Bỏ qua bước PO + Architect, đi thẳng vào code.

---

## 2. DỰ ÁN CÓ SẴN

### 2.1 Thêm tính năng

> "Thêm **tính năng đăng nhập Google** vào project **agent-army/projects/todo-app**"
> "Thêm **chat realtime** cho **project quản lý công việc**"

Pipeline: PO (phân tích) → Architect → Backend → Frontend → Tester → Reviewer

### 2.2 Fix bug

> "Fix lỗi **upload ảnh không hoạt động** trong project **todo-app**"
> "Fix bug **crash khi nhập email rỗng** trong **agent-army/projects/abc**"

Pipeline: Reviewer (tìm nguyên nhân) → Backend/Frontend (sửa) → Tester (kiểm tra)

### 2.3 Review code

> "Review code project **agent-army/projects/**"
> "Review code ở thư mục **projects/abc/src/backend/**"
> "Kiểm tra security cho **project xyz**"

Pipeline: Reviewer Agent → báo cáo

### 2.4 Thêm / viết test

> "Thêm test cho **module payment** trong project **shop-app**"
> "Viết unit test cho **backend** của **todo-app**"
> "Tăng test coverage lên **80%** cho project **abc**"

Pipeline: Tester Agent

### 2.5 Setup Docker / CI/CD

> "Setup Docker cho project **abc**"
> "Tạo CI/CD GitHub Actions cho **shop-app**"
> "Docker hóa **todo-app**"

Pipeline: DevOps Agent

### 2.6 Viết tài liệu

> "Viết docs cho project **abc**"
> "Cập nhật README.md cho **todo-app**"
> "Tạo API docs cho **backend của shop-app**"

Pipeline: Documenter Agent

### 2.7 Refactor code

> "Refactor backend **todo-app** sang **TypeScript**"
> "Tối ưu lại **API endpoints** của **abc** theo REST convention"
> "Chia nhỏ file **main.py** thành nhiều module"

Pipeline: Architect (thiết kế) → Backend Agent (code) → Tester (kiểm tra)

### 2.8 Audit bảo mật

> "Audit security cho project **abc**"
> "Kiểm tra lỗ hổng bảo mật trong **shop-app**"

Pipeline: Reviewer Agent (focus security)

### 2.9 Deploy

> "Deploy project **todo-app** lên **Vercel**"
> "Deploy backend **abc** lên **Railway**"
> "Setup production server cho **shop-app**"

Pipeline: DevOps Agent (+ hỏi Thầy thông tin server)

---

## 3. AGENT RIÊNG LẺ

Gọi đúng một agent làm việc cụ thể:

### PO Agent

> "PO Agent, phân tích ý tưởng app **cho thuê sách**"
> "PO Agent, viết user stories cho **tính năng giỏ hàng**"

### Architect Agent

> "Architect Agent, thiết kế database cho **app quản lý kho**"
> "Architect Agent, vẽ API spec cho **module user**"

### Backend Agent

> "Backend Agent, code API **CRUD users** cho project **abc**"
> "Backend Agent, thêm **validate input** cho các endpoints"

### Frontend Agent

> "Frontend Agent, code **form đăng ký** cho project **abc**"
> "Frontend Agent, tạo **dashboard page** với **React + shadcn**"

### Tester Agent

> "Tester Agent, viết test cho **module auth** trong project **abc**"
> "Tester Agent, kiểm tra **API payment** có hoạt động không"

### Reviewer Agent

> "Reviewer Agent, review file **src/backend/routes/users.js**"
> "Reviewer Agent, kiểm tra **best practices** cho toàn bộ **backend**"

### DevOps Agent

> "DevOps Agent, tạo **Dockerfile** cho project **abc**"
> "DevOps Agent, setup **GitHub Actions CI**"

### Documenter Agent

> "Documenter Agent, viết **API docs** cho backend project **abc**"
> "Documenter Agent, tạo **README.md** đẹp cho **todo-app**"

---

## 4. CẤU HÌNH / TÙY CHỈNH

### Đổi model cho agent

> "Dùng **Claude Sonnet** cho Reviewer Agent"
> "Cho Backend Agent dùng **DeepSeek** để tiết kiệm"

### Chạy song song

> "Chạy Backend + Frontend cùng lúc để tiết kiệm thời gian"
> "Tôi muốn code xong hết backend rồi mới làm frontend" (mặc định là song song)

### Skip agent

> "Làm app **todo-list**, bỏ qua **Reviewer với Doc**"
> "Code nhanh app **note**, không cần **PO và Architect**"

### Human-in-the-loop

> "Chạy pipeline nhưng **dừng lại trước khi deploy** cho tôi duyệt"
> "Review xong thì **báo tôi trước khi merge**"

---

## 5. CRON / LẬP LỊCH

### Kiểm tra code hàng ngày

> "Mỗi sáng 8h, chạy **Reviewer Agent** kiểm tra code mới trong các project"

### Tự động deploy

> "Khi có **commit mới vào master**, tự động chạy **DevOps Agent** deploy lên staging"

---

## 6. VÍ DỤ NHANH

| Thầy nói | Tôi làm |
|----------|---------|
| "Làm app quản lý chi tiêu" | Full pipeline → ra app hoàn chỉnh |
| "Thêm login Google vào todo-app" | PO → Architect → Code → Test → Review |
| "Fix bug crash khi nhập số âm" | Tìm + sửa + test |
| "Review code hết project abc" | Reviewer → báo cáo |
| "Setup Docker cho shop-app" | DevOps → Docker + compose |
| "Viết docs cho todo-app" | Doc Agent → README + API docs |
| "Dùng model rẻ cho PO Agent" | Đổi config, chạy tiếp |
| "Sáng 8h review code tự động" | Cron job |

---

> 🪷 **Nguyên tắc vàng:**
> 1. Rõ **việc gì** — thêm tính năng? fix bug? review?
> 2. Rõ **project nào** — tên hoặc đường dẫn
> 3. Càng **chi tiết** càng tốt — tech stack, scope, ưu tiên
>
> Không cần nhớ câu lệnh. Cứ nói tự nhiên như nói với đồng nghiệp. Tôi sẽ hiểu.
