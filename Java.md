# Java深层理解

## （一）JVM内存机制

![image-20220502164736340](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171042244.png)

![image-20220426210035735](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171041524.png)

- jdk8之前：元信息、常量池、静态变量—(存储)—>永久代—(实现)—>方法区
- jdk8以后：元信息—(存储)—>元空间—(实现)—>方法区              常量池、静态变量—(存储)—>堆

user——>编写Java字节码程序——>JVM解释（——>机器码——>cpu）——>操作系统理解——>硬件

### 1、程序计数器（私）

在解释器解释后，记住下一条jvm指令的执行地址，物理上是寄存器实现的。

- 程序计数器不会存在内存溢出问题，是Java规定的。

### 2、栈 stack（私）

线程运行时的需要内存空间

栈帧：每个方法（参数、局部变量、返回地址）运行时需要的内存

### 3、堆 heap（共）

### 4、method（共）



## （二）类加载机制

![image-20220426214109405](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171041698.png)

![image-20220504113118190](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171039101.png)

![image-20220504113201011](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171042078.png)



（准备）就在堆中实现了static变量赋默认值和常量池（逻辑上在）

（初始化）初始化阶段执行类变量和静态代码块：cinit方法：静态变量与静态代码块（在调用子类cinit确保父类cinit方法已经调用）

（使用）init方法

- 每次创建都会执行
- 调用父类cinit方法
- 非静态变量的赋值
- 构造代码块
- 构造函数

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202212191649796.png" alt="image-20220502162745697" style="zoom: 67%;" />

## （三）、反射机制

- java反射机制是在运行状态中，对于任意一个类，都能知道这个类的所有属性和方法。反射是动态调用对象、动态获取信息。

  优点缺点

  <img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202212191650675.png" alt="image-20221219164305199" style="zoom:50%;" />

反射的调用

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202212191650519.png" alt="image-20221219164446293" style="zoom:50%;" />

class对象的三种方式

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202212191650543.png" alt="image-20221219164535616" style="zoom:67%;" />

生成类对象

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/temp/202212191646871.png" style="zoom: 50%;" />

获取变量和方法

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202212191652334.png" alt="image-20221219165252241" style="zoom: 67%;" />

### 反射应用

1、Mybatis

2、basedao（find(sql，xxx.class)）

3、dataBean

# **Java**

## （一）Java概述

### **1、编程语言**

汇编语言和高级语言

### **2、Java语言特点**

- 面向对象：封装、继承、多态
- 跨平台：主要体现在Java虚拟机
- 适合分布式项目：Java有支持HTTP和FTP等基于TCP/IP协议的子库

### **3、Java语言分支**

- JavaSE：标准版本，包含Java核心api
- JavaEE：企业版本，开发服务器Java应用程序
- JavaME：用于手机和其他嵌入式平台

### **4、术语介绍**

- JRE：Java运行环境（runtime）
- JDK：Java开发环境（develop kit）
- JVM：Java虚拟机，用来运行Java编译文

### 5、JDK安装

默认在C盘下面：C:/programe/java

- JDK需要
- 源代码需要包含API
- 公共环境就不需要了

***JDK文件目录：***

1. bin：bin目录下面直接cmd可以查看版本号
   - Java编译器——javac.exe     javac [options] file
   - Java解释器——java.exe       java [options]  classname  [args]
   - Applet浏览器——appletviewer.exe 
   - API文档生成器——javadoc.exe
2. lib：library功能包
3. include：c++头文件
4. jre：java运行环境
5. src压缩文件：Java源码

***环境变量设置：***

- Java主目录（JAVA_HOME）和指令目录（%JAVA_HOME%\bin）=直接path配置bin
- CLASSPATH：.%JAVA_HOME%\lib;%JAVA_HOME%\lib\tools.jar

### **6、Java运行机制**

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171044349.png" alt="image-20220426120648317" style="zoom: 67%;" />

***JVM：***

- 运行Java字节码的虚拟计算机系统
- 有解释器组件可以实现Java字节码和操作系统之间的通信

### **7、开发工具**

- 文本编译器工具
- 集成开发工具

## （二）**数据类型**

### **1、数据类型**

![image-20220426195645453](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171044569.png)

基本类型的变量有原始值、引用类型的变量有引用值

![image-20220426200011268](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171044271.png)

***0 ：48           A：65        a：97***

### **2、基本数据类型**

byte——short——int——long——float——double

————char——

- 自动转换（小到大）数值小的直接赋值给大的(向上转型)
- 强制转换（类型）
- 表达式类型：自动提升，short+int返回int类型
- short和char是平级但是也是需要强转

### **3、引用数据类型**

引用类型，变量一旦声明后**类型**就不能改变，默认值都是null

### **4、Java变量**(4)

[变量类型] [变量名] 变量可以被初始化和赋值，区分大小写

可以多个同类型用，隔开int a,b,c;

***变量类型：***

- 类变量：独立于方法之外的变量，static修饰
- 实例变量：独立于方法之外的变量，没有static修饰
- 局部变量：类方法中的变量（必须初始化，不使用不报错）

### **5、变量声明**

变量只有在他的作用域中才是有效的

```java
int num = 10;
if(num == 10){
	int num1 = num*num;{
        int num2 = num*num1;
    }
    //num1此时还是有效，num2已经无效
}//num1已经无效
```

### **6、运算符与表达式**

- 算术运算符+ - * / % ++ --（只能操作变量。也不能是表达式）
- 赋值运算符=  +=   -=  /= 
- 比较运算符==  !=  >  <  >=  <=
- 逻辑运算符 & |  !  &&（短路与：前面的是flase,就不会计算后面的）  ||（短路或：前面是true就不会计算后面的）
- 三目运算符 **[表达式] ？[true]:[false]**
- 位运算符&  |  ~  ^  <<  >>  >>>（无符号右移）

表达式就是运算符和操作数组成

### **7、运算符的优先级**

![image-20220427085912659](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171044311.png)

### **8、条件语句**

- if
- if - else
- if - elseif - else
- switch - case 

### **9、循环语句**

- while
- do while
- for 循环

### **10、跳转语句**

- break：结束整个循环
- continue：结束当前循环，继续后面循环
- return：终止方法

## **（三）数组和方法**

### 1、数组

#### **1.数组声明**

数据类型[ ] 数组名    数据类型 数组名[ ]

#### **2.初始化**

- 静态 str = new int[]{"a","b","c"}  或者int[] str = {“1”，“2”，“3”}
- 动态 int str = new int[ 6 ]

#### **3.数组使用**

- 访问数组元素 strs[index]
- 获取数组长度 strs.length
- 数组遍历 for each/for循环
- 数组工具类Arrays   Arrays.sort(int[ ])//数组排序

**基本类型使用初始化**

int[ ] str = new int[3];   在Java虚拟机栈内存中有一个str 堆内存中开辟了三个int长度的空间并赋值0

引用类型使用的初始化

![image-20220428094155569](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171044296.png)

```java
int[] students = new int[2];
Stusent zhang  = new Student(15,158)
students[0] = zhang;//就是把zhang引用对象的地址给了【0】这里
Student lee = new Student(16,161)
studnets[1] = lee;//就是把lee引用对象的地址给了【1】这里
//System.out.println（studnet[0]）或者zhang都是他们的地址
```

#### **4.二维数组**

定义方式：int [ ] [ ]arrays;

初始化：arrays = new int[length] [ ]

二维数组的遍历：循环嵌套

### 2、方法

#### **1.方法的定义**(5)

访问修饰符 方法类型 返回值类型 方法名（参数类型 参数1，参数类型 参数2）{}

- 访问（方法）修饰符 public private protected  fefault
- 方法类型 类方法和 非静态方法
- 返回值类型 基本数据类型或者复合数据类型、也可以没有返回值
- 方法名 按照驼峰命名 首字母小写
- 参数列表 

#### **2.方法的所属性**

- 不能独立定义只能在类中定义
- 逻辑上，方法属于该类本身（static）要么属于该类的对象（实例方法）
- 不能独立执行，必须使用类或者对象调用

#### **3.方法参数传递机制**

**参数分两种：**形参和实参（10，2）

形参就是定义方法时候需要的参数，是虚拟的，实参是给方法调用时传递的参数

基本数据类型方法值传递实例/引用数据类型方法传递（实际上是引用变量副本）

![image-20220428123722924](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171044502.png)

#### **4.方法参数个数可变**

![image-20220428124548450](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171044742.png)

#### **5.方法递归**

递归要向已知的方向进行递归

#### **6.方法重载**(4)

两同一不同（同类同名不同参）与返回值无关

***重载的要求***：（参数类型不同参数个数不同）

- 参数是基本数据类型重载会从较小的升高
- 一般不推荐可变参数的方法

#### **7.Java方法注意点**

- 必须有数据类型
- return只能返回一次，结束方法
- 如果方法有返回值类型，返回值必须一致
- 定义一个新方法不能嵌套

## （四）面向对象基础

### **1、类与对象**

- 类：一类对象的共同特征
- 对象：用类的构造方法创建对象

### 2、对象的创建与访问

访问修饰符 class 类名{

成员变量：访问修饰符 类型 成员变量名

构造方法定义

- 成员变量：实例变量（属性）+类变量
- 构造方法：初始化类，java为每个类都提供了一个无参的构造方法

方法：实例方法+类方法

实例必须要初始化之后才能访问实例变量和实例方法

### 3、构造方法详解

***自定义了有参构造方法，系统就不提供默认构造方法***

- 修饰符：默认（default）、public、private、protected
- 规则：与类名相同、参数列表与方法参数传递一致

不能定义返回值，默认修饰是public，也不能使用void，使用new默认返回当前实例

(public) （非类方法）返回实例 类名（）{}   

- 构造方法重载

- this调用（this就是一个引用变量地址为new的对象的地址。非静态方法中可以省略this.）

  - this访问属性：this（参数）
  - this调用其他方法
  - this调用构造方法

  类方法中不能调用成员方法和实例对象

**static关键字（一个类中）**

- 类方法不能调用非静态方法
- 类方法不能调用实例变量

类方法可以直接使用类调用，this在此方法中没有指向合适的对象，因此this不能在类方法中使用

### 4、封装

对象的状态隐藏在对象内部

***特点：***

- 将对象的成员变量和实现细节隐藏，不允许外部访问
- 将方法暴露出来，通过方法控制对变量进行安全的访问

***解决方法：***

- 可以用有参的构造方法
- 设置get/set方法

### 5、访问修饰符

- 同一类  private  defalut  protected  public
- 同一包               defalut  protected  public
- 子类                                protected  public
- 全局                                                 public

### 6、包相关

***package***

- 解决重名
- 引入方式 package packagename；
- 有明确大小写 com.tyj（javac -encoding utf-8 -d . 类名.java）java com.epoint.(类名)

***import***

- 用于简化程序，导入指定包下的类，*表示导入该包下所有类
- Java默认的所有源文件都是导入java.lang下面的所有类
- 注意util与sql日期类问题
- 指定位置是javac -encoding utf-8 -d . Test.java : java com.tyj.Test
- com.epoint.Test t = new com.epoint.Test();

***import static***

- 静态导入，导入成员变量或者类方法（静态变量，静态方法）

### 7、Java常用包了解

- java.lang	包含java核心类，系统自动导入
- java.util      包含大量工具类 /接口集合类/接口 Arrays List Set
- java.net      网络编程相关
- java.io        文件io流
- java.text     java格式化相关
- java.sql      jdbc数据库编程相关类/接

## （五）面向对象进阶

### 1、继承

特点：实现代码复用、单继承，一个类只有一个直接父类】

语法：修饰符 class 类名 extends 父类名{ 内容 }

如果没有明确表明就是继承的java.lang.Object类

### 2、重写父类方法(5)

***规则：***

(加上@Override注解:会检查)常见重写toString（）和equals（）两个方法

- 方法名称相同，参数列表相同
- 子类的返回值和抛出的异常要比父类的返回值小或者相等
- 子类方法的访问权限要比父类更大或者相等
- private修饰的方法子类不能重写

### 3、super

子类的实例变量隐藏掉父类的实例变量时候，通过super调用，如果是类变量直接用父类名来调用

调用父类的构造方法

- super调用父类构造方法必须放在子类构造方法中的第一行，且不能出现this调用构造方法
- 不管是否使用super显示调用父类的构造方法，初始化类时候，总会调用一次父类的构造方法
- ![image-20220502155152412](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171044210.png)

### 4、多态

编译期类型和运行期类型不一致，对象实例不具备多态性，但是方法具备

- 向上转型：把子类对象赋值给父类引用变量
- 强制类型转换：obj和string

instanceof可以判断变量类型

### 5、继承和组合

继承表现的是is-a的关系，组合表达的是has-a的关系

### 6、final关键字

- 成员变量：必须显示指定初始值,引用类型的地址不可以更改，但是值是可以更改的
- 方法：不能被重写
- 类：不能被继承不可以有子类（String类、Math类、包装类）

### 7、抽象类（4）

**定义：**只要包含抽象方法的类成为抽象类，抽象方法只有方法签名，没有方法实现，使用abstract修饰方法和类

**规则：**

- 用abstract来修饰抽象类和抽象方法，抽象方法不能有方法体
- 抽象类不能被实例化，无法new来调用抽象类的构造方法
- 抽象类可以包含成员变量，方法，构造方法（不能创建实例，只要被子类调用），代码块，内部类
- 含有抽象方法的类就只能被定义为抽象类

**作用：**模板模式：从多个具有相同特征的类中抽象出一个抽象类作为子类的模板，从而避免子类设计的随意性。

**总结：**

- 抽象类只能用于继承
- 一般来说抽象方法是public
- static和abstract不能同时修饰同一个方法

### 8、接口（6）

**定义：**将抽象进行的更加彻底 定义一批类所需要遵守的规范。不关心这些类的内部属性和具体方法的实现，只规定这批类必须提供某些方法，实际上就是规范和实现分离的设计哲学。

interface 接口名 extends 父接口，父接口2{1、常量定义，2、默认方法定义：default 返回值 方法名 （参数列表）{方法体}，3、抽象方法}

**修饰符：**只能是public或者默认，命名规范：同类的命名规范

**静态常量：**成员变量public static final 修饰符

**定义方法：**普通方法默认添加abstract修饰，类方法和默认方法必须要有方法体

**接口继承：**多继承，逗号分隔

***接口与抽象类的对比***

**相同点：**

- 都不能被实例化
- 都包含抽象方法，实现接口或者继承抽象类的普通子类必须重写这些抽象方法

**不同点：**（5）

- 接口不能提供普通方法，抽象类可以
- ***接口能定义static方法（必须实现），抽象类可以***
- 接口只能定义静态常量，抽象类可以定义静态常量，也可以成员变量
- 接口不能有构造方法，抽象类可以有，主要被子类调用
- 一个类只能由一个抽象类父类，但是可以实现多个接口
- 接口里面不包含初始化代码块，但是抽象类可以

**面向接口编程：**就是has-a只不过是把接口组合进去，

- 工厂模式
- 命令模式

### 9、内部类

**定义：**将一个类的定义放在另一个类的定义内部，就是内部类

public class OutClass{//定义内部类}

**分类：**（不同内部类访问外部类属性和方法不同分类下；不同分类下内部类访问也不一样）

- 非静态内部类

- 静态内部类

- 局部内部类

- **匿名内部类（创建只需要一次使用的类，一般是接口的回调）**

- ```java
  cmd.processArray(scr, new Command(){
  public void processArray(int[] src){
  	System.out.println(src.length);
              }});
  class ProcessCommand{
      public void processArray(int[] scr ,Command cmd){
      		cmd.processArray(scr);
      }
  }
  ```

  

- https://www.runoob.com/w3cnote/java-inner-class-intro.html

### 10、包装类

基本数据类型与包装类的关系

java.lang.包装类名

char   java.lang,Character

**自动装箱、自动拆箱**

装箱：基本类型赋值给包装类或者object；Short a = 1；

拆箱：把包装类对象直接赋值给基本类型   short b =  a； 

String类型转化基本类型：Integer.parseInt(str)

Integer i = 1;实际上是调用了 Integer.valueof()

integer a = 127 == integer b= 127 这里就就是比较的地址（常量池）

integer c = 128  != integer d = 128  超出缓存地址

c.equal(d) 是true

## （六）初始化、垃圾回收

### 1、初始化

#### 1.静态初始化

clas{       ***static{ //静态初始化代码块，在类加载后执行  }***         }

在使用一个类前，类加载完成后，静态代码块自动执行（按照顺序执行）

#### 2.初始化代码块

clas{       ***{ //初始化代码块，在类加载后执行  }***         }

不能再外部调用，只能是创建对象时候隐式执行，在构造方法前执行（按顺序）

#### 3、对象初始化过程

- 顶级父类开始（static代码块）
- 顶级父类（初始化代码块）
- 顶级父类（构造函数）

![image-20220504162836132](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171044536.png)

### 2、单例模式

一般构造方法是public，在某些情况下，不允许其他类自由创建该类的对象。例如任务管理器（创建多个没有意义）

一个类始终只能创建一个实例，这个类成为单例类

***步骤：***

- 私有化构造方法
- 提供一个public static 方法 返回这个类的对象
- 添加一个静态变量用于缓存一创建的对象

- 懒汉模式：就是在静态方法中判断 对象是不是空的
- 饿汉模式：就是静态变量指向一个对象

### 3、垃圾回收

jre提供一个线程检测和控制，在cpu空间或者内存不足时候自动回收，但是没法控制回收时间和顺序。

***特征：***

- 只回收堆内存中的对象，不回收物理资源
- 无法准确控制垃圾回收的运行，对象失去他的引用后，系统就会合适的时候回收内存
- 在回收任何对象时候，会先调用他的finalize（），可以让这个对象复活（让一个引用变量重新引用该对象）。

![image-20220504170914668](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171044584.png)

***强制回收***

Runtime对象的gc（）或者System.gc（）建议系统进行垃圾回收

***Runtime.runtime().gc()***

java -verbose:gc Test

## （七）异常和工具类

### 1、eclipse使用

![image-20220504181803288](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171045445.png)

#### 快捷键

Ctrl+Alt+down 复制到下一行

### 2、异常机制

异常就是程序未经期望的错误

异常机制就是对这些异常进行处理的方式，异常机制使得代码阅读、编写和调试都更加井井有条。

#### 1.异常继承体系

![image-20220504205311177](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171045228.png)



RuntimeException（IndexOutofBounds，NumPointer， ClassCast）            ioException      SQL Exception

**格式：**

try{可能产生异常的代码}catch(Exception e 由小到大的){ 异常处理 }finally{  释放资源 }

e.getMessage();


#### 2.throw抛出异常

如果需要在程序中自行抛出异常，使用throw语句，抛出异常实例

**语法：throw Exception**

**注意：如果方法利用throw一个非RuntimeException异常就需要在函数定义声明时候加上throws异常类型，此时调用该方法的其他方法必须显式处理该异常**

#### 3.throws抛出异常

处理方式：try-catch     继续throws出去

#### 4.自定义异常

- 继承异常类
- 构造方法

#### 5.异常跟踪栈

e.printStackTrace();

#### 6.异常处理规则

只是针对不确定的地方

### 3、工具类

#### 1.Scanner

获取键盘输入

***常用方法：***

- hasNext()：是否还有下一个输入项
- hasNext()Xxx：获取字符串输入项
- xxxnextXxx()：获取下一个输入项
- （String） next()：获取下一个字符
- hasNextLine()：
- String nextLine()：

new Scanner(System.in)***//标准输入，键盘输入***

new Scanner(new file(”a.text“))***//读取文件输入***

#### 2.系统相关类

***System***

- getenv()：获取环境信息keySet()
- getProperties()：获取所有属性
- exit(int status)：退出运行中的程序，0位是指正常退出
- currentTimeMills()：返回当前时间的毫秒数(long)
- identityHashCode()：根据对象的地址计算  返回int
- gc()：通知垃圾回收机制

```java
Map<String,String> result = (Map<String,String>)System.getenv();
		for(String str:result.keySet()) {
			System.out.println(str);
		}
```

***Runtime***

- rt.availableProcessors()
- rt.freeMemory()
- rt.totalMemory()
- rt.maxMemory()

//windows下的exe可以直接执行 rt.exec("xxx.exe")

//执行其他目录下程序rt.exec(“C:\\Program Files(86)\\CCwork.exe”)

#### 3.其他常用类

##### ***Object类***

- equals()
- toString()
- finalize()
- Class<?> getClass
- int hashCode

jdk7中的Objects：对于空指针null值

##### ***String类***

有两种定义字符串的方法concat()连接字与+一致

- String  str = new String(“abc”);
- String str = "abc"

***String s = 1+2+'a'+"a"+1+2*** 

常用方法

- length()                                                         //获取字符串长度，数组用.length属性
- boolean startsWith(Sting s)                       //判断字符串的开头
- boolean endsWith(String)                         //判断字符串的结尾
- contains()                                                     //是否包含子串
- indexOf()                                                      //查找某个串的下标
- valueOf()                                                      //把各种类型的转化成字符串
- String[] spilt(String regex)                         //根据特定符号分割字符串为字串数组
- boolean matches(String regex)               //是否匹配指定的正则表达式
- boolean equals(Object)                            //是否相等区分大小写
- boolean equalslgnore(Object)                //不区分大小写
- String trim()                                                //去空格

***所有类的equals()和String类型的==区别***

equals()比的是值，引用类型==比的地址hascode

**String类的格式化输出**

String.format(String  format，Object...)

- %s字符串
- %c字符
- %bboolean
- %d十进制
- %x十六进制
- %o八进制
- %f浮点类型
- %%百分制
- %n换行
- %tx日期
- ***+******添加正负号***
- ***0数字前面补0***
- ***空格整数之前补上指定数量的空格***
- ***,数字分组***
- ***(括号包含复数***

![image-20220505175808820](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171045433.png)

String字符串的不可变性

##### ***StringBuffer类***

***(线程安全）***

- ***常用方法：***
- append(String str)
- delete(int start,int end)
- replace()
- int length()
- subString()
- **toString()**

##### ***StringBuilder类***

***(线程不安全)***

- append(double d)
- insert(int offset,int i)
- indexOf(String str,int index)//检索

***String、StringBuffer、StringBuilder***

- StringBuiler和StringBuffer是可变的
- String修改会产生新的对象
- StringBuilder线程不安全，但是运行效率高
- StringBuffer线程安全

##### *Math*类

***静态常量*** E PI

**常用方法：**

- 绝对值
- 四舍五入round()
- 平方根

##### ***Random类***

随机数random()——threadLocalRandom

##### ***BigDecimal类***

float、double在进行算数运算时引起精度丢失

**构造方法推荐**

- new BigDecimal(String)
- BigDecimal.ValueOf(double value)

**常用方法**

- add()
- subtract()
- multiply()
- divide()
- pow()

DecimalFormat 格式化数字（四舍五入、百分比、添加货币表示）

NumberFormat格式化

#### 4.日期时间类（util）

##### ~~*Data类*~~

**构造方法**

- Data()//底层调用System.currentTimeMillis()
- Data(long date)

**方法**

- boolean after(Data date)
- boolean before(Data date)
- long getTime()

##### ***Calendar类***

一个抽象类。常用方法

- getTime()
- setTime()
- void set(int year,int month, int day)
- void get(int field)
- void add(int field,int amount)

Calendar的容错性

cal.set(MONTH，13)//年份自动加1

cal.setLenient(false)//关闭容错

##### ***java.time包***

![image-20220505194322352](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171046519.png)

##### ***SimpleDateFormat类***

**功能：**将日期按照格式转化为字符串，将字符串以某种方式转化成日期

**常用方法：**

- public final String format(Data date)
- Public Date parse(String str) throws ParseException

void printTime(){

 ***SimpleDateFormat  sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")***

Data now = new Data();

sdf.format(now);//日期类变成字符串

String timeInfo = "1999-12-21 12:25:46";

sdf.parse(timeInfo)//字符串变成日期

#### 5.正则表达式

字符串匹配模板、可以对字符串进行查找、提取、分割、替换等操作（匹配、选择、编辑、验证）

Java中的转义字符\\\

![image-20220505200036994](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171046839.png)

![image-20220505200201054](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171046802.png)

Pattern类：是正则表达式编译后在内存中的形式

Match类：多个Matcher对象可以共享一个Pattern对象

![image-20220505200555837](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171046630.png)

![image-20220505200732513](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171046123.png)

## （八）集合泛型

#### 1、集合

##### 1.Collection

**集合层次图**

![image-20220506150441104](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171046337.png)

**常见方法**

- boolean add(Object o)    //向集合中添加一个元素
- boolean addAll(Collection c)    //将c集合中的元素加到指定集合
- void clear()  //清除集合中所有元素
- boolean contains(Object o)  //判断集合中是否包含指定元素
- boolean containsAll(Collection c)  //返回集合中是否包含集合c的所有元素
- boolean isEmpty()  //返回集合是否为空
- Iterator iterator()  //返回Iterator对象，用于遍历
- boolean remove(Object o)  //删除集合中的指定元素
- boolean removeAll(Collection c) //从集合中删除集合c中包含的所有元素
- boolean retainAll(Collection c)  //从集合中删除除了意外的所有元素
- int size()  //返回该集合里面元素的个数
- Object[]  toArray()  //将集合转换为数组

**集合遍历**

- 使用Iterator迭代器
- 使用foreach循环遍历
- 使用Lambda表达式遍历（Iterator接口的foreach方法）

```java
Collection collection = new HashSet();
		collection.add("Java编程");
		collection.add("jasdf");
		//使用Iterator迭代
		Iterator iterator = collection.iterator();
		while(iterator.hasNext()) {
			System.out.println(iterator.next());
		}
		//foreach方法
		for(Object obj:collection) {
			System.out.println(obj);
		}
		//Lambda
		collection.forEach(new Consumer() {
			public void accept(Object t) {
				// TODO Auto-generated method stub
				System.out.println(t);
			}
		});
collection.forEach(obj->System.out.println(obj));
```

##### 2.Set（接口）

常用实现类HashSet，TreeSet

***HashSet类***

不重复的数据集合（equals和hascode的值不相等）

***TreeSet类***

- 可以确保元素处于排序
- 支持自定义排序，如果是自定义的需要实现Comparable接口不然ClassCastException
- 不允许存在null

**新增方法**

- Comparator comparator()     //定制排序
- Object first()  //返回集合中的第一个元素
- Object last() //返回集合中的最后一个元素
- Object lower(Object e) //返回集合中位于指定元素
- Object higher(Object e) //返回集合中位于指定元素之后的元素

```java
TreeSet treeSet = new TreeSet(new Comparator<Student>() {

			@Override
			public int compare(Student o1, Student o2) {
				// TODO Auto-generated method stub
				int age1 = o1.getAge();
				int age2 = o2.getAge();
				//从大到小
				return age1>age2?-1:age1<age2? 1:0;
			}
		});
		treeSet.add(new Student("小明",12,"12312"));
		treeSet.add(new Student("小红",21,"12313"));
		System.out.println(treeSet);
```

##### 3.**List**（接口）

ArrayList类和LinkedList类

***ArrayList类***

- ArrayList对象是长度可变的对象引用数组，类似于动态数组
- 继承AbstractList并实现List接口，访问和遍历对象时候，性能强
- 随着元素添加，元素数目增加，列表自动扩展

**ArrayList构造方法：**

- ArrayList()  //创建一个空Arraylist
- ArrayList(Collection c) //根据给定集合的元素创建数组列表
- ArrayList(int size)  //使用给定大小创建一个数组列表。向数组列表添加元素，自动增加

**ArrayList类的常用方法：**

- add(Object e)  //为列表增加一个新元素
- get(int index) //得到索引为index的元素
- remove(int index) //删除索引为index的元素
- size()  //获取列表的长度

***LinkedList类***

除List接口外，LinkedList还实现了Deque接口，可以当做双端队列使用

**常用方法:**

- offer(E e) //将指定的元素添加为此列表的尾部（最后一个元素）
- push(E e)//将元素推送到由此列表表示的堆栈顶部
- offerFirst(E e) //在此列表的前面插入指定的元素

##### 4.List转换HashSet

```java
//多个list包含邮件收件人列表
		List list1 = new ArrayList();
		list1.add("张三");
		list1.add("李四");
		List list2 = new ArrayList();
		list2.add("张三");
		list2.add("李四");
		//遍历list插入
		//用set去重
//		HashSet sets = new HashSet(list1);
		HashSet set = new HashSet();
		set.addAll(list1);
		set.addAll(list2);
		System.out.println(set);
```

#### 2、泛型

- 集合大多只能存储相同类型的数据
- 定义集合的类型，减少强制转换引起的ClassCastexception异常，让程序在编译的时候检查类型是否匹配
- 基本数据类型不能作为泛型（包装类可以）

集合中泛型的使用

List<String> list = new List<String>；

```java
public class TestGeneric {
	public static void main(String[] args) {
		Generic<String> generic = new Generic<String>();
		generic.setT("泛型");
		System.out.println(generic.getT());
	}
}
class Generic<T>{
	private T t;
	public void setT(T t) {
		this.t = t;
	}
	public T getT() {
		return this.t;
	}
}
```

**Ip地址存储问题**

##### **1.Map**

![image-20220508181245630](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171046132.png)



**Map的常用方法：**

- V get(Object o) //根据key值获取对应的value
- V put(K key, V value) //将键值对插入Map集合
- void clear() //清空map
- boolean containsKey(Object key) //是否包含指定的键值
- boolean containsValue(Object value) //是否包含指定的value键值对
- Set<Map.Entry<K,V>>entrySet() //返回Set集合
- Collections<V> values() //返回Map中值的集合
- default void forEach(...) //遍历Map

```java
	HashMap<String, IPInfo> map = new HashMap();
		map.put("192.160.1.110", new IPInfo("192.160.1.110", "小红", "13814373661"));
		map.put("192.160.1.118", new IPInfo("192.160.1.118", "小明", "13814373661"));
		System.out.println(map);
		//itertor
		Set set = map.entrySet();
		Iterator iterator = set.iterator();
		while(iterator.hasNext()) {
			System.out.println(iterator.next());
		}
		System.out.println();
		//for each
		for(String str:map.keySet()) {
			System.out.println(map.get(str));
		}
```

***LinkedHashMap、TreeMap实现类***

- LinkedHashMap使用双向链表来维护key-value键值对的值，迭代顺序与key-value插入的顺序一致

  TreeMap存储key-value键值对时，根据key进行排序，也可以自定义排序

##### 2、集合使用问题

- 需要根据键值选取元素的时候选用Map接口下面的集合
  需要排序的时候选择TreeMap
  不需要排序选择HashMap
- 当只需要存放元素值时，选择实现Collection接口的集合
  保证元素唯一时选择实现set接口的实现类TreeSet/HashSet
  不需要元素唯一性选择实现List接口的实现类LinkedList/ArrayList

##### 3、集合操作类

Collections

常用方法：查看API

将集合转换为数组  toArray()

转换集合为线程安全

```java
Map m = Collections.synchronizeMap(hashMap)
```

## （九）文件、IO流

### 1、文件

File类（新建、删除、重命名文件和目录）

***构造函数：***

**File(String pathname)**

​	例如 File f1 = new File("C:\\\\temp\\\abd.txt")
​			File f2 = new File("C:/temp/abd.txt")

**File(String parent, String child)**

​			File f3 = new File(“C:\\\temp","abc.txt")

**File(File parent,String child)**

例：    File f4 = new File("C:\\\temp")

​			File f5 = new File(f4,"abc.txt") 

***常用方法***

1. 访问文件名

   ​				String getName() // 返回File对象标识的文件名或者路径名

   ​				String getPath() //返回File对象对应的路径名

   ​				File getAbsoluteFile() //返回File对象的绝对路径

   ​				String getAbsolutePath() //返回File对象所对应的绝对路径名

   ​				String getParent() //返回File对象对应的父目录名

   ​				boolean renameTo(File newName)

2. 文件检测

   ​				boolean exists() //文件或者目录是否存在

   ​				boolean canWrite() //是否可写

   ​				boolean canRead() //是否可读

   ​				boolean isFile() //是否文件

   ​				boolean isDirectory() //是否目录

   ​				boolean isAbsolute() //判断文件或者目录是否绝对路径

3. 文件信息

   ​				long lastModified()  //文件最后修改时间

   ​				long length() //文件内容长度

4. 文件操作

   ​				boolean createNewFile() //当File对象不存在，创建该文件

   ​				boolean delete() //删除文件或者路径

   ​				static File createTempFile(...) //新建一个临时的空文件，默认后缀名为.tmp

   ​				void deleteOnExit() //退出时删除File对象对应的文件和目录

5. 目录操作

   ​				boolean mkdir() //创建目录

   ​				String[] list() //返回File对象所有子文件名

   ​				File[] listFiles() //返回File对象的所有子文件和路径

   ​				static File[] listRoots() //列出系统所有的根路径

**文件过滤器**

String[] list(FilenameFilter filter)

FilenameFileter接口

boolean accept(File dir, String name)

**文件遍历**

***基本操作方式：***

- 获取文件列表
- 判断是文件夹还是文件
- 如果是文件夹则递归查询

***工具类操作方式：***

- Paths
- Files walkFileTree
- FileVisitor

```java
	public static void main(String[] args) {
		//获取文件列表
		File file = new File("D:\\software\\temp");
		if (!file.exists()) {
			System.out.println("该目录不存在");
			return;
		}
		File[] files = file.listFiles();
		//遍历文件列表，需要判断当前File对象是文件还是目录\
		getFiles(files);
		
		//使用Files工具类(simpleFileVisit)
		try {
			Files.walkFileTree(Paths.get("d:","software\\temp"), new SimpleFileVisitor<Path>() {
				@Override
				public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
					// TODO Auto-generated method stub
					System.out.println("文件"+file);
					return FileVisitResult.CONTINUE;
				}
				@Override
				public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) throws IOException {
					// TODO Auto-generated method stub
					System.out.println("目录"+dir);
					return FileVisitResult.CONTINUE;
				}
			});
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	public static void getFiles(File[] files) {
		for(File f:files) {
			if(f.isFile()) {
				System.out.println(f.getAbsolutePath());
			}else if(f.isDirectory()){
				//递归
				System.out.println(f.getName());
				File[] dFiles = f.listFiles();
				getFiles(dFiles);
			}
		}
	}
```

### 2、IO流

**流的概念**（stream）

![image-20220511150035724](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171046310.png)

根据流向：输入流和输出流

数据单位：字节流：8位  字符流：16位Unicode  Reader Writer

***常见IO流***

![image-20220511152320780](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171046676.png)

#### **1.InputStream**	

- ```java
  - int available() //返回当前可读的输入字节数
  - void close() //关闭输入流。关闭之后若再读取则会产生IOEeception异常
  - void mark(int numBytes) //在输入流的当前点放置一个标记。该流在读取N个Bytes字节前都保持有效
  - boolean markSupported()//如果调用的流支持mark()/reset()就返回true
  - int read() //如果下一个字节可读则返回一个整型，遇见文件尾时返回-1
  - int read(byte buffer[])//试图读取buffer.length个字节到buffer中，并返回实际成功读取的字节数，遇到文件尾时返回-1
  - int read(byte[] buffer, int offset, int numBytes)//试图读取buffer中从buffer[offset]开始的numBytes个字节，返回实际读取的字节数。遇到文件结尾时返回-1
  - void reset()//重新设置输入指针到先前设置的标志处
  - long skip(long numBytes)//忽略numBytes个输入字节，返回实际忽略的字节数
  ```

  

#### 2.OutputStream

- ```java
  - void close()//关闭输出流。关闭后的写操作会产生IOException异常
  - void flush()//定制输出状态以使每个缓冲器都被清除，也就是刷新缓冲区
  - void write(int b)//向输出流写入单个字节。注意参数是一个整型数，它允许设计者不必把参数转换成字节型就可以调用write()方法
  - void write(byte buffer[])//向一个输出流写一个完整的字节数组
  - void write(byte[] buffer, int offset, int numBytes)//写数组buffer以buffer[offset]为起点的numBytes个字节区域内的内容
  ```

  

#### **3.FileInputStream**

//获取文件列表
		File file = new File("D:\\software\\temp");
		if (!file.exists()) {
			System.out.println("该目录不存在");
			return;
		}
		File[] files = file.listFiles();
		//遍历文件列表，需要判断当前File对象是文件还是目录\
		getFiles(files);
		

![image-20220511164328347](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171047487.png)

#### **4.FileOutputStream**

![image-20220511171626890](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171047558.png)

#### ---------------

#### **5.Reader**

- ```java
  - abstarct void close()//关闭输入源，进一步的读取将会产生IOException异常
  - void mark(int numChars)//在输入流的当前位置设置一个标志，该输入流在numChars个字符被读取之前有效
  - boolean markSupported()//该流支持mark()/reset()则返回true
  - int read()//如果调用的输入流的下一个字符可读则返回一个整型，遇到文件尾时返回-1
  - int read(char[] buffer)//试图读取buffer中的buffer.length个字符，返回实际成功读取的字符数。遇到文件尾返回-1
  - abstract int read(char[] buffer, int offset, int numChars)//试图读取buffer中从buffer[offset]开始的numChars个字符，返回实际成功读取的字符数，遇到文件尾返回-1
  - boolean ready() //如果下一个输入请求不等待则返回true，否则返回false
  - long skip(long numChars)//跳过numChars个输入字符，返回跳过的字节设置输入指针到先前设立的标志处数
  ```

  

#### **6.Writer**

- ```java
  - abstract void close() //关闭输出流啊，关闭后会的写操作会产生IOException异常
  - abstarct void flush()//定制输出状态以使每个缓冲器都被清楚。也就是刷新输出缓冲。
  - void write(int ch)//向输出流写入单个字符。注意参数是个整型。它允许设计者不必把参数转换成字符型就可以调用write()方法
  - void write(char[] buffer)//向一个输出流写入一个完整的字符数组
  - abstract void write(char[] buffer, int offset, int numChars)//向调用的输出流写入数组buffer，以buffer[offset]为起点的N个Chars区域的内容
  - void wtrte(String str)//向调用的输出流写str
  - void write(String str, int offset,  int numChars)//写数组str中以制定的offset为起点的长度为numChars个字符区域内的内容
  ```

  

#### **7.FileReader**

FileReader(String filepath)

FileReader(File fileObj)

![image-20220511174608482](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171047843.png)

#### **8.FileWriter**

FileReader和FileWriter读写文件

读取：FileReader  读取单个字符，读取多个字符

写入：FileWriter    写入内容到文件，追加内容到文件

注意：异常处理，资源关闭

#### **9.BufferedReader**

从字符输入流读取文本，缓冲字符，以提供字符，数组和行的高效读取。可以指定缓冲区大小，或者可以使用默认大小，默认值足够大，可用于大多数用途。

**构造方法：**

BufferedReader(Reader in)

BUfferedReader(Reader in，int size)

**常用方法：**

public String readLine() throws IOException

读一行文字内容的字符串，不包括任何行终止字符\n(换行)、\r(回车符)如果已达到流的末尾，则为null

#### **10.BufferedWriter**

将文本写入字符输出流，缓冲字符，以提供单个字符，数组和字符串的高效写入。

可以指定缓冲区大小，或者可以接受默认大小。

**构造方法：**

BufferedWriter(Writer out)

BufferedWriter(Writer out，int size)

**常用方法：**

- ```java
  - void newLine()//写一行行分隔符
  - void write(int c)//写入一个字符
  - void write(char[] cbuf，int off，int len)//写入数组的一部分
  - void write(String s，int off，int len)//写入字符串的一部分
  ```

#### ---------------

#### **11.装饰模式**

**简介：**

装饰模式（Decorator）指的是在不必改变原类文件和使用继承的情况下，动态地扩展一个对象的功能。它是通过创建一个包装对象，也就是装饰来包裹真实的对象。装饰对象包含一个真实对象的引用（reference）

```java
DataInputStream/DataOutputStream

BufferedReader/BUfferedWriter
```



#### **12.InputStreamReader**

将字节流输入为字符流，注意编码问题。

例如使用FileReader读取文件时，程序将假定文件使用系统默认的编码，gbk转UTF-8乱码问题

**常见构造方法：**

InputStreamReader(IputStream in)//创建一个使用默认字符集的InputStreamReader

InputStreamReader(InputStream in，Charset cs)

​	//创建一个使用给定字符集的InputStreamReader

InputStreamReader(InputStream in，String charseName)

​	//创建一个使用命名字符集的InputStreamReader。

**常用方法：**

String getEncoding()//返回此流使用的字符编码的名称

int read()// 读取一个字符

int read(char[] cbuf,int offset, int length)//将字符读入数组的一部分呢

![image-20220511181629582](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171047853.png)

#### **13.OutputStreamWriter**

将字节流输出为字符流，注意编码问题

**常见构造方法：**

OutputStreamWriter(OutputStream out)//创建一个使用默认字符编码的OutputStreamWriter

OutputStreamWriter(OutputStream out, Charset cs)

​	//创建一个使用给定字符集的OutputStreamWriter

OutputStreamWriter(OutputStream out，String charesetName)

​	//创建一个使用命名字符集的OutputStreamWriter

**常用方法：**

String getEncoding()//返回此流使用的字符编码的名称

void write(char[] cbuf, int off ,int len)//写入字符数组的一部分

void write(int c)//写一个字符

void write(String str, int off, int len)//写一个字符串的一部分

#### 14.标准输入输出流

System类

为了支持标准输入输出设备，Java定义了两个特殊的流对象

Syteam.in和System.out

System.in 对应键盘，是InputStream类型的，程序使用System.in可以读取从键盘上输入的数据

System.out 对应显示器，是PrintStream类型的，PrintStream是OutputStream的一个子类，程序使用System.out可以将数据输出到显示器上

### 3、对象序列化

意义：完成数据的持久化，将数据写入文件或者数据库，以便其他用户访问

***对象序列化步骤***

- 实现java.io.Serializable接口，该接口未定义任何方法，用于表示该类的对象可以被实例化
- 使用ObjectOutputStream类中的writeObject方法将对象信息序列化
- 使用ObjectInputStream类中的readObject方法读取对象信息，执行反序列化，反序列化之后的数据类型与序列化数据类型一致

**例如：**

public class Student implements Serializable{}

**写对象：**

ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(File file))；

oos.writeObject(new Student);

**不需要序列化的字段怎么处理：**

![image-20220511184025740](https://tyangjian.oss-cn-shanghai.aliyuncs.com/java/202210171047039.png)

***序列化应用***

当需要多个对象进行存取时，可以先将对象封装到List或者Set对象中

例如

```java
List<Student> stus = new ArrayList<Student>();
stus.add(new Student(""));
stus.add(new Studnet(""));
oos.writeObject(stus);
//读取时候
List<Student> stus = (List<Student>)ois.readObject();
```

**对象序列化的注意点**

1、必须实现Serializable接口（没有实现的话，ObjectOutputStream写类的实例时候就会抛出java.io.NotSerializableException异常）

2、序列化的对象和反序列化对象类型需要一致

### 4、读取配置文件

##### properties

Properties具有和HashMap一样的方法，例如get，put

提供getProperty和setProperty方法，主要针对字符串进行操作

提供load()用于从文件中加载key-value键值对

**构造方法：**

Properties()//创建一个没有默认值的空属性列表

Properties(Properties defaults)//创建具有指定默认值的空属性列表

**方法：**

- public void load(InputStream inStream) throws IOException //从输入字节流 读取属性列表(键值对)
- public String getProperties(String key)//根据key获取value信息
- public String getProperties(String key, String defaultValue)//使用此属性列表中指定的键搜索属性

**实现**

```java
//创建Properties对象
Properties prop = new Properties();
prop.setProperty("host","123");
//...
String host = prop.getProperty("host");
```

**注意点：**

1、Properties文件一般使用.properties作为扩展名

2、Properties文件中注释的使用

​	name = terry

​	#这里是注释

​	pass = 123abc

3、加载完文件中的数据后，需要关闭流

##### ResourceBundle

国际化和本地化，资源文件命名规范：**自定义名称+语言代码国别代码.properties**

解析资源文件：

1、加载资源文件

2、获取资源文件中的信息

//加载资源文件

ResourceBundle res = ResourceBundle.getBundle("db");

//获取资源文件中的信息

String driverName = resource.getString("driverNmae")

支持多国语言：

复制db文件名未db_zh_CN.properties

例如：

```java
Locale locale1 = new Locale(“zh”，“CN”)

ResourceBundle res1 = ResourceBundle.getBundle("db"，locale1);

res1.getString("driverName")
```

# （十）lambda

动态传递方法体（或者函数，名称不同，含义一样），自由度更高

