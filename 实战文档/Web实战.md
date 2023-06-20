# Web技术

## 1、vue

- 常用指令

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131114078.png" alt="image-20230513111406976" style="zoom:67%;" />

- 生命周期

  <img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131114228.png" style="zoom: 67%;" />

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131115454.png" alt="image-20230513111527340" style="zoom: 50%;" />

## 2、Axios

![image-20230513111654195](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131116259.png)

## 3、前端工程化开发

1. 模块化：js、css
2. 组件化：UI结构、样式、行为
3. 规范化：目录结构、编码、接口
4. 自动化：构建、部署、测试

### 环境

Vue-cli：统一的目录结构、本低调试、热部署、单元测试、继承打包上线

依赖环境：Node.js

~~~shell
npm config set prefix D:\software\Environmentools\Nodejs	
~~~

安装vue-cli

~~~shell
npm install -g @vue/cli
~~~

创建Vue项目（图形化vue -ui）

~~~shell
vue create vue_project
~~~

### 组件库

element组件

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131141747.png" alt="image-20230513114117672" style="zoom: 67%;" />

### Vue路由

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131157734.png" alt="image-20230513115741663" style="zoom:67%;" />

~~~shell
npm intall vue-router@3.5.1
~~~

### 打包部署

nginx

~~~shell
netstat -ano | findStr 80R
~~~

### 4、请求响应

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131305388.png" alt="image-20230513130521272" style="zoom:67%;" />

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131307249.png" alt="image-20230513130701100" style="zoom:67%;" />

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131314020.png" alt="image-20230513131425930" style="zoom:67%;" />

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131328887.png" alt="image-20230513132827828" style="zoom:67%;" />

![image-20230513132911252](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131329327.png)

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131330374.png" alt="image-20230513133034332" style="zoom:67%;" />

### @restController

![image-20230513133331361](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131333405.png)

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305131336495.png" alt="image-20230513133659439" style="zoom:67%;" />

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305132146667.png" alt="image-20230513214147271" style="zoom:67%;" />

## 4、分层解耦

### 三层架构

1. controller：控制层、主要就是接受前端发送的请求，对请求进行处理，并且响应数据
2. service：业务逻辑层，处理具体的业务
3. dao：数据访问层（Data Access Object）（持久层），数据的访问、增删改

### 分层解耦

软件设计原则是：高内聚低耦合

内聚是程序内部的联系

耦合是层与模块之间的依赖和联系

### IOC & DI

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305141040063.png" alt="image-20230514104051863" style="zoom:67%;" />

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305141044328.png" alt="image-20230514104429149" style="zoom: 50%;" />

### IOC

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305141049762.png" alt="image-20230514104920638" style="zoom:67%;" />

### DI

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305141055138.png" alt="image-20230514105525080" style="zoom:67%;" />

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305141104877.png" alt="image-20230514110419731" style="zoom:67%;" />

## MySQL

### DDL

ddl：Data Definition Language 数据定义语言，用来定义数据库对象（数据库、表）

### DML

dml：数据表操作

### DQL

dql：数据查询

### 事务

要么同时成功、要么同时失败

MySQL中的事务是自动提交的

事务控制

1. 开启事务：start transaction / begin
2. 提交事务：commit
3. 回滚事务：rollback

**四大特性**

- 原子性 要么全部成功，要么全部失败
- 一致性 事务完成时，必须使所有的数据状态保持一致
- 隔离性 事务运行时，不会受到外部的并发操作影响
- 持久性 事务一旦提交或者回滚就对数据库中的操作改变了



## Mybatis

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305141751637.png" alt="image-20230514175054483" style="zoom:67%;" />

### JDBC

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305142013108.png" alt="image-20230514201114123" style="zoom:67%;" />

![image-20230514201140702](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305142013021.png)

#### 数据库连接池

![image-20230514201443987](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305142014057.png)

![image-20230514201524535](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305142015613.png)

### lombok

java类库

加上@Data就自动生成

![image-20230514201816583](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305142018721.png)

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305142023851.png" alt="image-20230514202315733" style="zoom:67%;" />

新增返回主键

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305142024177.png" alt="image-20230514202416023" style="zoom:67%;" />

### xml配置

![image-20230514202908811](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202305142029989.png)