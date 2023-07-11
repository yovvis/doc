前后端对比

| 前端 | 后端 |
| --- | --- |
| JavaScript
ES6、7、8 | Java8、9、10 |
| 框架/库
JQuery、Vue、React | 框架组件
SSM、Springboot、SpringCloud |
| 开发工具
WebStrom、VSCode | 开发工具
IDEA、Eclipse |
| 项目构建
WebPack | 项目构建
Maven、Gradle |
| 包管理依赖
NPM | 包依赖管理
Maven |

## 一、简单介绍

- ES是规范，JS是落地实现
- 设计初衷：让JavaScript能够编写复杂大型程序，成为企业级开发语言
## 二、let变量
先上总结：

1. let变量有严格局部作用域
2. let只能声明一次，var可以多次
3. let不存在变量提升，var存在变量提升
```javascript
{
  let a = 'yovvis'
}
console.log(a)//报错
```
```javascript

let b = 'yovv'
let b = 'cc'// 报错，不能重复
```
```javascript
console.log(c)// 报错，不能变量提升
let c = ''
```
## 三、const
先上总结：

1. 定义常量，需要赋值
2. 常量赋值后不能修改（注意，这个是不能修改已定义的常量的地址）
```javascript
const PI = 3.14
PI = 3.141// 报错
```
## 四、解构赋值
先上总结：

1. 结构赋值是赋值运算符的扩展
2. 对数组或者对象模式匹配（ps：Vue中用的比较多）
3. 主要两种方式：数组和对象
```javascript
let arr = [1,2,3]
let [a,b,c] = arr;
console.log(a)
```
```javascript
let a = {name:'yovvis',age:12}
// 必须匹配对象的属性
let {name，age} = a
let {name} = a
let {namex} = a //undefined

function({name,age}){
  // 可以直接传一个对象过来
}  
```
## 五、模板字符串
标记 ` 反引号

1. 用`反引号包裹字符串
2. 可以作为普通字符串
3. 可以定义多行字符串，原生输出换行符号
4. 可以插入变量和表达式使用${ }（常用Vue或者React的路由）
5. 字符串中调用函数
```javascript
let a = `for(int i = 0; i<5; i++{
	sout(i)
)`//直接输出换行
```
```javascript
let name = 'yovvis'
// 就近找name，就近原则
let temp - =`名字为name+${name}`
```
```javascript
const na = function(){
  return 'yovvis'
}
let name = `name为${na}`
```
## 六、简写对象（方法）

1. 传统定义
```javascript
let name = "yovvis"
let age = 12
let person = {name:name,age:age }
```

2. ES6定义（必须上方变量名和属性名一致，才可以缩写）
```javascript
let name = "yovvis"
let age = 12
let person = {name,age }
```

1. 传统对象方法
```javascript
let person ={
	name : "yovvis",
  age: 22,
  sayHello : function(){
    console.log("hello")
  }
}
person.satHello()
```

2. ES6对象写法
```javascript
let person ={
	name : "yovvis",
  age: 22,
  sayHello(){
    console.log("hello")
  }
}
person.satHello()
```
## 七、对象运算符扩展
先看对象引用
```javascript
let person = {
  name:"yovvis"
  age:22
}
let p1 = person // 改了p1 person也会变（p1指向了person）
```

1. 深拷贝
```javascript
let p1 = {...person} // 把person里面的每个属性解构出来，扒到不同的堆空间，并让p1
```

2. 合并对象[同样是深拷贝]
```javascript
let p2 = {
  do(){
    console.log("我是p2的操作")
  }
}
let person_p2 = {...person,...p2)
```
## 八、箭头函数
先上总结

- 相当于一个语法糖，提供简介函数书写方式
- 基本语法：(参数列表) =>{ 函数体 }
- 箭头函数可以0或多个参数，若只有一个参数可以省略( )
- 箭头函数函数体有多行，用{ }包裹，形成代码块
- 函数体只有一行，可以省略{}
- 箭头函数使用场景多为匿名函数的定义
### 1、基本使用

1. 传统方式
```javascript
var f1=function(n){
  return n+2;
}
let tmp = f1(2)
```

2. ES6写法（Vue中的main.js）
```javascript
// 上述f1可以改造
var f2 = (n)=>{
  return n + 2;
}
// 继续改造
var f3 = n => n + 2;
```

3. 箭头函数传给参数
```javascript
// 定义箭头函数
var fn = n => n+10;
// 传入箭头函数
function f(tmp)= {
  log(tmp(9))
}
// 相当于
function f(n=> n+10){} = function f((n)=>{
  return n+10
}){log(fn(9))}
```
### 2、实例（看懂）
```javascript
let fn = function(m,n){
  let tmp = 0
	for(int i<0;i<n;i++){
     m += i;
     tmp = m;
  }
  return tmp;
}
```
```javascript
let fn = (m,n)=>{
  let tmp = 0
	for(int i<0;i<n;i++){
     m += i;
     tmp = m;
  }
  return tmp;
}
```
### 3、箭头函数方法解构

1. 传统方法
```javascript
let person = {
	name:"yovvis",
  age:22,
  skills:["游泳","跑步"]
}
function f1(person){
  console.log("skills = ",person.skills)
}
f1(person);
```

2. ES6写法
```javascript
let person = {
	name:"yovvis",
  age:22,
  skills:["游泳","跑步"]
}

// 这里的skills必须是对象的属性
let fn = ({skills}) =>{
	console.log("skills=",skills)
}
fn(person)
```
