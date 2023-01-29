# 常用方法合集

## cmd

查询端口号

```shell
netstat -on
```

目录操作

~~~shell
cd D:
cd ../xxx/xxx
cd ./
~~~

清空命令行

~~~shell
cls
~~~

查看ip

~~~shell
ipconfig
~~~

查询ip地址

~~~c
ping www.baidu.com
~~~

查看网络连接状态

~~~shell
//获取命令行使用帮助
netstat -help
//查看网络连接、状态以及对应的进程id
netstat -ano 
~~~

终止命令

~~~shell
ctrl + c
~~~

退出cmd

~~~shell
exit
~~~

查看用户

~~~shell
net user
~~~



## Linux

```shell
--切换目录
cd /
--
ll
```



## Node.js

~~~shell
npm install
~~~

## Git

~~~shell
//拉代码
git clone -b main http://192.168.0.200/product-group/.git
~~~

## java

### 1、内部类实现list内部排序

~~~java
//匿名内部类实现list内部排序
//对象中的数值类型排序
public class sort {
　　public static void main(String[] args) {
　　List<User> list = new ArrayList<Record>();
　　list.add(rec1));
　　list.add(rec2);
　　list.add(rec3);
　　list.add(rec4); 
　　Collections.sort(list, new Comparator<Record>() {
　　　　@Override
　　　　public int compare(Record r1, Record r2) {
　　　　　　int diff = u1.getAge() - u2.getAge();
　　　　　　if (diff > 0) {
　　　　　　　　return 1;
　　　　　　}else if (diff < 0) {
　　　　　　　　return -1;
　　　　　　}
　　　　　　return 0; //相等为0
　　　　}
　　}); 
　　System.out.println(list.toString());
　　}
}
//对象中的String类型排序
public class sort {
　　public static void main(String[] args) {
　　List<User> list = new ArrayList<Record>();
　　list.add(rec1);
　　list.add(rec2);
　　list.add(rec3);
　　list.add(rec4); 
　　Collections.sort(list, new Comparator<User>() {
　　　　@Override
　　　　public int compare(User u1, User u2) {
　　　　　　return u1.getName().compareTo(u2.getName());
　　　　}
　　}); 
　　System.out.println(list.toString());
　　}
}
~~~

### 2、精度问题

~~~java
BigDecimal bbDecimal = new BigDecimal(111);
BigDecimal totalDecimal = new BigDecimal(1111);
BigDecimal bl = bbDecimal.divide(totalDecimal, 3, RoundingMode.HALF_UP);
bl.multiply(new BigDecimal(100)).setScale(1);
~~~

### 3、jdk8新特性

~~~java
//lambda表达式
List<Integer> numbers = Arrays.asList(3, 2, 2, 3, 7, 3, 5);
List<Integer> squaresList = numbers.stream().map( i -> i*i).distinct().collect(Collectors.toList());
//stream流
List<FrameRole> roleList = roleService.listRoleByUserGuid(userSession.getUserGuid());
roleNameList = roleList.stream().map(FrameRole::getRoleName).collect(Collectors.toList());
~~~



## sql

### 1、计算年龄

~~~sql
--计算周岁的方法
select TIMESTAMPDIFF(YEAR, '1980-10-2', CURDATE()) as age

--粗略计算年龄
select year(now())-year('1967-10-13') as age
~~~

### 2、Id递增

~~~sql
select ifnull(min(order),999) from a where 1=1;
~~~

3、视图

~~~sql
create or replace view view_talent_apply as
select '论文' as tc,rowguid,username,flowstatus,createdate, d.ouname from (select rowguid,username,flowstatus,createdate,b.ouguid from zysy_specialty_paper a left join frame_user b on a.userguid =b.userguid)c left join frame_ou d on c.ouguid= d.ouguid
union all
select '论著' as tc,rowguid,username,flowstatus,createdate, d.ouname from (select rowguid,username,flowstatus,createdate,b.ouguid from zysy_specialty_treatise a left join frame_user b on a.userguid =b.userguid)c left join frame_ou d on c.ouguid= d.ouguid
union all 
select '带教' as tc,rowguid,username,flowstatus,createdate, d.ouname from (select rowguid,username,flowstatus,createdate,b.ouguid from zysy_specialty_teach a left join frame_user b on a.userguid =b.userguid)c left join frame_ou d on c.ouguid= d.ouguid
union all 
select '心理咨询' as tc,rowguid,username,flowstatus,createdate, d.ouname from (select rowguid,username,flowstatus,createdate,b.ouguid from zysy_specialty_xlzx a left join frame_user b on a.userguid =b.userguid)c left join frame_ou d on c.ouguid= d.ouguid
union all 
select '比武获奖' as tc,rowguid,username,flowstatus,createdate, d.ouname from (select rowguid,username,flowstatus,createdate,b.ouguid from zysy_specialty_competition a left join frame_user b on a.userguid =b.userguid)c left join frame_ou d on c.ouguid= d.ouguid
union all 
select '职业特长' as tc,rowguid,username,flowstatus,createdate, d.ouname from (select rowguid,username,flowstatus,createdate,b.ouguid from zysy_specialty_occupation a left join frame_user b on a.userguid =b.userguid)c left join frame_ou d on c.ouguid= d.ouguid
union all 
select '政府津贴' as tc,rowguid,username,flowstatus,createdate,ouname from zysy_government_allowance_apply
union all 
select '专业技术职称' as tc,rowguid,username,flowstatus,createdate,ouname from zysy_professional_title_apply;
~~~

 

## 前端

### 1、时间校验

~~~js
//时间校验
//html:onvalidation="onAfterTodayDate"
var onAfterTodayDate = function(e) {
	if (e.isValid) {
		var currentDate = new Date(e.value);
		var now = new Date();
		if (currentDate <= now) {
			e.isValid = false;
			e.errorText = "必须设置晚于当前时间的时间";
		}
	}
}
//精确时间yyyy-MM-dd HH:mm:ss
<input id="createtime" class="mini-datepicker" nullValue="null" format="yyyy-MM-dd HH:mm:ss" timeFormat="H:mm:ss" showTime="true" showOkButton="true" showClearButton="false" bind="dataBean.createtime" />
    
//提示确认
epoint.comfirm("确认要下载吗？","提示",function(){
    //确认后的回调
	epoint.execute("exeValiad", null, 参数, function(data) {
			epoint.alert(data.msg);
			eputil.searchDataFirst();
	})				
});
~~~

### 2、遍历复杂json

~~~js
//data={"depart":[],"provincial":[],"city":{"score":30,"unit":xxx,"rc":xxx,"name":xxx,"guid":xxx}}
for (var tmp in data) {
     // console.log(data[tmp]);
    for (var i = 0; i < data[tmp].length; i++) {
    	var userguid = data[tmp][i]["guid"];
        data[tmp][i].img = _rootPath + "rest/zysyphotoserver/getuserimg?userGuid=" + userguid;
     }
 }
~~~

### 3、处理身份证号码

~~~js
function getAgeByIdCard(idcard) {
			//获取出生年月日
			var yearBirth = idcard.substring(6, 10);
			var monthBirth = idcard.substring(10, 12);
			var dayBirth = idcard.substring(12, 14);
			//获取当前年月日并计算年龄
			var myDate = new Date();
			var monthNow = myDate.getMonth() + 1;
			var dayNow = myDate.getDay();
			var age = myDate.getFullYear() - yearBirth;
			if (monthNow < monthBirth || (monthNow == monthBirth && dayNow < dayBirth)) {
				age--;
			}
			return age;
		}
		//根据证件号计算出生日期
		function getBirthdateByIdCard(idcard) {
			if (eputil.idCardValidate(idcard) == '') {
				birthday = idcard.substring(6, 10) + "-" + idcard.substring(10, 12) + "-" + idcard.substring(12, 14);
			}
			return birthday;
		}

		// 读取身份证中性别值
		function getSexByIdCard(idcard) {
			// 获取性别
			if (parseInt(idcard.substr(16, 1)) % 2 == 1) {
				// 男
				return "1";
			} else {
				// 女
				return "2";
			}
		}
~~~


