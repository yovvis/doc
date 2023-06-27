# 	**JavaWeb**

## 1、基本概念、

### 1.1静态web

![image-20220313133025611](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171051024.png)

静态web存在的缺点： 数据无法持久化，用户无法交互

### 1.2动态web

如果web崩了，需要停机维护，重新发布**后台程序**

优点：可以动态更新！！！可以交互！！！数据持久化（注册）

![image-20220313134346000](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171051379.png)

## 2、web服务器

### 2.1技术讲解

asp：微软的，在html中嵌入了VB的脚本

 php：开发速度快，功能强大，跨平台但是无法承载大访问量

jsp：servlet  sun公司主推的B/S（浏览/服务器）架构C/S（客户端/服务器）

### 2.2web服务器

被动的操作，用来处理客户端的请求与相应

## 3、Tomcat

### 3.1配置

1、java环境变量没有配置

2、闪退问题，需要改兼容

![image-20220313140406516](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171051360.png)

tomcat：8080

mysql：3306

http：80

https：443

**网站是如何访问的**

![image-20220313142431705](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171052552.png)

## 4、Http

什么是http：超文本传输协议

文本：html，字符串

超文本：图片、音乐、视频

```
Request URL: https://www.baidu.com/s?ie=UTF-8&wd=%E7%99%BE%E5%BA%A6
Request Method: GET
Status Code: 200 OK
Remote Address: 180.101.49.11:443
Referrer Policy: strict-origin-when-cross-origin
```



### 4.1http请求

客户端----发request----服务器

```html
Accept: text/html
Accept-Encoding: gzip, deflate, br
Accept-Language: zh-CN,zh;q=0.9  语言
Connection: keep-alive
Cookie: 
User-Agent:
Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36
```

**请求行**

请求方式：

```html
get：请求携带的参数较少，大小有限制，会在浏览器url地址栏显示数据内容，不安全但是高效
post：请求能够携带的参数没有限制，大小没有限制，不会在url地址栏显示数据内容，安全但是不高效
```

### 4.2http响应

服务器----响应reponse----客户端

响应头

```html
Cache-Control: private  缓存控制
Connection: keep-alive  保持链接
Content-Encoding: br    编码
Content-Type: text/html;charset=utf-8  上下文类型
Server: BWS/1.1              
Set-Cookie
```

#### 响应状态码

200：请求响应成功

3xx：请求重定向 

4xx：找不到资源  404

5xx：服务器代码错误    502：网关错误    500

**常见面试题目**

从地址栏写了一个url敲击回车后到页面能展示回来，经历了什么？

## 5、Maven

因为在javaweb开发中需要导入大量的jar包

maven仓库可以自动帮我们导入jar包

### 5.1Maven项目架构管理工具

核心思想：**约定大于配置**

![image-20220313145930777](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171052591.png)

### 5.2阿里云镜像下载

```xml
<mirror>
    <id>ali</id>
    <name>ali Maven</name>
    <mirrorOf>*</mirrorOf>
    <url>https://maven.aliyun.com/repository/public/</url>
</mirror>
*老版*
<mirror>
    <id>nexus-aliyun</id>
    <name>Nexus aliyun</name>
    <mirrorOf>central</mirrorOf>
    <url>https://maven.aliyun.com/nexus/content/groups/public/</url>
</mirror>
```

### 5.3标记文件夹功能

![image-20220313152421182](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171052500.png)

### 5.4虚拟路径映射

![image-20220313154154468](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171052077.png)

## 6、Servlet

servlet 接口有两个默认实现类

### 6.1servlet简介

servlet程序就是把一个实现servlet的java程序部署到tomcat服务器中去

实现了servlet接口的java程序叫servlet

### 6.2删除src

关于maven父子

父项目中会有<modules>

子项目中会有<parents>

maven必须上4.0不然没有<parent>

### 6.3Servlet编写步骤

1、编写一个普通类

2、实现一个servlet接口extends HttpServlet

3、编写servlet映射：编写的是java程序，浏览器访问需要在web服务器中注册servlet，还有一个给浏览器访问的路径

```xml
<!--    注册servlet-->
    <servlet>
        <servlet-name>hello</servlet-name>
        
    </servlet>
<!--    servlet的请求路径-->
    <servlet-mapping>
        <servlet-name>hello</servlet-name>
        <url-pattern>/hello</url-pattern>
    </servlet-mapping>
```

4、配置tomcat

### 6.4Servlet运行原理

![image-20220313213357616](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171052208.png)

### 6.5Mapping

一个Servlet可以指定一个映射路径

一个Servlet可以指定多个映射路径

一个Servlet可以指定通配符路径     

指定固有的mapping路径优先级最高        /*优先级比web.xml高            ***.do就是通配符**

### 6.6ServletContext

![image-20220314090808627](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171052469.png)

#### 1、共享数据：

Servlet01： this.getServletContext创建一个Context对象，然后用getAttribute得到的保存的值,然后设置响应格式

#### 2、web.xml参数

实现getServletContext（）方法

```xml
<context-param>
    <param-name>url</param-name>
    <param-value>com.cru.Demo01</param-value>
</context-param>
```

#### 3、请求转发

```java
 ServletContext context = getServletContext();
        context.getRequestDispatcher("/hello	").forward(req,resp);
```

![image-20220314103937791](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171052444.png)

#### 4、读取资源文件

在java下或者resources下都可以，但是在java下面需要新加依赖

classpath:类路径在WebINFO下面的类路径

如果在java下面的properties的文件想要被加载就需要

```xml
    <build>
        <resources>
            <resource>
                <directory>src/main/java</directory>
                <includes>
                    <include>**/*.properties</include>
                    <include>**/*.xml</include>
                </includes>
                <filtering>true</filtering>
            </resource>
        </resources>
    </build>
```

我们需要一个文件流来读取properties文件

```java
InputStream is = getServletContext().getResourceAsStream("/WEB-INF/classes/db.properties");
        Properties properties = new Properties();
        properties.load(is);
        String user = properties.getProperty("username");
        String pwd = properties.getProperty("password");
```

### 6.7HttpResponse

- 获取客户端请求的参数HttpRequest
- 响应客户端一些信息:HttpResponse

#### **1、简单分类**

向浏览器发送请求的方法

response.getWriter( ).print();可以输出html也可以输出对象

response.getWriter( ).write()；只能打印输出文本格式

向浏览器发送响应的方法

就是编写响应头

2、常见应用

1、向浏览器输出信息

#### 2、**下载文件**

​		**1获取下载的路径**

​		**2下载的文件名**

​		**3让浏览器支持下载我们所需要的东西**

​		**4获取文件的输入流**

​		**5.创建缓冲区**

​		**6.获取OutputStream对象**

​		**7.将FileOutputStream写入到buff缓冲区**

​		**8.使用OutputStream将缓冲区的数据写入到客户端**

#### 3、验证码功能

验证码怎么实现？

- 前端实现js
- 后端实现需要用到java的图片类（image），生成一个图片

```java
    //如何让浏览器五秒自动刷新一次
    resp.setHeader("refresh", "5");
    //创建一个图片（里面是空的图片）
    BufferedImage image = new BufferedImage(80, 20, BufferedImage.TYPE_3BYTE_BGR);
    //得到图片
    Graphics2D g = (Graphics2D) image.getGraphics();//画笔
    //设置图片的背景颜色
    g.setColor(Color.white);
    g.fillRect(0,0,80,20);
    //给图片生成随机数
    g.setColor(Color.BLUE);
    g.setFont(new Font(null,Font.BOLD,20));
    g.drawString(makeNum(),0,20);
    //告诉浏览器用图片的形式打开
    resp.setContentType("image/jpeg");
    //不让浏览器缓存
    resp.setDateHeader("expires",-1);
    resp.setHeader("Cache-Control","no-cache");
    resp.setHeader("Pragma","no-cache");
    //把图片写给浏览器
    ImageIO.write(image,"jpg",resp.getOutputStream());

}
private String makeNum(){
    Random random = new Random();
    String num = random.nextInt(9999999) + "";
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i <7-num.length() ; i++) {
        sb.append(i);
    }
    num = num + sb.toString();//不推荐浪费内存
    return num;
}
```

#### 4、重定向

```java
resp.setHeader("location","/Resp/img");
resp.setStatus(302);
//resp.sendRedirect("/Resp/img");
```

请你聊聊重定向和请求转发的区别

相同点：页面都会跳转

不同点：

请求转发，url地址栏不会发生变化

重定向，url地址会发生变化

重定向一定要加个项目

### 6.8HttpRequest	

#### 1、获取前端参数

req.getparameter()

#### 2、请求转发

请求转发的/直接代表了工程名

req,getContextPath()直接得到项目工程名字     /req

直接拼接req,getContextPath()+“/hello”是可以实现的

转发是服务器行为（url不变），重定向是客户端行为（url地址改变）

前端路径从web开始，java路径从src开始

客户端路径以“/”开头：相对当前主机；

服务器端路径以“/”开头：相对当前应用；

## 7、Cookie、Session

### 7.1会话

**会话：**用户打开一个浏览器，点了很多超链接，访问了很多个web资源，关闭浏览器，这个过程就称之会话

一个网站，怎么证明你来过？？？？

 C  客户端     S  服务端

1、服务端给客户端一个key 下次来带上key就行   cookie

2、服务器登记你来过了，下次来就匹配你：   session

### 7.2两种技术

保存对话的两种技术

cookie

- 客户端技术（响应，请求）

session

- 服务器行为，利用这个技术可以保存用户的会话信息

### 7.3Cookie

![image-20220318134344545](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171053092.png)

常见应用，网站登录下次不用再输入

1、从请求中拿到cookie信息

2、从服务器响应给客户端cookie

```java
 Cookie[] cookies = req.getCookies();//获得cookie
 cookie.getName();//获得cookie中的key
 cookie.getValue();//获得cookie的value
 new Cookie("key","value");//新建一个cookie
 cookie.setMaxAge();//设置cookie有效期  /天
 resp.addCookie();//响应一个Cookie
```

**cookie一般保存在appdata下**

```java
  req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html");

        PrintWriter out = resp.getWriter();
        //cookie,服务器从客户端获得
        Cookie[] cookies = req.getCookies();
        //判断cookie是否存在
        if (cookies!= null) {
            out.print("上一次访问的时间是");
            for (int i = 0; i < cookies.length; i++) {
                Cookie cookie = cookies[i];
                //获取cookie的名字
               if (cookie.getName().equals("lastLoginTime")){
                   long l =  Long.parseLong(cookie.getValue());
                   Date date = new Date(l);
                   out.write(date.toLocaleString());
               }
            }
        } else {
            out.print("这是第一次访问");
        }
        //服务器给客户端响应一个cookie
        Cookie cookie = new Cookie("lastLoginTime", System.currentTimeMillis()+"");
```

- 一个cookie只能保存一个cookie信息
- 一个web站点可以给浏览器发送多个cookie，最多存放20个
- cookie大小上限是4KB
- 300个cookie浏览器上限

删除Cookie

- 不设置有效期，关闭浏览器
- 设置有效期为0

出现编码错误最快的是URLDecoder.decode(xxx，"UTF-8"）

### 7.4Session

![image-20220318134456632](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171053036.png)

- 服务器会给每个浏览器创建一个session对象
- 一个session独占一个浏览器，浏览器不关闭，这个session一直存在
- 用户登录后，整个网站都可以访问——>保存用户的信息，保存购物车的信息

session在创建的时候，实际上是将session.id放入cookie中

注销的话相当于关了浏览器，每个浏览器都会自己产生一个新的sessionid

Session与Cookie的区别

- cookie是用户写给服务器，浏览器可以多个保存

- session是服务器把用户数据写到用户单独的session中
- session对象由服务器创建

使用场景：

- 登录界面
- 购物车信息
- 在整个项目中经常会使用的数据，将其保存在session中

```java
 req.setCharacterEncoding("UTF-8");
//        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=utf-8");

        //得到session
        HttpSession session = req.getSession();
        //给session写入东西
        session.setAttribute("name","user");
        //获取session的id
        String id = session.getId();
        //判断是不是新建的session
        if (session.isNew()){
            resp.getWriter().write("session是新建的.id:"+id);
        }else {
            resp.getWriter().write("session已经存在,id为" + id);
        }
        //注销session
		session.invalidate();
```

自动注销

```xml
<session-config>
    <!--单位是分钟-->
    <session-timeout>15</session-timeout>
</session-config>
```

## 8、JSP

java service pages  和servlet用于动态web技术

最大特点：

- 写jsp就像是写Html

- 区别

  - html是静态

  - jsp可以嵌入jsp

    tomcat中有个work目录

    idea中tomcat会在地下生成work目录

![image-20220318140106347](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171053730.png)

### 8.1jsp原理

jsp最终也会变成java类

jsp本质上就是一个servlet

```java
 public final void init()
 public final void destroy()
 public final void service()
```

1、判断请求

2、内置对象

![image-20220318142532385](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171053770.png)

3、输出页面前增加的代码

![image-20220318142544427](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171053432.png)

4、以上这些对象在jsp中可以直接使用

![image-20220318142835651](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171053379.png)

在jsp界面中就原封不动的输出，如果是html代码就会转化为out.write

需要在pom.xml中配置

```xml
<!--        jsp依赖-->
        <dependency>
            <groupId>javax.servlet.jsp</groupId>
            <artifactId>javax.servlet.jsp-api</artifactId>
            <version>2.3.3</version>
        </dependency>
<!--        jstl表达式依赖-->
        <dependency>
            <groupId>javax.servlet.jsp.jstl</groupId>
            <artifactId>jstl-api</artifactId>
            <version>1.2</version>
        </dependency>
<!--       standard标签库 -->
        <dependency>
            <groupId>taglibs</groupId>
            <artifactId>standard</artifactId>
            <version>1.1.2</version>
        </dependency>
```

### 8.2jsp基础语法

支持java语法，自己也拥有自己扩充的语法

#### **JSP表达式**

```jsp
<%--jsp表达式
作用：
将程序的输出，输出到客户端
--%>
  <%= new java.util.Date()%>  ===${}
```

#### **JSP脚本片段**

```jsp
<%--jsp脚本片段
作用：
脚本片段
--%>
<%
  int sum = 0;
  for (int i = 1; i <= 100; i++) {
    sum+=i;
  }
  out.print("<h1>sum"+sum+"</h1>");
%>
```

```jsp
<%--在代码中嵌入HTML元素--%>
<%
  for (int i = 0; i < 5; i++) {
%>
  <h1>hello,word</h1>
<%
  }
%>
```

#### **JSP申明**

```jsp
  <%!
      static {
          System.out.println("Lodding servlet");//被执行
      }
      static int globleVar = 0;
      static void output(){
          System.out.println("进入了此方法");//
      }
  %>
```

jsp申明会被编译到jsp生成java类中，其他的就会被生成到jspService方法中

JSP的注释不会被html显示

### 8.3JSP指令

相对路径的

**"./"：代表目前所在的目录。**

**" . ./"代表上一层目录。**

**"/"：代表根目录**

设定专门页

```jsp
<%@page   %>//设置特定的错误页面
<%@page errorPage="error/error.jsp" %>
<%@ page isErrorPage="true" %>//选定当前jsp是专门的错误界面
```

提取公共页

```jsp
<%--include是将两个网页合二为一,在static里面--%>//<% int i %>
<%@include file="/common/header.jsp"%>
    <p>网页主体</p>
<%@include file="/common/footer.jsp"%>
<hr>
<%--jsp标签实际上还是三个界面，在service里面--%>
<jsp:include page="../common/header.jsp"></jsp:include>
    <p>主体网页</p>
<jsp:include page="../common/footer.jsp"></jsp:include>
```

### 8.4九大内置对象

- **PageContext  存东西**
- **Request   存东西**
- Reponse
- **Session 存东西**
- **Application【ServletComtext】存东西**
- config【ServletConfig】
- out
- page
- exception

JVM中的双亲委派机制

```jsp
<%--内置对象--%>
<%
    pageContext.setAttribute("name1","清风");//在一个页面中有效
    request.setAttribute("name2","清风");//在一次请求中有效，请求转发会携带数据
    session.setAttribute("name3","清风");//保存的数据在一次会话中有效，从打开浏览器到关闭浏览器
    application.setAttribute("name4","清风");//在服务器中有效，从打开服务器到关闭服务器
%>
<%--通过pageContext取存放的东西--%>
<%
    String name1 = (String) pageContext.findAttribute("name1");
    String name2 = (String) pageContext.findAttribute("name2");
    String name3 = (String) pageContext.findAttribute("name3");
    String name4 = (String) pageContext.findAttribute("name4");
    String name5 = (String) pageContext.findAttribute("name5");//不存在
%>
<%--EL输出--%>
<h1>取出的值为${name1}</h1>
<h1>取出的值为${name2}</h1>
<h1>取出的值为${name3}</h1>
<h1>取出的值为${name4}</h1>
<h1>取出的值为${name5}</h1>//不显示
<h1>取出的值为<%=name5%>></h1>//null
```

![image-20220321200730381](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171053447.png)

request：客户端向服务器发送请求，产生的数据用户看完一次就没了：新闻

session：客户端向服务器发送请求，产生的数据用户看完还有用的：购物车

application：客户端向服务器发送请求，产生的数据，一个用户用完了，其他用户还能用：聊天数据

### 8.5JSP/JSTL/EL标签

需要导包

```xml
<!--        jstl表达式依赖-->
        <dependency>
            <groupId>javax.servlet.jsp.jstl</groupId>
            <artifactId>jstl-api</artifactId>
            <version>1.2</version>
        </dependency>
<!--       standard标签库 -->
        <dependency>
            <groupId>taglibs</groupId>
            <artifactId>standard</artifactId>
            <version>1.1.2</version>
        </dependency>
```

EL表达式：${ }

- **获取数据**
- **执行运算**
- **获取web开发的常用对象**

```jsp
<jsp:include page="../common/header.jsp"></jsp:include>
    <p>主体网页</p>
<jsp:include page="../common/footer.jsp"></jsp:include>
<jsp:forward page="../jsp/jsp2.jsp">
	<jap:param name="name" value="cru"></jap:param>
    <jap:param name="age" value="12"></jap:param>
</jsp:forward></jsp:forward>
```

JSTL表达库

使用JSTL标签库就是为了弥补Html标签的不足；因为它**自定义了许多标签，标签的功能和java代码一样**

**核心标签（掌握）**（格式化标签、sql标签、XML标签）

引入jstl核心标签库

![image-20220323153553940](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171054714.png)

JSTL标签库使用步骤

- 引入对应的taglib

  ```jsp
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  ```

  在tomcat中也需要引入jstl包和stand包

![image-20220401131213610](https://tyangjian.oss-cn-shanghai.aliyuncs.com/javaweb/202210171054561.png)