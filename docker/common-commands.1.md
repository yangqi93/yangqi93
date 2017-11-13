## 常用命令速查

#### 基础操作

#### 镜像操作

1. 获取镜像  
`docker pull [选项] [Docker Registry地址]<仓库名>:<标签>`  

1. 列出镜像  
`docker images` 所有镜像  
`docker images -a` 包括中间层  
`docker images ubuntu` 部分镜像  

1. 删除镜像
`docker rmi [选项] <镜像1> [<镜像2> ...]` 




#### 容器操作

1. 列出容器  
`docker ps -a` 查看所有容器

1. 删除容器  
`docker rm container` 指定容器  
`docker rm $(docker ps -a -q)` 删除所有
