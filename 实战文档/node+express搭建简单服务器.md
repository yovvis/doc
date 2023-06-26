> **环境**
>
> 1.nodejs v16.14.2

## 一、创建文件夹

`node_server`

## 二、合法化包

~~~bash
npm init
~~~

1. 随便起服务名，别花里胡哨的

	<img src="https://yovvis.oss-cn-shanghai.aliyuncs.com/any/202306261848776.png" alt="image-20230626190359861" style="zoom:80%;" />

2. 一路回车

## 三、安装express

~~~bash
npm i express
~~~

<img src="https://yovvis.oss-cn-shanghai.aliyuncs.com/any/202306261853712.png" alt="image-20230626190359861" style="zoom:80%;" />

成功安装

## 四、server.js

1、简单模拟后端请求

~~~js
// 引入express（commonjs语法）
const express = require('express')
//const history = require('connect-history-api-fallback')

// 创建app服务实例对象
const app = express()
//app.use(history())
//app.use(express.static(__dirname + '/static'))
//demo后端路由
app.get('/person', (req, res) => {
    // 函数体
    res.send({
        name: 'yovvis',
        age: 22
    })
})

// 创建端口监听
app.listen(5009, (err) => {
    if (!err) console.log("服务器启动成功!");

})
~~~

2、启动服务

~~~bash
node server
~~~

<img src="https://yovvis.oss-cn-shanghai.aliyuncs.com/any/202306261903891.png" alt="image-20230626190359861" style="zoom:80%;" />

3、浏览器访问

<img src="https://yovvis.oss-cn-shanghai.aliyuncs.com/any/202306261905836.png" alt="image-20230626190359861" style="zoom:80%;" />

## 五、静态页面部署

1、需要指定静态资源路径（见上面代码）

```js
app.use(express.static(__dirname + '/static'))
```

2、两种路由模式下

- hash模式不用特别在意

- history模式下注意：每次刷新会向后端请求资源，但是SPA应用时候需要通过`中间件{connect-history-api-fallback}`解决

~~~bash
npm i connect-history-api-fallback
~~~

***ps：***一定要在配置静态资源目录前使用