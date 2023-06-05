# Vue核心

## Vue简介

> VueApi
> 

[API 参考 | Vue.js](https://cn.vuejs.org/api/)

1、Vue是什么？一套用于***构建用户界面***的***渐进式***Js框架

***渐进式***：简单应用一个核心库解决、复杂应用引入插件

2、谁开发的？尤雨溪

3、特点

1. 采用***组件化***模式，提高代码复用率，更好维护代码
2. ***声明式***编码，无需直接操作DOM，提高开发效率
3. ***虚拟DOM*** + 优秀的***Diff算法*** 尽量复用DOM结点

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306051744996.png" alt="vue实现" style="zoom: 67%;" />

vue实现

4、学习Vue之前还需要具备的前端技术栈

1. ES6语法规范
2. ES6模块化
3. 包管理器
4. 原型、原型链
5. 数组常用方法
6. axios
7. promise

### 总结

1. 想让Vue工作就要创建一个Vue实例，要传入一个配置对象{}
2. root容器里面的代码仍然符合html规范，只不过有Vue特殊的语法
3. root容器里面的代码被成为Vue模板
4. Vue和容器是一一对应的
5. 真实开发中只有一个实例，并且会配合着***组件***一起使用
6. {{xxx}}中xxx要写js表达式，且xxx可以自动读取到Vue实例的data对象中所有属性

```jsx
const x = new Vue({
    el: '#root', //el用于指定当前Vue实例为哪个div容器服务
    data: {// 用于存储数据，数据供el指定的容器使用
        name: 'Yovvis',
				url: 'https:www.baidu.com' //要用指令语法
    }
})
```

注意区分js表达式和js代码

1. 表达式有值
2. js代码是语句，是代码片段

## 模板语法

1. 插值语法：
    1. 功能：用于解析***标签体***
    2. 写法：{{xxx}}，xxx是js表达式，且可以读取到data中的所有属性
2. 指令语法：
    1. 功能：用于解析***标签属性***（包括：标签属性，标签体内容，绑定事件）
    2. 举例：v-bind:href=’xxx’ 或者简写 :href=‘xxx’，这里的xxx也是js表达式，且可以获取到data里面所有属性
    3. 备注：Vue中很多指令都是v-???，这里v-bind是其中一个

## 数据绑定

v-bind：

1. 单向绑定，数据有data流向页面

v-model：

1. 双向绑定（必须要交互的，只能应用在表单类元素）
2. v-model默认收集的是value值，因此***v-model:value = v-model***

## el与data的写法

***el***

1. el: “#root”
2. const v = new Vue({   })  == > v.***$mount***(”#root”)         $mount在set name下面

***data***

1. 对象式  data：+json
2. 函数式  data:   function(){} this返回的是***Vue实例***  不能用data:()— >{} 箭头函数找不到this，this是***BOM对象***     

## MVVM模型

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306051743266.png" alt="MVVM模型" style="zoom:50%;" />

MVVM模型

观察发现：

1. data中所有的属性，最后都出现在vm身上
2. vm身上所有的属性及Vue原型上所有属性，在Vue模板中都是可以直接使用

## 数据代理

### defineProperty函数

```jsx
let number = 18
let person = {
	name: '张三',
	sex: '男'
}

Object.defineProperty(person,'age',{
	value: 18，
	ennumberable: true, // 控制属性是否可以被枚举，默认值是false
	writable: true,     // 控制属性是否可以被修改，默认值是false
	configurable: true  // 控制属性是否可以被删除，默认值是false

	// 当有人读取person的age属性时，get函数（getter）就会被调用，返回就是age值
	get(){
		console.log("有人读取age属性了");
		return number
	},

	// 当有人修改person的age属性时，set函数（setter）就会被调用，且会收到修改值
	set(value){
		console.log('有人读取age属性了');
		number = value
	}

})
```

### 数据代理：

通过一个对象代理对另一个对象中属性的操作（读 / 写）

```jsx
let obj1 = {x:100}（data）
let obj2 = {y:200}（vm）
Object.defineProperty(obj2,'x',{
	// 当有人读取person的age属性时，get函数（getter）就会被调用，返回就是age值
	get(){
		console.log("有人读取age属性了");
		return obj1.x
	},

	// 当有人修改person的age属性时，set函数（setter）就会被调用，且会收到修改值
	set(value){
		console.log('有人读取age属性了');
		obj1.x = value
	}

})
```

### vue数据代理

上面的obj2就是vm，obj1就是data，***vm会给vm原型链自己加上***_data***的属性***

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306051743443.png" alt="Untitled" style="zoom:50%;" />

这里vm._data === [options.data](http://options.data) === data

_data里面做了***数据劫持***

1. Vue中的数据代理：
   
    通过vm对象来代理data对象中属性的操作
    
2. Vue中数据代理的好处：
   
    更方便的操作data中的数据
    
3. 基本原理：
   
    通过Object.defineProperty()把data对象中所有属性添加到vm上，且指定一个getter和setter，用getter和setter操作data中的属性
    

## 事件处理

```jsx
<button v-on:click="showInfo">欢迎来到yovvis(不传参)</button>
<button v-on:click="showInfo(66,***$event***)">欢迎来到yovvis（传参）</button>
const x = new Vue({
    el: '#root', //el用于指定当前Vue实例为哪个div容器服务
    data: {// 用于存储数据，数据供el指定的容器使用
        name: 'Yovvis',
				url: 'https:www.baidu.com' //要用指令语法
    },
		method: {
				showInfo(event){
						// event就是<button></button>
						console.log(this);// this就是vm
						alert(event);
				},
				showInfo2(num,event){
					// event就是<button></button>
					console.log(this);// this就是vm
					alert(event);
				}
		}
})
```

事件基本使用：

1. 使用v-on:xxx或@xxx绑定事件,其中xxx是事件名
2. 事件的回调需要配置在methods对象中，最终会在vm上;
3. methods中配置的函数，不要用箭头函数!否则this就不是vm了;
4. 4.methods中配置的函数，都是被Vue所管理的函数，this的指向是vm或组件实例对象;
5. @click="demo”和@click=""demo($event)”效果一致，但后者可以传参;

### 事件修饰符

vue中的事件修饰符:

1. prevent:阻止默认事件（常用）;
2. stop:阻止事件冒泡（常用）
3. once:事件只触发一次（常用);
4. capture:使用事件的捕获模式;
5. self:只有event.target是当前操作的元素是才触发事件;
6. passive:事件的默认行为立即执行，无需等待事件回调执行完毕;

div（外）——>div（内）***捕获*** ——内——>外冒泡

@wheel可以一直滚；@scroll不可以

他们的逻辑是   滚动——执行事件——条下移，但是加上passive就立刻滚动了

***修饰符可以连续写***

### 键盘事件

@keyup.enter=”method”

特殊的@keyup.caps-lock=”method”（分割）

1. Vue中常用别名
   
    回车 enter
    
    删除 delete
    
    退出 esc
    
    空格 space
    
    换行 tab （keydown）
    
    上下左右 up down left right
    
2. Vue未提供别名的按键，可以使用按健原始的key值去绑定，但注意要转为kebab-case(短横线命名)
3. 系统修饰键（用法特殊）:ctr1、alt、shift、meta
   (1).配合keyup使用:按下修饰键的同时，再按下其他键，随后释放其他键，事件才被触发。
   
    (2).配合keydown使用:正常触发事件。
   
4. 也可以使用keyCode去指定具体的按键（不推荐)
5. Vue.config.keyCodes.自定义健名=键码,可以去定制按键别名

***键盘可以连写***

## 计算属性

在Vue中data里面是属性，通过data里面属性操作后生成的属性

```jsx
computed:{
	fullName: {
		// 初次读取fullName时候，所依赖的数据变化时会加载，不然就读取缓存里的值
		get(){
			return this.firstName + "-" + this.lastName;
		},
		set(value){
			this.firstName = value.split("-")[0];
			this.lastName = value.split("-")[1];
		}
	}
}
```

_data中是不会有计算属性的

这里是拿到getter的返回值放到vm身上

1. 定义：要用的属性不存在，要通过已有的属性计算得来
2. 原理：底层还是借助[Object.defineproperty]方法提供的getter和setter
3. getter函数什么时候执行
    1. 初次读取会执行，并放入缓存
    2. 依赖的数据发生改变时会再次调用
4. 优势：与method机制，内部有缓存机制，效率更高，调试方便
5. 备注：
    1. 计算属性最后会挂载在vm上，直接读取调用
    2. 如果计算属性要被修改，必须改setter，且要在setter修改依赖的属性

***简写***

只考虑读取不考虑修改

```jsx
computed:{
	fullName: function(){
			return this.firstName + "-" + this.lastName;
	}
}
computed:{
	fullName(){
			return this.firstName + "-" + this.lastName;
	}
}

```

***注意：***@click=“isHot ? ‘炎热’：’凉爽’”，事件中可以直接写返回语句，但是一定是定义在data里面的属性