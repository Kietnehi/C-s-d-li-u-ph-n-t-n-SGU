# Hadoop Cluster Docker

Cụm Hadoop phân tán dựa trên Docker cho mục đích học tập và phát triển.

## 📋 Tổng Quan

Trong demo này, tôi triển khai một Hadoop Cluster bằng Docker để mô phỏng hệ thống xử lý dữ liệu phân tán. Cụm bao gồm một NameNode và nhiều DataNode, mỗi node chạy trong một container riêng biệt. Docker giúp khởi tạo nhanh, dễ cấu hình và tiết kiệm tài nguyên so với việc dùng nhiều máy vật lý.

Để minh họa khả năng xử lý song song của Hadoop, tôi sử dụng bài toán WordCount (đếm số lần xuất hiện của từng từ trong văn bản). Dữ liệu đầu vào được lưu trên HDFS, sau đó chương trình MapReduce sẽ chia nhỏ file, phân phối đến các DataNode để xử lý song song. Giai đoạn Map thực hiện tách và đếm từ, còn Reduce tổng hợp kết quả cuối cùng.

Kết quả cho thấy hệ thống có thể xử lý dữ liệu lớn hiệu quả, tận dụng nhiều node để tăng tốc độ tính toán và thể hiện rõ đặc trưng phân tán của Hadoop.

## ✨ Tính Năng

- **Cụm Hadoop Đa Node**: Triển khai cụm với 1 master node và nhiều slave nodes
- **Cài Đặt Dễ Dàng**: Triển khai nhanh chóng với các shell scripts đơn giản
- **Có Thể Mở Rộng**: Thay đổi kích thước cụm một cách linh hoạt
- **Đã Được Cấu Hình Sẵn**: Hadoop 2.7.2 được cài đặt và cấu hình sẵn
- **Ví Dụ WordCount**: Bao gồm ví dụ MapReduce sẵn sàng chạy
- **Giao Diện Web UI**: Truy cập Hadoop NameNode và ResourceManager qua giao diện web

## 🏗️ Kiến Trúc

- **Phiên Bản Hadoop**: 2.7.2
- **Base Image**: Ubuntu 14.04
- **Java**: OpenJDK 7
- **Các Thành Phần**:
  - HDFS (Hadoop Distributed File System - Hệ thống file phân tán)
  - YARN (Yet Another Resource Negotiator - Quản lý tài nguyên)
  - MapReduce

## 📦 Yêu Cầu

- Docker đã được cài đặt trên hệ thống
- Quyền sudo (hoặc thêm user vào docker group)
- Khuyến nghị tối thiểu 4GB RAM
- Kiến thức cơ bản về Hadoop và Docker

## 🚀 Bắt Đầu Nhanh

### 1. Build Docker Image

```bash
./build-image.sh
```

Lệnh này sẽ tạo Docker image có tên `kiwenlau/hadoop:1.0` với Hadoop 2.7.2 đã được cài đặt sẵn.

### 2. Khởi Động Cụm Đơn Node (Khuyến nghị cho người mới)

```bash
./masternode.sh
```

Lệnh này khởi động cụm Hadoop đơn node với các dịch vụ:
- **NameNode UI**: http://localhost:50070
- **ResourceManager UI**: http://localhost:8088

### 3. Khởi Động Cụm Đa Node

```bash
./start-container.sh [N]
```

Trong đó `N` là tổng số nodes (mặc định là 3: 1 master + 2 slaves).

**Ví dụ**: Khởi động cụm 5 nodes (1 master + 4 slaves):
```bash
./start-container.sh 5
```

Sau khi chạy lệnh này, bạn sẽ ở bên trong container `hadoop-master`. Khởi động các dịch vụ Hadoop:

```bash
./start-hadoop.sh
```

### 4. Chạy Ví Dụ WordCount

Bên trong master container, chạy:

```bash
./run-wordcount.sh
```

Script này sẽ:
- Hiển thị nội dung file đầu vào
- Chạy job MapReduce WordCount trên `bigfile.txt`
- Hiển thị kết quả
- Hiển thị thời gian thực thi

## 📂 Cấu Trúc Dự Án

```
.
├── Dockerfile              # Định nghĩa Docker image
├── build-image.sh          # Build Hadoop Docker image
├── masternode.sh           # Khởi động cụm đơn node
├── start-container.sh      # Khởi động cụm đa node
├── resize-cluster.sh       # Thay đổi kích thước cụm
├── bigfile.txt            # File đầu vào mẫu cho WordCount
├── config/                # Các file cấu hình Hadoop
│   ├── core-site.xml      # Cấu hình core Hadoop
│   ├── hdfs-site.xml      # Cấu hình HDFS
│   ├── mapred-site.xml    # Cấu hình MapReduce
│   ├── yarn-site.xml      # Cấu hình YARN
│   ├── slaves             # Danh sách các slave nodes
│   ├── hadoop-env.sh      # Biến môi trường Hadoop
│   ├── ssh_config         # Cấu hình SSH
│   ├── start-hadoop.sh    # Khởi động dịch vụ Hadoop
│   └── run-wordcount.sh   # Script demo WordCount
└── LICENSE
```

## 🔧 Sử Dụng Nâng Cao

### Thay Đổi Kích Thước Cụm

Để thay đổi số lượng nodes trong cụm:

```bash
./resize-cluster.sh [N]
```

Lệnh này sẽ:
1. Cập nhật cấu hình slaves
2. Rebuild Docker image
3. Bạn cần khởi động lại containers với `./start-container.sh [N]`

### Truy Cập Hadoop Web UIs

- **NameNode**: http://localhost:50070
  - Xem trạng thái HDFS, duyệt hệ thống file, kiểm tra sức khỏe DataNode
- **ResourceManager**: http://localhost:8088
  - Giám sát các ứng dụng YARN, xem metrics của cụm

### Chạy MapReduce Jobs Tùy Chỉnh

1. Copy file JAR vào master container:
```bash
sudo docker cp yourapp.jar hadoop-master:/root/
```

2. Thực thi bên trong container:
```bash
sudo docker exec -it hadoop-master bash
hadoop jar yourapp.jar YourMainClass input output
```

### Các Lệnh HDFS

Các thao tác HDFS phổ biến bên trong master container:

```bash
# Liệt kê files
hdfs dfs -ls /

# Upload file
hdfs dfs -put localfile.txt /path/in/hdfs

# Download file
hdfs dfs -get /path/in/hdfs localfile.txt

# Tạo thư mục
hdfs dfs -mkdir /mydir

# Xem nội dung file
hdfs dfs -cat /path/to/file
```

## 🛠️ Xử Lý Sự Cố

### Container không khởi động được
```bash
# Kiểm tra các containers đang chạy
sudo docker ps -a

# Kiểm tra logs
sudo docker logs hadoop-master
```

### Port đã được sử dụng
Nếu ports 50070 hoặc 8088 đã được sử dụng, sửa port mappings trong startup scripts:
```bash
-p 50070:50070  # Đổi số đầu tiên thành port khả dụng
-p 8088:8088
```

### Vấn đề về quyền
```bash
# Sửa quyền SSH config
sudo chown $USER ~/.ssh/config
sudo chmod 644 ~/.ssh/config
```

### Vấn đề về mạng (cụm đa node)
Đảm bảo Docker network đã được tạo:
```bash
sudo docker network create --driver=bridge hadoop
```

## 📝 Các File Cấu Hình

Các file cấu hình quan trọng trong thư mục `config/`:

- **core-site.xml**: Định nghĩa vị trí HDFS NameNode
- **hdfs-site.xml**: Cài đặt HDFS (replication, block size)
- **mapred-site.xml**: Cài đặt MapReduce framework
- **yarn-site.xml**: Cấu hình YARN resource manager
- **slaves**: Danh sách hostname của các slave nodes

## 🎓 Tài Nguyên Học Tập

Sau khi thiết lập cụm, bạn có thể:
1. Khám phá hệ thống file HDFS
2. Chạy các ví dụ MapReduce
3. Giám sát jobs qua web UI
4. Viết và kiểm thử các ứng dụng MapReduce của riêng bạn
5. Hiểu các khái niệm điện toán phân tán

## 🤝 Tác Giả

Dự án gốc bởi **KiwenLau** <kiwenlau@gmail.com>

## 📄 Giấy Phép

Xem file [LICENSE](LICENSE) để biết chi tiết.

## 🔗 Liên Kết Hữu Ích

- [Tài Liệu Chính Thức Hadoop](https://hadoop.apache.org/docs/r2.7.2/)
- [Tài Liệu Docker](https://docs.docker.com/)
- [Kiến Trúc HDFS](https://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-hdfs/HdfsDesign.html)
- [Hướng Dẫn MapReduce](https://hadoop.apache.org/docs/r2.7.2/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html)

---

**Lưu ý**: Cài đặt này được thiết kế cho mục đích phát triển và học tập. Đối với triển khai production, xem xét sử dụng các bản phân phối Hadoop doanh nghiệp với cấu hình bảo mật, giám sát và high availability phù hợp.
