#!/bin/bash

# Đếm thời gian bắt đầu
start_time=$(date +%s)

# Hiển thị file input trên HDFS
echo -e "\n📂 Nội dung file input từ HDFS (bigfile.txt):"
hdfs dfs -cat input/bigfile.txt | head -n 10

# Xóa output cũ nếu đã tồn tại
hdfs dfs -rm -r -f output

# Chạy WordCount
echo -e "\n🚀 Chạy WordCount trên bigfile.txt..."
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.2.jar wordcount input output

# Hiển thị kết quả đầu ra
echo -e "\n📊 Kết quả WordCount:"
hdfs dfs -cat output/part-r-00000 | head -n 20

# Đếm thời gian kết thúc
end_time=$(date +%s)
elapsed_time=$((end_time - start_time))

echo -e "\n⏱️ Thời gian chạy: ${elapsed_time} giây"
