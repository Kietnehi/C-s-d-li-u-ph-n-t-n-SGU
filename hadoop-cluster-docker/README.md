
# Hadoop Cluster Docker

Docker-based distributed Hadoop cluster for learning and development purposes.

## 📋 Overview

In this demo, I deploy a Hadoop Cluster using Docker to simulate a distributed data processing system. The cluster consists of a NameNode and multiple DataNodes, each running in a separate container. Docker allows for fast initialization, easy configuration, and resource savings compared to using multiple physical machines.

To illustrate Hadoop's parallel processing capabilities, I use the WordCount problem (counting the occurrences of each word in a text). The input data is stored on HDFS, then the MapReduce program splits the file and distributes it to the DataNodes for parallel processing. The Map phase extracts and counts words, while the Reduce phase aggregates the final results.



The results show that the system can efficiently process large datasets, utilizing multiple nodes to accelerate computation and clearly demonstrating Hadoop's distributed nature.

## ✨ Features

- **Multi-Node Hadoop Cluster**: Deploy a cluster with 1 master node and multiple slave nodes.
- **Easy Setup**: Quick deployment with simple shell scripts.
- **Scalable**: Flexibly resize the cluster.
- **Pre-configured**: Hadoop 2.7.2 comes pre-installed and configured.
- **WordCount Example**: Includes a ready-to-run MapReduce example.
- **Web UI Access**: Access Hadoop NameNode and ResourceManager via web interfaces.

## 🏗️ Architecture



- **Hadoop Version**: 2.7.2
- **Base Image**: Ubuntu 14.04
- **Java**: OpenJDK 7
- **Components**:
  - HDFS (Hadoop Distributed File System)
  - YARN (Yet Another Resource Negotiator)
  - MapReduce

## 📦 Requirements

- Docker installed on the system
- Sudo privileges (or add user to the docker group)
- Minimum 4GB RAM recommended
- Basic knowledge of Hadoop and Docker

## 🚀 Quick Start

### 1. Build Docker Image

```bash
./build-image.sh

```

This command creates a Docker image named `kiwenlau/hadoop:1.0` with Hadoop 2.7.2 pre-installed.

### 2. Start Single-Node Cluster (Recommended for beginners)

```bash
./masternode.sh

```

This command starts a single-node Hadoop cluster with the following services:

* **NameNode UI**: http://localhost:50070
* **ResourceManager UI**: http://localhost:8088

### 3. Start Multi-Node Cluster

```bash
./start-container.sh [N]

```

Where `N` is the total number of nodes (default is 3: 1 master + 2 slaves).

**Example**: Start a 5-node cluster (1 master + 4 slaves):

```bash
./start-container.sh 5

```

After running this command, you will be inside the `hadoop-master` container. Start the Hadoop services:

```bash
./start-hadoop.sh

```

### 4. Run WordCount Example

Inside the master container, run:

```bash
./run-wordcount.sh

```

This script will:

* Display the input file content
* Run the MapReduce WordCount job on `bigfile.txt`
* Display the results
* Display the execution time

## 📂 Project Structure

```text
.
├── Dockerfile              # Docker image definition
├── build-image.sh          # Build Hadoop Docker image
├── masternode.sh           # Start single-node cluster
├── start-container.sh      # Start multi-node cluster
├── resize-cluster.sh       # Resize the cluster
├── bigfile.txt             # Sample input file for WordCount
├── config/                 # Hadoop configuration files
│   ├── core-site.xml       # Core Hadoop configuration
│   ├── hdfs-site.xml       # HDFS configuration
│   ├── mapred-site.xml     # MapReduce configuration
│   ├── yarn-site.xml       # YARN configuration
│   ├── slaves              # List of slave nodes
│   ├── hadoop-env.sh       # Hadoop environment variables
│   ├── ssh_config          # SSH configuration
│   ├── start-hadoop.sh     # Start Hadoop services
│   └── run-wordcount.sh    # WordCount demo script
└── LICENSE

```

## 🔧 Advanced Usage

### Resize the Cluster

To change the number of nodes in the cluster:

```bash
./resize-cluster.sh [N]

```

This command will:

1. Update the slaves configuration
2. Rebuild the Docker image
3. You will need to restart the containers with `./start-container.sh [N]`

### Access Hadoop Web UIs

* **NameNode**: http://localhost:50070
* View HDFS status, browse the file system, check DataNode health


* **ResourceManager**: http://localhost:8088
* Monitor YARN applications, view cluster metrics



### Run Custom MapReduce Jobs

1. Copy your JAR file into the master container:

```bash
sudo docker cp yourapp.jar hadoop-master:/root/

```

2. Execute it inside the container:

```bash
sudo docker exec -it hadoop-master bash
hadoop jar yourapp.jar YourMainClass input output

```

### HDFS Commands

Common HDFS operations inside the master container:

```bash
# List files
hdfs dfs -ls /

# Upload a file
hdfs dfs -put localfile.txt /path/in/hdfs

# Download a file
hdfs dfs -get /path/in/hdfs localfile.txt

# Create a directory
hdfs dfs -mkdir /mydir

# View file content
hdfs dfs -cat /path/to/file

```

## 🛠️ Troubleshooting

### Container fails to start

```bash
# Check running containers
sudo docker ps -a

# Check logs
sudo docker logs hadoop-master

```

### Port already in use

If ports 50070 or 8088 are already in use, modify the port mappings in the startup scripts:

```bash
-p 50070:50070  # Change the first number to an available port
-p 8088:8088

```

### Permission issues

```bash
# Fix SSH config permissions
sudo chown $USER ~/.ssh/config
sudo chmod 644 ~/.ssh/config

```

### Network issues (multi-node cluster)

Ensure the Docker network is created:

```bash
sudo docker network create --driver=bridge hadoop

```

## 📝 Configuration Files

Important configuration files in the `config/` directory:

* **core-site.xml**: Defines the HDFS NameNode location
* **hdfs-site.xml**: HDFS settings (replication, block size)
* **mapred-site.xml**: MapReduce framework settings
* **yarn-site.xml**: YARN resource manager configuration
* **slaves**: List of slave node hostnames

## 🎓 Learning Resources

After setting up the cluster, you can:

1. Explore the HDFS file system
2. Run MapReduce examples
3. Monitor jobs via the web UI
4. Write and test your own MapReduce applications
5. Understand distributed computing concepts

## 🤝 Author

Original project by **KiwenLau** [kiwenlau@gmail.com](mailto:kiwenlau@gmail.com)

## 📄 License

See the [LICENSE](https://www.google.com/search?q=LICENSE) file for details.

## 🔗 Useful Links

* [Official Hadoop Documentation](https://hadoop.apache.org/docs/r2.7.2/)
* [Docker Documentation](https://docs.docker.com/)
* [HDFS Architecture](https://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-hdfs/HdfsDesign.html)
* [MapReduce Tutorial](https://hadoop.apache.org/docs/r2.7.2/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html)

---

**Note**: This setup is designed for development and learning purposes. For production deployments, consider using enterprise Hadoop distributions with appropriate security, monitoring, and high availability configurations.

```
