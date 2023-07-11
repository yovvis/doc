## 一、基本介绍
1. 传统Ajax异步操作，多个回调函数会产生Callback Hell
2. 设计解决Callback Hell问题
3. Promise是异步编程的一种解决方案
4. 语法上讲，Promise是`对象`，从它可以获取异步操作完的结果
5. Promise是ES6的新特性，部分浏览器不兼容
## 二、代码编排
Promise改进JQuery发送的Ajax
```javascript
$.ajax({
  url: 'xxxxx',
  success(result){
    log("第一次ajax请求",result),  	
    $.ajax({
    url: `xxxxx${result}`,
    success(result){
      log("第二次ajax请求",result),  	
    },
    error(err){
      log("第二次出现异常,err)
    }
    })
  },
  error(err){
    log("出现异常,err)
  }
})
```
promise发起多次请求(链式调用)
```javascript
let p = new Promise((resolve,reject)=>{
    $.ajax({
      url: 'xxxxx',
      success(result){
        log("promise第一次请求",result),
        resolve(result);
      },
      error(err){
      log("出现异常,err);
      reject(err);
      }
	})
})
p.then((result)=>{
    return new Promise((resolve,reject)=>{
      $.ajax({
    	url: `xxxxx${result}`,
    	success(result){
      	log("第二次ajax请求",result),  	
        resolve(result);
    	},
    	error(err){
      	log("第二次出现异常,err)
        reject(err);
    	}
    })
  })
}).catch((err)=>{
  //这里对多次封装的请求错误信息处理
})

```
注意点：

1. 请求成功后要将数据存放在resolve中，否则then失效
2. reject类似于catch，把错误信息封装
3. 多层请求要return给下一个调用者

promise的代码重排
```javascript
// 抽取重复new Promise的过程
function get(url,data){
	return new Promise((resolve,reject)=>{
    $.ajax({
      url:url,
      data:data,
      success(result){
        resolve(result)
      },
      error(err){
        reject(err)
      }
    })
  })
}
// 直接开始套娃
get("xxxx",_)
.then((result)=>{
  return get("xxxxxx);
})
.then((result)=>{
  return get("xxxxxx);
}).catch((err)=>{
  
})
```
