# 常用方法合集

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

### 4、map的部分值进行去重

~~~java
 list.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(()->new TreeSet<>(new Comparator<Map<String,Object>() {
    @Override
    public int compare(Map<String, Object> o1, Map<String, Object> o2) {
        if (o1.get("nodestep").equals(o2.get("nodestep"))&& o1.get("nodename").equals(o2.get("nodename"))){
            return 0;
        }
        return 1;
    }
}))));
~~~

### 5、string[] 转list 去重去空

~~~
List<String> ouCodeList = Arrays.asList(ouCodeStr).stream().filter(s -> s.trim().length() != 0).collect(Collectors.toList());
~~~

### 6、List<map“>取key值

~~~java
List<String> userGuidList = feedbackData.stream().map(m -> (String) m.get("userguid")).collect(Collectors.toList());
~~~

### 7、List<String>去重

~~~java
List<String> List = list.stream().distinct().collect(Collectors.toList());
~~~

### 8、多线程

~~~java
// job
@JobHandler
public class SxJxScoreResultJob implements Job
{
    private static Logger logger = Logger.getLogger(SxUpdateA01OuJob.class);

    Date now = new Date();

    // 10个线程
    private static final int THREADNUMS = 10;

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        ZgJxScoreResultService scoreResultService = ContainerFactory.getContainInfo().getComponent(ZgJxScoreResultService.class);
        ExecutorService fixedThreadPool = Executors.newFixedThreadPool(THREADNUMS);
        try {

            logger.info("----------获取教训结果开始执行----------");
            // 获取当前年度的所有参与考核的用户数据
            SxSqlCondition condition = new SxSqlCondition();
            condition.custom("examdate_year", " and year(examdate) = ? ", EpointDateUtil.getYearOfDate(now));
            // 人员数
            int count = scoreResultService.getAllUserNumber(condition);

            // 循环次数
            int loopNum = THREADNUMS;

            // 单个线程处理数据量
            int pageSize = count / THREADNUMS + 1;

            if (count <= THREADNUMS) {
                pageSize = count;
                loopNum = 1;
            }
            for (int i = 0; i < loopNum; i++) {
                fixedThreadPool.execute(new SxJxScoreResultThread(i * pageSize, pageSize));
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            logger.error("信息更新失败", e);
        }
        finally {
            fixedThreadPool.shutdown();
        }
    }
}
//-----------------------------------------------------------------------------------------------------------------------------------------------
// thread
public class SxJxScoreResultThread extends Thread
{

    private static final Logger logger = LoggerFactory.getLogger(Advice.This.class);

    ZgJxScoreResultService scoreResultService = ContainerFactory.getContainInfo().getComponent(ZgJxScoreResultService.class);

    // 开始处
    private int startNum = 0;

    // 处理数据量
    private int handleCount = 0;

    private final String year = String.valueOf(EpointDateUtil.getYearOfDate(new Date()));

    public SxJxScoreResultThread(int startNum, int handleCount) {
        this.startNum = startNum;
        this.handleCount = handleCount;
    }

    @Override
    public void run() {
        EpointFrameDsManager.begin(null);
        String pageSize = "500";
        int pageSizeNum = StringUtil.isBlank(pageSize) ? 1000 : Integer.parseInt(pageSize);

        // 分页页数1w,1000,10次
        int pageNo = handleCount % pageSizeNum == 0 ? handleCount / pageSizeNum : handleCount / pageSizeNum + 1;

        int endNum = 0;
        logger.info("-------------------startNum----------------------" + startNum);
        logger.info("------------------handleCount--------------------" + handleCount);
        logger.info("------------------pageSizeNum--------------------" + pageSizeNum);
        logger.info("---------------------pageNo----------------------" + pageNo);
        logger.info("----------------------year-----------------------" + year);
        try {
            SxSqlCondition condition = new SxSqlCondition();
            condition.custom("examdate_year", " and year(examdate) = ?", year);
            condition.in("pdlevel", new String[] {"10", "20", "30" });
            for (int j = 0; j < pageNo; j++) {
                // 最后一页
                endNum = j == pageNo - 1 ? startNum + handleCount : startNum + (j + 1) * pageSizeNum;

                logger.info("----------开始分页查询教训数据----------");
                List<ZgJxScore> userScoreList = scoreResultService.getAllUserDataList(startNum + j * pageSizeNum, endNum - (startNum + j * pageSizeNum), "", "", condition);
                if (EpointCollectionUtils.isEmpty(userScoreList)) {
                    return;
                }
                for (ZgJxScore jxScore : userScoreList) {
                    // 判断是否已经有过某个科目的成绩有则修改，无则新增
                    ZgJxScoreResult result = scoreResultService.findScoreResult(year, jxScore.getUserguid(), jxScore.getExamcourse());
                    if (result != null) {
                        // 修改
                        String resultStr = getResult(year, jxScore.getUserguid(), jxScore.getExamcourse());
                        result.setResulttype(StringUtil.isNotBlank(resultStr) ? resultStr : "404");
                        // 计算是否合格
                        scoreResultService.updateZgJxScoreResult(result, new GaOperateInfo());
                    }
                    else {
                        // 新增
                        ZgJxScoreResult scoreResult = new ZgJxScoreResult();
                        scoreResult.setRowguid(UUID.randomUUID().toString());
                        scoreResult.setUserguid(jxScore.getUserguid());
                        scoreResult.setUsername(jxScore.getUsername());
                        scoreResult.setAge(jxScore.getAge());
                        scoreResult.setExamcourse(jxScore.getExamcourse());
                        scoreResult.setPolicenum(jxScore.getPolicenum());
                        scoreResult.setPolicedate(jxScore.getPolicedate());
                        scoreResult.setExamtype(jxScore.getExamtype());
                        scoreResult.setOucode(jxScore.getOucode());
                        scoreResult.setOuname(jxScore.getOuname());
                        scoreResult.setYear(year);
                        String resultStr = getResult(year, jxScore.getUserguid(), jxScore.getExamcourse());
                        scoreResult.setResulttype(StringUtil.isNotBlank(resultStr) ? resultStr : "404");
                        // 计算结果
                        getResult(year, jxScore.getUserguid(), jxScore.getExamcourse());
                        scoreResultService.insertZgJxScoreResult(scoreResult, new GaOperateInfo());
                    }
                }

            }
            EpointFrameDsManager.commit();
        }
        catch (Exception e) {
            EpointFrameDsManager.rollback();
            e.printStackTrace();

        }
        finally {
            EpointFrameDsManager.close();
        }
    }

    /**
     * 计算结果
     *
     * @param userGuid
     * @return String
     **/
    private String getResult(String year, String userGuid, String examCourse) {
        SxSqlCondition condition = new SxSqlCondition();
        condition.exact("userguid", userGuid);
        condition.custom("examdate_year", " and year(examdate) = ?", year);
        condition.exact("examcourse", examCourse);

        Record rec = scoreResultService.getWhichLevel(condition);
        if (rec.getInt("province") > 0) {
            // 按照省级来获取最新的达标情况
            condition.exact("pdlevel", "10");
            List<String> resultStr = scoreResultService.getCourseResult(condition);
            if (EpointCollectionUtils.isNotEmpty(resultStr)) {
                return resultStr.get(0);
            }

        }
        else if (rec.getInt("city") > 0) {
            condition.exact("pdlevel", "20");
            List<String> resultStr = scoreResultService.getCourseResult(condition);
            if (EpointCollectionUtils.isNotEmpty(resultStr)) {
                return resultStr.get(0);
            }
        }
        else if (rec.getInt("xj") > 0) {
            condition.exact("pdlevel", "30");
            List<String> resultStr = scoreResultService.getCourseResult(condition);
            if (EpointCollectionUtils.isNotEmpty(resultStr)) {
                return resultStr.get(0);
            }
        }
        return "";
    }
}

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

### 3、视图

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

###  4、一对多拼接

~~~sql
select a.*, ifnull(group_concat(b.username,'(',b.shortnumber,')' separator '、'),'') as userandnum from zg_bzjl_contact a left join zg_bzjl_contact_user b on a.Rowguid = b.contactguid where oucode ='330600'  group by a.Rowguid 
~~~

### 5、行专列

~~~sql
select a.rowguid as userguid ,a.username ,a.seclevel ,a.departmentid as ouguid ,a.departmentname as ouname ,b.quater,
sum(case b.quater when '1' then b.totalscore else null end) as onequaterscore ,
sum(case b.quater when '2' then b.totalscore else null end) as twoquaterscore ,
sum(case b.quater when '3' then b.totalscore else null end) as threequaterscore ,
sum(case b.quater when '4' then b.totalscore else null end) as fourquaterscore 
from ga_sx_user a left join sx_jxkh_quater_score b on a.RowGuid = b.userguid where userguid = '472.0' and b.year='2023' group by a.RowGuid 
~~~

### 6、case when应用

~~~sql
-- 根据某个字段累加
select oucode,ouname as name,examcourse,ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,
ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj 
from ZG_JX_SCORE where oucode="330605" and examcourse in("101","102","201") 
and year(examdate) = '2023' group by oucode,examcourse

-- 处理含有年龄的字段数据
select Oucode,examcourse,Policenum ,
case when (year(from_days( datediff(now(), a.A0113)))+1)<=3 then '3(含)年内' when (year(from_days( datediff(now(), a.A0113)))+1)>3 and (year(from_days( datediff(now(), a.A0113)))+1)<=10 then '3-10(含)年' 
when (year(from_days( datediff(now(), a.A0113)))+1)>10 and (year(from_days( datediff(now(), a.A0113)))+1)<=20 then '10-20(含)年' else '20年以上' end as jl,ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj 
from ZG_JX_SCORE z right join a01 a on z.Policenum = a.A0117
where examcourse in("101","102") and examdate > "2022-09-01" and examdate < "2022-09-22"  
group by jl,examcourse

-- case when 和 union all转换
select name,value from 
(select '一巡' as name ,count(1) value from mx_zzgl_rybase where Zj ='0101'
union all 
select '二巡' as name ,count(1) value from mx_zzgl_rybase where Zj ='0102'
union all 
select '一高' as name ,count(1) value from mx_zzgl_rybase where Zj ='0203' 
union all 
select '二高' as name ,count(1) value from mx_zzgl_rybase where Zj ='0204'
union all 
select '三高' as name ,count(1) value from mx_zzgl_rybase where Zj ='0205'
union all 
select '四高' as name ,count(1) value from mx_zzgl_rybase where Zj ='0206') a

select case zj when '0101' then '一巡' when '0102' then '二巡' when '0203' then '一高' when '0204' then '二高' when '0205' then '三高' when '0206' then '四高' end  
as name, count(1) value 
from mx_zzgl_rybase where zj in ('0101','0102','0203','0204','0205','0206') 
group by zj order by zj asc
~~~

### 7、脱敏

~~~sql
-- 姓名
update userinfo SET username = rpad(substring(username, 1, 1 ), char_length(username), '*' ) where 1=1
-- 电话
update userinfo SET username = CONCAT(LEFT (username, 3 ), '****' ,RIGHT(username,4)) where 1=1
-- 单位
update ouinfo SET ouname = REPLACE (ouname, SUBSTRING(ouname,1,2),'**' ) WHERE ouname regexp '市'

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



## cmd

查询端口号

```shell
netstat -on

netstat -ano |findstr "端口号"

tasklist |findstr "进程id号"

taskkill -PID 5656 -F
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

### 1.说明

重启           shutdown -r now

编辑           vim 进去要i

退出是esc    :wq   wq不了就先:q！   :/是查找

登录管理员   su root

查看ip    ip addr show

想要回到[root@localhost ~]  就直接cd ~用户

三分组 user group other

权限 r w x

压缩 rpm bin yum

### 2.命令

```shell
--切换目录
cd /
--
ll
```

修改dphc

```
vi /etc/sysconfig/network-scripts/ifcfg -e +tap
```

重启网络

```
service network restart 172.16.176.143
```

防火墙

```
systemctl start firewalld 开启防火墙
systemctl status firewalld 防火墙状态
systemctl stop firewalld.service#停止firewall
systemctl disable firewalld.service#禁止firewall开机启动
```

ssh服务

```
systemctl start sshd.service  #启动ssh服务
systemctl stop sshd.service  #关闭ssh服务
systemctl restart sshd.service  #重启ssh服务
systemctl enable sshd.service  #开机自启动ssh服务

ssh连接后可以在ip1下面连接ip2然后exit退出
```

文件夹操作

```
mkdir  xxx  创建文件夹
rm -rf xxx  删除文件夹和下面的信息
mv x ./xx   移动文件夹
cp -R x xx  递归拷贝文件夹

cd xxx/		切换路径
pwd			完整路径	
cd ../ 		上层
cd /   		根目录
ls    		目录下信息
ls -l 		目录详细内容
cd ~		用户所在的文件夹
./xxx		执行某个文件

vi xxx.txt 如果没有就是创建
```

授权

```
chown nobody:nobody	xxx.txt	  		完全公开
chown -R  nobody:nobody test  		完全公开文件夹和他递归的文件

-r可读-w可写-x可执行 用二进制表示的
user group other 三组
chmod 777 bbb 						授权文件
chmod -R 777 test					授权文件夹
```

安装软件

```shell
tar -xvf xxx.tar.gz		解压缩文件
rpm -ivh xxx.rpm		安装单个
rpm -ivh *.rpm force	安装全部
./xxxxx.bin  			安装bin包	

yum install docker
yum install nginx
```

性能

~~~shell
cat /proc/cpuinfo   	cpu性能
top						cpu使用率 yum install epel-release   yum install htop
df -h 					磁盘空间
iftop					网络      yum install iftop
ifconfig				ip        yum install net-tools
ps -ef |grep xxx 		查看所有进程/某个进程
>>重定向符号
ps -ef >>a.txt			进程信息放到txt中
cat a.txt               仅仅查看
~~~



## Node.js

~~~shell
npm install
~~~

## Git

~~~shell
//拉代码
git clone -b main http://192.168.0.200/product-group/.git
~~~

~~~shell
//idea中初始化项目
git init
git add .
git commit -m "first"
git remote add origin xxxxx
git push -u origin "xxx"
~~~
