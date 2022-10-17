# Java高级

perference—>General—>Content Type修改UTF-8字符编码

代码补全perference—>java—>editor—>content assist

jdbc概念：java data base connectivity  就是java数据库连接，是一种执行SQL语句的JavaAPI，它是一组用java语言编写的类和接口组成

B/S架构：浏览器/服务器

C/S架构：客户端/服务器

## 1、jdbc工作原理

![image-20220704125931763](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171113327.png)

## 2、jdbc常用api

![202210171109528](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171131218.png)

## 3、jdbc访问数据库过程

![202210171109888](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171131310.png)

![image-20220704170743829](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171114290.png)

工程图标右键—>Properties—>java build path —>add external jars—>oracle驱动包ojdbc6.jar

### 1.加载数据库驱动

```java
Class.forName("com.mysql.jdbc.Driver");

//Oracle
  driver="oracle.jdbc.driver.OracleDriver";
//MySQL
  driver="com.mysql.jdbc.Driver";
//SQLServer
  driver="com.mircrosoft.sqlserver.jdbc.SQLServerDriver";
```

### 2.建立连接

```java
Connection conn = DriverManager.getConnection(URL,UserName,Password);
//Oracle
url = "jdbc:oracle:thin:@IP:1521:实例名";
//MySQL
url = "jdbc:mysql://IP:3306/数据库名?useUnicode=true&characterEcoding=UTF-8";
//sqlserver
url = "jdbc:sqlserver://IP:1433;DatabaseName=数据库名";
```

### 3.增删改

```java
//statement只能静态sql
statement stm = conn.creatStatement();
Prestatement pstmt = conn.prepareStatement(sql);
//查询
ResultSet rs = pstmt.executeQuery();
//增删改DML
int i = pstmt.executeUpdate();
//任何语句
boolean flag = pstmt.execute();
```

![image-20220704171803862](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171057520.png)

### 4.结果集

```java
boolean next();
void beforeFirst();
String getString(int columnIndex);
int getInt(int columnIndex);
void close();
```

![image-20220704172132581](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171058220.png)

![image-20220704172348894](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171058320.png)

![image-20220704172745888](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171058900.png)

![image-20220704205550203](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171058646.png)

![image-20220704210050756](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171058489.png)

# Maven

![image-20220705071553432](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171058148.png)

![image-20220705071637684](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171058823.png)

```xml
<localRepository>D:/software/idea/maven/repository</localRepository>//本地仓库地址
<mirror>
    <id>ali</id>
    <name>ali Maven</name>
    <mirrorOf>*</mirrorOf>
    <url>https://maven.aliyun.com/repository/public/</url>
</mirror>
<mirror>
    <id>nexus-aliyun</id>
    <name>Nexus aliyun</name>
    <mirrorOf>central</mirrorOf>
    <url>https://maven.aliyun.com/nexus/content/groups/public/</url>
</mirror>
```

![image-20220705080812981](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171107422.png)

![image-20220705081647221](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171058305.png)

![image-20220705081721652](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171058702.png)

## maven指令

```java
pom.xml文件下执行cmd
mvn compile;//编译
mvn test;//测试
mvn clearn;//清理
mvn package;//打包
mvn install;//下载
```

![image-20220705082901193](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171058230.png)

![image-20220705083028912](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171058849.png)

![image-20220705083128314](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171059376.png)

![image-20220705083212860](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171059927.png)

![image-20220705090540745](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171059753.png)

![image-20220705090911366](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171059169.png)

## 创建Maven工程

```
1.配置maven拆插件
2.创建maven项目
3.右键项目properties设置project facts中的web moudle和java
```

![image-20220705091048810](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171059250.png)

```xml
<!-- 控制编译版本，否则每次maven update的时候都会恢复到1.5 -->
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.7.0</version>
    <configuration>
        <source>1.8</source>
        <target>1.8</target>
    </configuration>
</plugin>

<!-- tomcat插件配置 -->
<plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.2</version>
    <configuration>
        <port>8099</port>
    </configuration>
</plugin>
```

Run as mavenbuild tomcat7:run





# javaweb(epoint)

## 1、javaweb概念

![image-20220705151716459](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171059035.png)

![image-20220809164801280](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171059457.png)

## 2、B/S，C/S

![image-20220705151758004](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171059490.png)

## 3、HTTP通信协议

![image-20220705152508957](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171100636.png)

### 1.两个协议

![image-20220705153358869](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171100459.png)

### 2.请求协议结构

![image-20220705153745120](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171100736.png)

### 3.响应协议结构

![image-20220705153944289](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171100143.png)

### 4.状态码

![image-20220705154243284](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171100676.png)

![image-20220705154937583](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171100013.png)

### 5.get/post

![image-20220705155557072](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171100444.png)

## 4、web工程部署

![image-20220705171149255](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171100760.png)

```
workspace\.metadata\.plugins\org.eclipse.wst.server.core//服务器副本

1、把war包放在本地tomcat的webapp下

2、webContent目录下cmd：jar -cvf newName.war *
```

### 欢迎页

![image-20220705174106969](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171100190.png)

### 过滤器

![image-20220705181122885](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171101609.png)

### 错误页

![image-20220705184348254](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171101195.png)

## 5、Tomcat

![image-20220706073358390](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171101708.png)

```
1.检查是否有jdk
2.下载tomcat
3.start up启动shutdown 关闭
```

### 1.Tomcat目录结构

![image-20220706075442928](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171101189.png)

tomcat配置虚拟主机在config	server.xml配置文件中

在<Engine>中配置<host>，并且在server.xml中设置虚拟路径

### 2.Tomcat Server结构

![image-20220706075751785](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171101336.png)

### 3.部署应用程序

![image-20220706085250659](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171101456.png)

```java
//新增虚拟主机在 C:\windows\system32\drivers\etc\hosts修改dns
//在一个虚拟主机下运行多个web项目<Context path="" docBase=""/>
<Host name="www.etyj.test"  appBase="D:\test"
        unpackWARs="true" autoDeploy="true">
	<Context path="/testweb4" docBase="\web4"/>
    <!-- SingleSignOn valve, share authentication between web applications
         Documentation at: /docs/config/valve.html -->
    <!--
    <Valve className="org.apache.catalina.authenticator.SingleSignOn" />
    -->D

    <!-- Access log processes all example.
         Documentation at: /docs/config/valve.html
         Note: The pattern used is equivalent to using pattern="common" -->
    <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
           prefix="localhost_access_log" suffix=".txt"
           pattern="%h %l %u %t &quot;%r&quot; %s %b" />
</Host>
```

### 4.管理webapp

```
1.在tomcat默认欢迎页选择manager app
2.取消登录得到
<role rolename="manager-gui"/>
<user username="tomcat" password="s3cret" roles="manager-gui"/>
3.复制到conf目录下tomcat-users.xml中去
```

## 6、servlet

### 1.servlet概述

![image-20220706114246925](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171101201.png)

### 2.servlet工作原理

![image-20220706114516138](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171101771.png)

### 3.servlet生命周期

![image-20220706114611147](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171101150.png)

### 4.sertvletconfig

![image-20220708085323247](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171102132.png)

初始化参数重名只会显示第一个	

```java
String name = config.getInitParameter("name");
System.out.println(name);
String age = config.getInitParameter("age");
System.out.println(age);
//得到所有参数
Enumeration<String> initParam = config.getInitParameterNames();
while (initParam.hasMoreElements()) {
    String param = (String) initParam.nextElement();
    System.out.println(param);
}
String getServletName = config.getServletName();
System.out.println(getServletName);
ServletContext getServletContext = config.getServletContext();
System.out.println(getServletContext);
System.out.println("service方法被调用");
```



### 5.servletContext

![image-20220708091050362](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171102645.png)

```
<context-param>
	<param-name>name</param-name>
	<param-value>张三</param-value>
</context-param>
后面param会覆盖前面的
```

```java
ServletContext servletContext = config.getServletContext();
String real = servletContext.getRealPath("/test");
System.out.println(real);
String contextPath = servletContext.getContextPath();//D:\software\Eclipse\workspace\Servlet\src\main\webapp\test2
System.out.println(contextPath); //  /Servlet	
```

### 6.servlet相关配置

![image-20220708093502018](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171102436.png)

/xxx.xx非法

### 7.request

![image-20220708120916587](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171102166.png)

```java
System.out.println("get");
//请求时完整的url
StringBuffer requestURL = req.getRequestURL();
//请求行部分资源名称
String requestURI = req.getRequestURI();
//客户机请求头
String header = req.getHeader("");
//请求头中的参数名
Enumeration<String> headerNames = req.getHeaderNames();
while(headerNames.hasMoreElements()) {
    String headerName = headerNames.nextElement();
    String headerValue = req.getHeader(headerName);
}
//请求参数的值
String parameter = req.getParameter("");
//请求中的参数名
Enumeration<String> parameterNames = req.getParameterNames();
while(parameterNames.hasMoreElements()) {
    String param = parameterNames.nextElement();
    String paramValue = req.getParameter(param);
}
```

### 8.response

![image-20220708122509621](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171102612.png)

```java
Cookie cookie = new Cookie("name", "xiao");
//增加cookie
resp.addCookie(cookie);
//指定的名字添加到响应头
resp.addHeader("age", "20");
//重定向
resp.sendRedirect("/");
```

### 9.转发和重定向

![image-20220708131859748](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171102803.png)

```
重定向/  （客户端操作）代表localhost:8080
请求转发/ （服务器操作） webapp/
```

![image-20220708131915981](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171102110.png)

## 7、Filter

### 1.工作原理

![image-20220709130756027](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171102961.png)

```
三个方法
init()
dofilter()
destory()
```

### 2.filter的生命周期

![image-20220709130935138](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171102006.png)

### 3.filter创建部署

```xml
<!-- 过滤器 -->
	<filter>
		<filter-name>myfilter</filter-name>
		<filter-class>com.epoint.demo.TestFilter</filter-class>
        <init-param>
        	<param-name></param-name>
            <param-value></param-value>
        </init-param>
	</filter>

	<filter-mapping>
		<filter-name>myfilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
```

```java
@WebFilter(filterName="",urlPatterns="")//java
```

### 4.FilterConfig

![image-20220709132704069](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171103348.png)

### 5.Filter链

![image-20220709133038540](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171103051.png)

![image-20220709134812544](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171103803.png)

```java
//字符编码
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
response.setCharacterEncoding("UTF-8");
chain.doFilter(request, response);
```

```java
//访问权限
HttpServletRequest req = (HttpServletRequest) request;
HttpServletResponse resp = (HttpServletResponse) response;

HttpSession session = req.getSession();
if (session.getAttribute("username")!=null) {
    chain.doFilter(request, response);
}else {
    resp.sendRedirect(req.getContextPath()"../failure.html");
}
```

## 8、Cookie

（保存在客户端）

### 1.工作原理

![image-20220709142646294](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171103154.png)

### 2.Cookie的创建

![image-20220709150439661](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171103301.png)

### 3.Cookie的读取

### ![image-20220709150458079](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171103755.png)4.Cookie的常用方法

![image-20220709150508104](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171103712.png)

### 5.Cookie的分类

![image-20220709150520369](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171103015.png)

### 6.Cookie的限制

- Cookie可以被用户禁止
- Cookie会将状态保存在浏览器端，不安全。
- Cookie只能保存少量的数据4Kb
- Cookie的个数是有限的
- Cookie只能保存字符串

## 9、Session

（保存在服务器端）

### 1.Session对象的获取

![image-20220709150908640](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171103069.png)

### 2.常用方法

![image-20220709150932060](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171103110.png)

### 3.设置有效时间

![image-20220709150955788](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171103565.png)

### 4.销毁机制

- 直接调用了HttpSession中的invalidate()方法
- 超出session的最大有效时间
- 服务器卸载了当前的web应用

![image-20220709151127504](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171104196.png)

## 10、Ajax

### 1.工作原理

![image-20220710230301853](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171104987.png)

### 2.XMLHttpres对象

![image-20220710230342472](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171104401.png)

### 3.XHR常用属性

![image-20220710230446642](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171104679.png)

### 4.XHR常用方法

![image-20220710230637447](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171104254.png)

### 5.向服务器发送请求

![image-20220710230809965](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171104025.png)

### 6.响应服务器

![image-20220710230858565](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171104869.png)

![image-20220711084425805](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171104474.png)

```html
//获取XHR对象
function getXHR() {
    var xhr;
    if (window.XMLHttpRequest) {
        xhr = new XMLHttpRequest();
    }else{
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return xhr;
}
//按钮点击事件
function onButtonClick() {
    var xhr = getXHR();
    //发送ajax请求
    xhr.open("GET","info.txt",true);
    xhr.send();
    //接受响应
    xhr.onreadystatechange = function(){
        if(this.status == 200 && this.readyState == 4){
            console.log(this.responseText);
            document.getElementById("info").append(this.responseText);
        }
    }
}
```

![image-20220711154636491](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171108154.png)

### 7.Jquery的ajax

![image-20220711133853603](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171105315.png)

## 11、JSON

### 1.语法格式

![image-20220711154826574](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171105439.png)

![image-20220711154841995](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171105251.png)

### 2.json的转化

字符串—>json

```
JOSN.parse(字符串)
```

json—>字符串

```
JSON.stringify(json对象)
```

### 3.json的遍历

![image-20220711155950780](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171105008.png)

### 4.json对象数组

![image-20220711160059790](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171105991.png)

### 5.fastjson库

```xml
<!-- fastjson依赖 -->
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>fastjson</artifactId>
    <version>1.2.47</version>
</dependency>
```

![image-20220711160422258](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171105252.png)

![image-20220711161512553](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171105724.png)

## 12、fileupload

![image-20220711161935640](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171106433.png)

```xml
<!-- fileload 组件依赖 -->
<dependency>
    <groupId>commons-fileupload</groupId>
    <artifactId>commons-fileupload</artifactId>
    <version>1.3.1</version>
</dependency>

<dependency>
    <groupId>commons-io</groupId>
    <artifactId>commons-io</artifactId>
    <version>2.4</version>
</dependency>
```

### 1.上传原理

![image-20220711162519821](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171106301.png)

### 2.示例

![image-20220711162623736](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171106446.png)

```java
// 为基于磁盘的文件项创建工厂
DiskFileItemFactory factory = new DiskFileItemFactory();

// 设置工厂约束
factory.setSizeThreshold(yourMaxMemorySize);//单位B
File file = new File("D:/epoint/temp");
factory.setRepository(file);

// 创建一个新的文件上传处理程序
ServletFileUpload upload = new ServletFileUpload(factory);

// 设置整体请求大小约束
upload.setSizeMax();

// 解析请求
List<FileItem> items = upload.parseRequest(request);
```

![image-20220711162828754](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171106431.png)

```java
Iterator<FileItem> iter = items.iterator();
while (iter.hasNext()) {
    FileItem item = iter.next();

    if (item.isFormField()) {
        processFormField(item);
    } else {
        processUploadedFile(item);
    }
}
```

![image-20220711162842752](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171106112.png)

![image-20220711162912555](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171106657.png)

![image-20220711162919758](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171106466.png)

![image-20220711163006066](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171106574.png)

### 3.文件下载

```html
<a href="a.rar"></a>//右键下载，点击打开
```

![image-20220711175202575](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171106092.png)

## 13、log4j

### 1.组成

### ![image-20220711200834414](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171107354.png)	2.输出端

![image-20220711200852937](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171107911.png)

### 3.日志格式化

![image-20220711200917422](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171107608.png)

![image-20220711200926952](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171107977.png)

### 4.记录器

![image-20220711200943317](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171107518.png)

![image-20220711200957062](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171107874.png)

### 5.配置文件

![image-20220711201018455](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171107172.png)

![image-20220711201034857](https://raw.githubusercontent.com/tyangjian/picture/main/javawebe/202210171107198.png)