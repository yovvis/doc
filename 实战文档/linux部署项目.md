# Tomcat

## 部署

**1、安装tomcat服务器**

- 将下载的tomcat的服务器上传至linux服务器（推荐 /opt路径）
- 输入命令 sh xxx.bin **服务名**（在xxx.bin文件目录，服务名自取）

**2、部署系统**

- 进入/opt/tomcat/webapps，先清空，再上传.zip包
- 解压部署包：unzip xxx.zip（任一路径）

**3、修改配置文件**

- 修改数据库配置jdbc.

**4、启动tomcat**

- 任一路径下：service **服务名** start

## 删除



在~路径下查找服务find /usr/local - name **服务名**

删除服务 rm -rf **服务名**

# Docker

## IDEA

1、配置运行看板service：springboot/docker

2、配置SSH连接：Setting的tools

3、配置服务器的FTP连接Setting->Build->Deployment选择SFTP

4、打开远程页面Tools -> Deployment -> Browse Remote Host

## Docker

删除旧版本

```shell
yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
```

安装相关工具类

~~~shell
yum install -y yum-utils device-mapper-persistent-data lvm2
~~~

配置docker仓库

~~~shell
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
~~~

aliyun源

~~~shell
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
~~~

安装docker

~~~shell
yum install docker-ce
~~~

执行安装docker

~~~shell
yum install docker-ce
 
Installed:
  docker-ce.x86_64 0:18.03.0.ce-1.el7.centos
 
Dependency Installed:
  audit-libs-python.x86_64 0:2.7.6-3.el7 checkpolicy.x86_64 0:2.5-4.el7   container-selinux.noarch 2:2.42-1.gitad8f0f7.el7 libcgroup.x86_64 0
  libtool-ltdl.x86_64 0:2.4.2-22.el7_3   pigz.x86_64 0:2.3.3-1.el7.centos policycoreutils-python.x86_64 0:2.5-17.1.el7     python-IPy.noarch
 
Complete!
~~~

验证docker安装成功

启动docker

~~~shell
systemctl start docker
~~~

验证docker

~~~shell
docker run hello-world
~~~

设置开机自启

~~~shell
chkconfig docker on
~~~

升级docker ce

~~~shell
yum -y upgrade
~~~

卸载docker ce

~~~shell
yum remove docker-ce
 
rm -rf /var/lib/docke
~~~

配置163镜像和存储目录

~~~shell
vim /etc/docker/daemon.json
~~~

 registry-mirrors 为镜像地址

docker 版本<20 graph 为存储目录 建议不要使用默认的 否则空间会不够用

docker 版本>20 graph已经弃用 需使用 data-root

~~~json
{
  "registry-mirrors": ["http://hub-mirror.c.163.com"],
  "data-root": "/home/docker"
}
~~~

~~~shell
systemctl daemon-reload
systemctl restart docker
~~~

## Docker Compose

~~~shell
curl -L https://github.com/docker/compose/releases/download/2.2.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
~~~

下载好之后 上传到系统 /usr/local/bin 目录 并改名为 docker-compose

授权

~~~shell
chmod +x /usr/local/bin/docker-compose
~~~

检查版本

~~~shell
docker-compose version 2.2   docker-compose -version 1.27版本
~~~

## 部署应用

1、后端部署

创建基础服务

```shell
docker-compose up -d mysql nginx-web redis aliyun
```

创建业务服务

```shell
docker-compose up -d crulu-monitor-admin crulu-xxl-job-admin crulu-server1 crulu-server2
```

2、前端部署

执行打包命令

```shell
# 打包正式环境
npm run build:prod
```

打包后生成打包文件在 `ruoyi-ui/dist` 目录
将 `dist` 目录下文件(不包含 `dist` 目录) 上传到部署服务器 `docker/nginx/html` 目录下(手动部署放入自己配置的路径即可)

最终服务器

![image-20230506112327907](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305061123887.png)
