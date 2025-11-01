# ĐỒ ÁN CƠ SỞ DỮ LIỆU PHÂN TÁN VÀ TÀI LIỆU VỀ MÔN CƠ SỞ DỮ LIỆU PHÂN TÁN SGU VỚI NHIỀU CHỦ ĐỀ 
> Kết hợp 3 tài liệu:  
> 1. **Đồ án chung CSDLPT** (Hệ thống quỹ – SQL Server Replication)  
> 2. **Đồ án riêng – Hadoop & MapReduce**  
> 3. **Slide thuyết trình Hadoop – HDFS – YARN – MapReduce**

---

## 🌐✨ Liên kết tài nguyên

<div align="center">

🎓 **Tài liệu học phần – Cơ Sở Dữ Liệu Phân Tán (Lớp DCT122C3 – ĐH Sài Gòn)**  
📁 [![Google Drive](https://img.shields.io/badge/📂_Drive-Tài_liệu_lớp-blue?style=for-the-badge&logo=google-drive)](https://drive.google.com/drive/folders/1huLhz03fFSucvnEqQ9PsZSp-jgrxtE8J)

💻 **GitHub cá nhân – Trương Phú Kiệt**  
[![GitHub Profile](https://img.shields.io/badge/GitHub-Kietnehi-black?style=for-the-badge&logo=github)](https://github.com/Kietnehi)

</div>

---

## 1. Thông tin chung

- **Trường**: Trường Đại học Sài Gòn  
- **Khoa**: Công nghệ Thông tin  
- **Môn học**: Cơ sở dữ liệu phân tán  
- **Giảng viên hướng dẫn**: **Nguyễn Quốc Huy**  
- **Lớp**: **DCT122C3**  
- **Nhóm thực hiện**: **Nhóm 11**  
  - Trà Đức Toàn – 3122411217  
  - Trương Phú Kiệt – 3122411109  
- **Thời gian**: *Thành phố Hồ Chí Minh, tháng 3 năm 2025*

---

## 2. Tổng quan về đồ án lớp DCT122C3

Cả lớp DCT122C3 được chia thành **2 phần đồ án chính**:

### 🧩 Phần 1 – Đồ án chung (SQL Server – Hệ thống quản lý quỹ)

Tất cả sinh viên đều cùng thực hiện một đề tài **xây dựng hệ thống CSDL phân tán bằng SQL Server**.  
Bao gồm:
- Thiết kế cơ sở dữ liệu **FundManagement**.
- Cấu hình **Replication** (Publisher – Distributor – Subscriber).  
- Phân mảnh dữ liệu theo **RiskProfile** (Low/Medium/High) hoặc **FundType**.
- Triển khai trên nhiều instance SQL Server, thực hiện truy vấn phân tán.

### 💡 Phần 2 – Đồ án riêng (Chuyên đề mở rộng CSDL phân tán)

Mỗi nhóm chọn một chủ đề nâng cao để nghiên cứu riêng.  
Danh sách các chủ đề của lớp gồm:

1. Liên thông Database **Oracle ↔ SQL Server**  
2. Liên thông **MySQL ↔ SQL Server**  
3. Liên thông **PostgreSQL ↔ MySQL**  
4. **Di trú dữ liệu** sử dụng **Talend**  
5. Di trú dữ liệu **khác cấu trúc lược đồ**  
6. **Cơ sở dữ liệu phi tập trung (Blockchain Database)**  
7. **Hadoop & MapReduce** 🏆 *(Chủ đề của Trương Phú Kiệt và Trà Đức Toàn – đạt điểm cao nhất lớp: **9.5/10**)*
8. **Phân tán dữ liệu trong PostgreSQL** (trên hệ thống quản lý quỹ)

---

## 3. Mục tiêu README

README này được tạo ra để:
1. Gom toàn bộ nội dung đồ án chung và đồ án riêng trong **một tài liệu duy nhất**.  
2. Tái hiện **cấu trúc thư mục**, **cách triển khai**, **lệnh chạy** và **giải thích logic phân tán**.  
3. Phục vụ cho việc **đưa lên GitHub** hoặc **nộp file tổng hợp** cho giảng viên.

---



## 4. Tóm tắt Đồ án chung – SQL Server (FundManagement)

### 🎯 Mục tiêu
Xây dựng hệ thống **FundManagement** phục vụ việc quản lý quỹ đầu tư,  
sau đó **phân tán dữ liệu** qua nhiều site SQL Server để:
- Giảm tải cho từng node.
- Dự phòng dữ liệu khi lỗi.
- Cho phép xử lý song song.

### ⚙️ Phân mảnh và Replication
- **Phân mảnh bảng `Clients`** theo `RiskProfile` (`Low`, `Medium`, `High`).  
- **Phân mảnh bảng `Funds`** theo `FundType` (`Equity`, `Bond`, `Mixed`).  
- **Replication dạng Merge Publication** để đồng bộ 2 chiều.  
- **Linked Server** dùng để hợp nhất truy vấn toàn cục.

---

## 5. Đồ án riêng – Hadoop & MapReduce 🧠  

> **Chủ đề của Trương Phú Kiệt – đạt điểm 9.5/10 (cao nhất lớp).**

### 🔍 Mục tiêu
Tìm hiểu cơ chế lưu trữ và xử lý dữ liệu phân tán trên **Hadoop Ecosystem**,  
bao gồm **HDFS**, **YARN** và **MapReduce**,  
so sánh hiệu năng giữa các môi trường **local, Docker, AWS**.

### ⚡ Thực nghiệm chính
- Viết chương trình **WordCount**.
- Triển khai 4 môi trường:
  1. Python tuần tự  
  2. Hadoop Single Node  
  3. Hadoop Docker 3 Node  
  4. Hadoop AWS Cluster  
- Kết quả: **số node càng nhiều → tốc độ xử lý càng nhanh**.

### 📦 Các lệnh cơ bản HDFS
```bash
hdfs dfs -mkdir /input
hdfs dfs -put data.txt /input
hadoop jar hadoop-mapreduce-examples-3.3.0.jar wordcount /input /output
hdfs dfs -cat /output/part-r-00000
```

---

## 6. Liên hệ giữa 2 phần

| So sánh | SQL Server (Replication) | Hadoop (MapReduce) |
|----------|--------------------------|--------------------|
| Mục tiêu | Phân tán dữ liệu nghiệp vụ | Phân tán xử lý dữ liệu lớn |
| Cơ chế | Publisher – Subscriber – Distributor | HDFS – YARN – MapReduce |
| Dữ liệu | Có cấu trúc, giao dịch | Phi cấu trúc, log, text |
| Đồng bộ | Real-time / Gần real-time | Batch Processing |
| Ngôn ngữ | SQL / T-SQL | Java / Python |
| Ứng dụng | Hệ thống tài chính, ngân hàng | Phân tích log, thống kê, ML |

---

## 7. Kết quả & Đánh giá

- **Đồ án chung**: Hoàn thiện đầy đủ cấu trúc CSDL phân tán, chạy ổn định giữa các node.  
- **Đồ án riêng (Hadoop)**:  
  - Hoàn thiện setup cluster (local, docker, aws).  
  - Có **demo chạy thực tế**.  
  - Được giảng viên đánh giá **9.5/10** – điểm cao nhất lớp.

---

## 8. Tác giả

- **Trà Đức Toàn** – 3122411217  
- **Trương Phú Kiệt** – 3122411109  
- **Lớp**: DCT122C3  
- **GitHub**: [https://github.com/Kietnehi](https://github.com/Kietnehi)

---

## 9. License

Tài liệu phục vụ học tập tại **Đại học Sài Gòn**.  
Có thể tự do chia sẻ, trích dẫn và cải tiến cho mục đích học thuật.

---
