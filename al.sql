-- 6.3.2.1预警总数
select sum(score) from ga_warn_data  where Oucode like '3306%';
select sum(score) from zg_jx_score where 1=1 and oucode like '3306%'
-- 单位通过率
select count(1) from ZG_JX_SCORE where resulttype = '1' and oucode like '330604%'
select count(1) from ZG_JX_SCORE where resulttype = '3' and oucode like '330604%'
select count(1) from ZG_JX_SCORE where oucode like '330604%'
	
select oucode,examcourse,ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,
ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj from ZG_JX_SCORE where oucode = "33060401" and 
Examcourse in("101","102") group by oucode,examcourse ;

-- 对比分析
select oucode,ouname as name,examcourse,ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,
ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj 
from ZG_JX_SCORE where oucode="330605" and examcourse in("101","102","201") 
and examdate > "2022-08-01" and examdate < "2022-09-31"
group by oucode,examcourse

select oucode,examcourse,ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,
ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj from ZG_JX_SCORE 
where oucode like "3306%" and examcourse in("102","101","301") and examdate> "2022-08-01" and examdate < "2022-09-06"
group by examcourse;

select examname ,sum(score) from ZG_JX_SCORE where oucode="330607" and examcourse in("101","102") 
and examdate > "2022-08-01" and examdate < "2022-09-22" group by oucode,examcourse

select ouname as name,sum(score) ,examcourse from ZG_JX_SCORE where 
oucode=? and examcourse in(?,?) and examdate > "2022-08-01" and examdate < "2022-09-22"
group by oucode,examcourse


select sum(score) from ZG_JX_SCORE where Examcourse in("101","102","203")

-- 子单位名称和oucode
select ouname as text, oucode as value from frame_ou where oucode like "3306%" and length(oucode)=6

-- 科目概况
select Oucode,ouname as name,examcourse,
ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,
ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj 
from ZG_JX_SCORE where oucode like "3306%" and examcourse in("101","102") and examdate > "2022-08-01" and examdate < "2022-09-22"
group by examcourse

-- 单位概况
select oucode,ouname as name,examcourse,ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,
ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj from ZG_JX_SCORE  where 1=1 and examdate < ? and oucode like ? 
and examcourse in (?,? )  and examdate > ? group by examcourse

select oucode, ouname, examcourse ,
ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,
ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj 
from ZG_JX_SCORE where oucode like "3306%" and examdate > "2022-08-01" and examdate < "2022-08-31"
group by Examcourse 

select Ouname, length(Oucode) from frame_ou where length(Oucode)=8 and Oucode like "330604%"
-- 趋势图
select year(examdate) as year, month(examdate) as month,oucode, examcourse, ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,
ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj 
from ZG_JX_SCORE where oucode like "3306%"
group by month;
-- 警龄情况
select Oucode,examcourse,Policenum ,
case when (year(from_days( datediff(now(), a.A0113)))+1)<=3 then '3(含)年内' when (year(from_days( datediff(now(), a.A0113)))+1)>3 and (year(from_days( datediff(now(), a.A0113)))+1)<=10 then '3-10(含)年' 
when (year(from_days( datediff(now(), a.A0113)))+1)>10 and (year(from_days( datediff(now(), a.A0113)))+1)<=20 then '10-20(含)年' else '20年以上' end as jl,
ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj 
from ZG_JX_SCORE z right join a01 a on z.Policenum = a.A0117
where examcourse in("101","102") and examdate > "2022-09-01" and examdate < "2022-09-22"  
group by jl,examcourse

select Oucode,examcourse,Policenum,case when year(now())-year(a.A0113)<=3 then '3(含)年内' 
when year(now())-year(a.A0113)>3 and year(now())-year(a.A0113)<=10 
then '3-10(含)年' when year(now())-year(a.A0113)>10 and year(now())-year(a.A0113)<=20 
then '10-20(含)年' else '20年以上' end as jl,ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,
ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj from ZG_JX_SCORE z right join a01 a on z.Policenum = a.A0117 
where examdate <"2022-09-11"  and examcourse in("101","102") and examdate > "2022-09-01"
group by jl,examcourse

select Oucode,examcourse,Policenum,case when (year(from_days(datediff(now(), a.A0113))))<=2
then '3(含)年内' when (year(from_days(datediff(now(), a.A0113))))>2 and (year(from_days(datediff(now(), a.A0113))))<=9 
then '3-10(含)年' when (year(from_days(datediff(now(), a.A0113))))>9 and (year(from_days(datediff(now(), a.A0113))))<=19
then '10-20(含)年' else '20年以上' end as jl,ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,
ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj from ZG_JX_SCORE z inner join a01 a on z.Policenum = a.A0117  group by jl,examcourse
where 1=1 and z.Policenum is not null and examdate < "2022-09-11" and examcourse in ("101","102")  and examdate > "2022-09-01" 

select Oucode,examcourse,Policenum,case when timestampdiff(YEAR, CONCAT( a.A0113), now())),1)<=3 
then '3(含)年内' when (year(from_days( timestampdiff(now()),CONCAT( a.A0113))),1)>3 
and (year(from_days( timestampdiff(now()),CONCAT( a.A0113))),1)<=10 then '3-10(含)年' 
when (year(from_days( timestampdiff(now()),CONCAT( a.A0113))),1)>10 and (year(from_days( timestampdiff(now()),CONCAT( a.A0113))),1)<=20 
then '10-20(含)年' else '20年以上' end ) as jl,ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,
ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj from ZG_JX_SCORE z right join a01 a on z.Policenum = a.A0117  

--新警
select Oucode,examcourse,(year(from_days( datediff(now(), a.A0113)))+1) as gl,Policenum ,
case when (year(from_days( datediff(now(), a.A0113)))+1)=1 then "第一年" when (year(from_days( datediff(now(), a.A0113)))+1)=2 then "第二年" 
when (year(from_days( datediff(now(), a.A0113)))+1)=3 then "第三年" else "20年以上" end as gl,
ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj 
from ZG_JX_SCORE z right join a01 a on z.Policenum = a.A0117
where oucode like "330607%" and examcourse in("101","102") and examdate > "2022-08-01" and examdate < "2022-09-22"  
group by gl,examcourse

select Oucode,examcourse,Policenum,
case when (year(from_days(datediff(now(), a.A0113))))=0 then '第一年' 
when (year(from_days(datediff(now(), a.A0113))))=1 then '第二年' when (year(from_days(datediff(now(), a.A0113))))=2
then '第三年' end as jl,ifnull(count(1),0) as total,ifnull(sum(case when resulttype=1 then 1 else 0 end),0) as db,ifnull(sum(case when resulttype=3 then 1 else 0 end),0) as wcj 
from ZG_JX_SCORE z inner join a01 a on z.Policenum = a.A0117
where examcourse in("101","102") and z.Policenum is not null and year(from_days(datediff(now(), a.A0113))) in(0,1,2) and examdate > "2022-08-01" and examdate < "2022-09-11"
group by jl,examcourse


--下拉去除局领导和老领导
select ouname as text, oucode as value, right(oucode,2) from frame_ou 
where length(oucode)=8 and oucode like "330602%" and right(oucode,2) in("01","02") 
order by value asc

select ouname as text, oucode as value from frame_ou  where 1=1 and length(oucode)=8 and right(oucode,2) 
is not in('01','02') and oucode like "330602%" order by value asc

select * from frame_ou where oucode like '3306%' and length(oucode)=8

select * from frame_ou where oucode = '33060020'

select createusername, ouname, createdate from zg_ajhj_lyj_hdsq where activityguid = ""

select rowguid,username,flowstatus,createdate, d.ouname from (select rowguid,username,flowstatus,createdate,b.ouguid from zysy_specialty_paper a left join frame_user b on a.userguid =b.userguid)c left join frame_ou d on c.ouguid= d.ouguid

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

select * from view_talent_apply vta ;

select rowguid ,username ,ouname ,tc as talent, createdate as applydate, flowstatus from view_talent_apply

select rowguid,username as username1,havemajorandlevel,createdate as applydate1, applystatus from zg_zysy_rczy_apply

select rowguid,username as username1,ouname as ouname1,havemajorandlevel,createdate as applydate1, applystatus 
from zg_zysy_rczy_apply where applystatus !="10"


select * from zg_zysy_rc zzr 
select * from zg_zysy_rc_major zzrm 

select * from ZG_ZYSY_RCPY

select c.itemtext as name,count(distinct(zzr.rowguid)) as value from zg_zysy_rc zzr left join (select distinct rcguid,assessoulevel,employstatus from zg_zysy_rc_major) zzrm on zzr.rowguid=zzrm.rcguid inner join 
(select itemtext,ITEMVALUE from code_items ci where ci.CODEID =(select CODEID from code_main cm where cm.CODENAME='职业生涯-人才评定部门等级')) c 
on zzrm.assessoulevel=c.itemvalue where (zzrm.employstatus !='04' or zzrm.employstatus is null) and zzr.oucode like '3306%' group by c.itemtext

select zzr.adf from zg_zysy_rc zzr left join (select distinct rcguid,assessoulevel,employstatus from zg_zysy_rc_major) zzrm on zzr.rowguid=zzrm.rcguid

select zrr.userguid as img, zzr.username as name, zzr.userguid as guid,zzr.ouname as unit, zzrm.rcmajorname as specialty, zzr.score as score from zg_zysy_rc zzr left join (select distinct rcguid,assessoulevel,employstatus,rcmajorname from zg_zysy_rc_major) zzrm on zzr.rowguid=zzrm.rcguid
where (zzrm.employstatus !='04' or zzrm.employstatus is null) and zzr.oucode like '3306%' and zzrm.assessoulevel ='03'

select rcpy.username as name, rcpy.userguid as guid, rcpy.ouname as unit, rcpy.rcmajorname as specialty, rc.score as score from zg_zysy_rcpy rcpy left join zg_zysy_rc rc on rcpy.userguid = rc.userguid where rcpy.oucode like '3306%' and rcpy.pymb="03" ; 

select rowguid,username,ouname,havemajorandlevel,createdate as applydate, applystatus from zg_zysy_rczy_apply order by createdate limit ?,?

select a0117,a0101 from a01 where a0121 like "330602%"
select idxname,idxcontent,score from zg_zysy_rc_scoredetail where idxname ="人才战队"

select *from zg_jx_score order by Createdate 
select rowguid ,username as username1 ,ouname as ouname1 ,tc as talent, createdate as applydate1, flowstatus from view_talent_apply where 1=1 and flowstatus != '10' limit 0,10

update frame_attachinfo set cliengguid = '4728d88d-a145-4c1c-934e-b9de73ad9736' where attachguid = 'c2ea701b-2e94-4f0b-842f-3f3b8e42d668'；

select * from frame_attachinfo where cliengguid = 'f39202c6-9581-417e-ad5d-75fc5bcf8094';

select * from zg_ajhj_lyj_hdgl zalh order by operatedate desc;

select * from frame_attachinfo order by UPLOADDATETIME desc

--子女就学优待
select * from a22 where 1=1 and rowguid = "0000ED301DED57D10092BBF985BE3146"

select ROWGUID ,a2202 as name ,a2201 as relation , year(from_days( datediff(now(), A2203)))+1 as age from a22 
where A2201 like "2%" or A2201 like "3%"
select * from zg_ajhj_lyj_hdsq where 1=1 and activityguid ="aae80f5d-93c6-4e1f-b35c-7aa6355fdde0"da

select * from zg_ajhj_lyj_hdsq where 1=1 and oucode like '3306%' 
and activityguid = '1550316b-60fa-4f6a-8e4e-74230404490b' order by  createdate  desc
select round(DATEDIFF(CURDATE(), '2015-10-1')/365.2422)

--子女就学优待
select c.a0100,c.a2201,c.a2202,c.a2203,c.a2206,c.a0101, c.a0117, c.a0148, c.a0121,q.a2701,
(year(from_days( datediff(now(), a2203)))+1) as age from 
(select a.a0100, a2201, a2202, a2203, a2206, b.a0101, b.a0117, b.a0148, b.a0121 
from a22 a left join a01 b on a.a0100 = b.a0100 
where (a2201 like '2%' or a2201 like '3%') and (year(from_days( datediff(now(), a2203)))+1) in (6, 7, 14, 15)) c
left join a27 q on c.a0100 = q.a0100 where q.a2701 in('101','102','10501','10502')

--不包含荣誉
(select a.a0100, a2201, a2202, a2203, a2206, b.a0101, b.a0117, b.a0148, b.a0121 
from a22 a left join a01 b on a.a0100 = b.a0100 where (a2201 like '2%' or a2201 like '3%')
and (year(from_days( datediff(now(), a2203)))+1) in (6, 7, 14, 15))

order by a0100

--根据userguid查找荣誉
select a2701 from a27 where A0100




--最终
--a12历史记录
select A0100 from a12 where A1203 like '%越城%'           

select a.A0100 ,a.A0101 , a.A0117 ,a.A0148 , a.A0176 ,a.A0121 from a01 a left join a12 b on a.A0100 = b.A0100 
where a.A0121 like '330602%' or (a.A0121 like '330600%' and b.A1203 like '越城') 



select * from 
(select c.A0100 ,c.A2201,d.A2701 ,(year(from_days( datediff(now(), a2203)))+1) as age from a22 c left join a27 d on c.A0100 = d.A0100
where (c.A2201 like '2%' or c.A2201 like '3%') and d.A2701 in('101','102','10501','10502') and (year(from_days( datediff(now(), a2203)))+1)in(6, 7, 14, 15)) m 
left join 
(select a.A0100 ,a.A0101 , a.A0117 ,a.A0148 , a.A0176, a.A0121 from a01 a left join a12 b on a.A0100 = b.A0100 
where a.A0121 like '330602%' or (a.A0121 like '330600%' and b.A1203 like '越城')) n 
on m.A0100 = n.A0100 

select m.a0100,m.a2201,m.A2202,m.A2203,m.a2701,m.age,n.a0101,n.a0117,n.a0148,n.a0176,n.a0121 from 
(select c.A0100 ,c.A2201, c.A2202,c.A2203 ,d.A2701 ,(year(from_days( datediff(now(), a2203)))+1) as age from a22 c left join a27 d on c.A0100 = d.A0100
where (c.A2201 like '2%' or c.A2201 like '3%') and d.A2701 in('101','102','10501','10502') and (year(from_days( datediff(now(), a2203)))+1)in(6, 7, 14, 15) group by c.A0100,c.A2201) m 
left join 
(select a.A0100 ,a.A0101 , a.A0117 ,a.A0148 , a.A0176, a.A0121 from a01 a left join a12 b on a.A0100 = b.A0100 
where a.A0121 like '330602%' or (a.A0121 like '330600%' and b.A1203 like '越城')) n 
on m.A0100 = n.A0100 

select m.a0100,m.a2201,m.A2202,m.A2203,m.age,n.a0101,n.a0117,n.a0148,n.a0176,n.a0121 from (select c.A0100 ,c.A2201, c.A2202,c.A2203 ,(year(from_days(datediff(now(), a2203)))) as age from a22 c where (c.A2201 like '2%' or c.A2201 like '3%') and (year(from_days(datediff(now(), a2203)))) in(5, 6, 13, 14) group by c.A0100,c.A2201) m inner join (select a.A0100 ,a.A0101 , a.A0117 ,a.A0148 , a.A0176, a.A0121 from a01 a where (a0100 in(select a0100 from a12 where a1203 like '%越城%') and a.A0121 like '330600%') or a.A0121 like '330602%') n on m.A0100 = n.A0100

select m.a0100,m.a2201,m.A2202,m.A2203,m.age,n.a0101,n.a0117,n.a0148,n.a0176,n.a0121 from 
(select c.A0100 ,c.A2201, c.A2202,c.A2203 ,(year(from_days( datediff(now(), a2203)))+1) as age from a22 c
where (c.A2201 like '2%' or c.A2201 like '3%') 
and (year(from_days( datediff(now(), a2203)))+1) in(6, 7, 14, 15) group by c.A0100,c.A2201) m 
inner join 
(select a.A0100 ,a.A0101 , a.A0117 ,a.A0148 , a.A0176, a.A0121 from a01 a
where (a0100 in(select a0100 from a12 where a1203 like '%越城%') and a.A0121 like '330600%') or a.A0121 like '330602%') n 
on m.A0100 = n.A0100


select
	count(1) as total,
	case when TIMESTAMPDIFF(year, birthdate, CURDATE())<= 35 then '35周岁已下'
	when TIMESTAMPDIFF(year, birthdate, CURDATE())>35 and TIMESTAMPDIFF(year, birthdate, CURDATE())<= 49 then '36-49周岁'
	else '50周岁及以上' end as name,
	case when TIMESTAMPDIFF(year, birthdate, CURDATE())<= 35 then sum(case when TIMESTAMPDIFF(year, birthdate, CURDATE())<= 35 then 1 else 0 end) 
	when TIMESTAMPDIFF(year, birthdate, CURDATE())>35 and TIMESTAMPDIFF(year, birthdate, CURDATE())<= 49 then sum(case when TIMESTAMPDIFF(year, birthdate, CURDATE())>35 and TIMESTAMPDIFF(year, birthdate, CURDATE())<= 49 then 1 else 0 end)
	else sum(case when TIMESTAMPDIFF(year, birthdate, CURDATE())>= 50 then 1 else 0 end) end as value
from
	zg_zysy_rc zzr
where exists (select 1 from zg_zysy_rc_major zzrm where zzrm.rcguid = zzr.rowguid and zzrm.employstatus = '01') and zzr.oucode like '3306%'
-------------性别

select
	count(1) totalnumber,
	sum(case when sex = '1' then 1 else 0 end) as male,
	sum(case when sex = '2' then 1 else 0 end) as female
from
	zg_zysy_rc zzr
where exists (select 1 from zg_zysy_rc_major zzrm where zzrm.rcguid = zzr.rowguid and zzrm.employstatus = '01') and zzr.oucode like '3306%'
--------------------
	
select
	left(zzr.oucode,6),
	fom.mapareaname as name,
	count(1) as value
from
	frame_ou_map fom left join zg_zysy_rc zzr on zzr.oucode like concat(fom.oucode, '%')where exists (select 1 from zg_zysy_rc_major zzrm where zzrm.rcguid = zzr.rowguid and zzrm.employstatus = '01')
group by
	fom.mapareacode,
	fom.mapareaname
	
--------------
select
	ouname as text, oucode as value 
from frame_ou 
where case when length('3306')=4 then (oucode like "3306%" and (length(oucode)=6 or length(oucode)=4)) 
when length('3306')=6 then (oucode like "3306%" and (length(oucode)=8 or length(oucode)=6)) end
order by value asc


-----年龄
select
	count(1) as total,
	case when TIMESTAMPDIFF(year, birthdate, CURDATE())<= 35 then '35周岁已下'
	when TIMESTAMPDIFF(year, birthdate, CURDATE())>35 and TIMESTAMPDIFF(year, birthdate, CURDATE())<= 49 then '36-49周岁'
	else '50周岁及以上' end as name,
	case when TIMESTAMPDIFF(year, birthdate, CURDATE())<= 35 then sum(case when TIMESTAMPDIFF(year, birthdate, CURDATE())<= 35 then 1 else 0 end) 
	when TIMESTAMPDIFF(year, birthdate, CURDATE())>35 and TIMESTAMPDIFF(year, birthdate, CURDATE())<= 49 then sum(case when TIMESTAMPDIFF(year, birthdate, CURDATE())>35 and TIMESTAMPDIFF(year, birthdate, CURDATE())<= 49 then 1 else 0 end)
	else sum(case when TIMESTAMPDIFF(year, birthdate, CURDATE())>= 50 then 1 else 0 end) end as value
from
	zg_zysy_rc zzr where exists (select 1 from zg_zysy_rc_major zzrm where zzrm.rcguid = zzr.rowguid and zzrm.employstatus = '01')
	and zzr.oucode like '3306%'
-------------------------------------------
select
	count(1) totalnumber,
	sum(case when TIMESTAMPDIFF(year, birthdate, CURDATE())<= 35 then 1 else 0 end) as underage,
	sum(case when TIMESTAMPDIFF(year, birthdate, CURDATE())>35 and TIMESTAMPDIFF(year, birthdate, CURDATE())<= 49 then 1 else 0 end) as betweenage,
	sum(case when TIMESTAMPDIFF(year, birthdate, CURDATE())>= 50 then 1 else 0 end) aboveage
from zg_zysy_rc zzr where exists (select 1 from zg_zysy_rc_major zzrm where zzrm.rcguid = zzr.rowguid and zzrm.employstatus = '01') and zzr.oucode like '3306%'
	
	
select zzrm.rcmajorconfigguid,zzrm.rcmajorname name,count(*) value
from zg_zysy_rc zzr left join zg_zysy_rc_major zzrm on zzr.rowguid = zzrm.rcguid where zzr.oucode like '[oucode]%'
and zzrm .rctype = '[majortype]' and zzrm.employstatus = '01' group by zzrm .rcmajorconfigguid 



select itemtext,count(1) number from(zg_zysy_rc_major zzrm inner join zg_zysy_rc zzr on zzrm.rcguid = zzr.rowguid)
inner join (select itemtext,itemvalue from code_items ci where ci.CODEID =(select CODEID from code_main cm where cm.CODENAME = '职业生涯-人才等级')) c on zzrm.rclevel = c.itemvalue
where
	zzrm.employstatus = '01'
	and zzrm.rcmajorconfigguid = '11'
	and zzr.oucode like '3306%'
group by
	itemtext
	select
	zze.userguid as userguid,
	zze.username as name,
	CONCAT("http://41.190.96.58/epoint-zg-sx-web/rest/attachAction/getContent?isCommondto=true&attachGuid=", fa.ATTACHGUID) as img
from
	zg_zysy_expert zze
inner join frame_attachinfo fa on
	zze.rowguid = fa.CLIENGGUID
where
	cliengtag = 'ZG_ZYSY_EXPERT_PHOTO'
	
	
-----------------------------------------------------------
select
	zze.userguid as userguid,
	zze.username as name,
	CONCAT("http://41.190.96.58/epoint-zg-sx-web/rest/attachAction/getContent?isCommondto=true&attachGuid=", fa.ATTACHGUID) as img
from
	zg_zysy_expert zze
inner join frame_attachinfo fa on
	zze.rowguid = fa.CLIENGGUID
where
	cliengtag = 'ZG_ZYSY_EXPERT_PHOTO'
	
	
	

CREATE TABLE `zg_ajhj_ydfj_transfer` (
  `rowguid` varchar(50) NOT NULL COMMENT '主键',
  `createdate` datetime DEFAULT NULL,
  `userguid` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(5) DEFAULT NULL COMMENT '性别',
  `jh` varchar(10) DEFAULT NULL COMMENT '警号',
  `age` int(11) DEFAULT '0' COMMENT '年龄',
  `oucode` varchar(50) DEFAULT null COMMENT '调出单位oucode',
  `ouname` varchar(50) DEFAULT null COMMENT '调出单位ouname',
  `moveoucode` varchar(50) DEFAULT null COMMENT '调入单位oucode',
  `moveouname` varchar(50) DEFAULT null COMMENT '调入单位ouname',
  PRIMARY KEY (`rowguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='异地分居调出详情表'
	
	
select userguid from zg_ajhj_ydfj_transfer where 1=1 and projectguid = 'b3a93a-34d3-11d6-005056a'	


select * from zg_ajhj_ydfj_info where a0100 not in('0545c2-e919-4a87-98e8-f5f86259fc','0545c2-e919-4a87-98e8-f5f86259fc')
select * from zg_ajhj_ydfj_info where rowguid ='4703ddd6-496c-4ed2-a31a-4cf468f40892';

select * from zg_ajhj_ydfj_info

select * from zg_ajhj_ydfj_info where a0101 = '王某某'

select * from zg_ajhj_ydfj_info where oucode like "330605%" and oucode_bl like "330604%";



select * from zg_ajhj_ydfj_info where 1=1 and a0100 != and oucode like ? and isydfj = ? and oucode_bl like ? order by  rowguid  desc
	
	
	
select userguid from zg_ajhj_ydfj_transfer where 1=1 and projectguid = "dd6ac5c0-ac4f-46b4-9bf3-5d75d905e5da"
select * from zg_ajhj_ydfj_transfer where 1=1 and projectguid = 'dd6ac5c0-ac4f-46b4-9bf3-5d75d905e5da'

select userguid from zg_ajhj_ydfj_transfer where 1=1 and projectguid = 'dd6ac5c0-ac4f-46b4-9bf3-5d75d905e5da'

select distinct(userguid) from zg_ajhj_ydfj_transfer where 1=1 and projectguid = 'dd6ac5c0-ac4f-46b4-9bf3-5d75d905e5da'
select a0100 from zg_ajhj_ydfj_info where status = "80"

select totalnum from zg_ajhj_ydfj_detail where 1=1 and projectguid = 'fc2ddaf6-40f8-497b-ab01-0b1a1f15f2a6' and oucode = '330603' and yddxoucode = '330604'


select a0100, a0101, a0103, a0104, a0117, a0118, a0121, a0111 from a01 a where exists (select 1 from a22 b where b.a2202 = a.a0101 and b.a2203 = a.a0104 and b.a2201 like '1%' and b.a0100='141164')
select TIMESTAMPDIFF(YEAR, '1980-10-2', CURDATE()) as age
select A2202, A2206, a2222, TIMESTAMPDIFF(YEAR, A2203, CURDATE()) as age from a22 where A0100 = '141164' and A2201 like '1%'
select a0100, a0101, a0103, a0104, a0117, a0118, a0121 from a01 a where exists (select 1 from a22 b where b.a2202 = a.a0101 and b.a2203 = a.a0104 and b.a2201 like '1%' and b.a0100='?')

select rcm.rckname ,rcm.rclevel ,rcm.assessoulevel ,rcm.zgtjreason from zg_zysy_rc rc left join zg_zysy_rc_major rcm on rc.userguid = rcm.userguid where rc.userguid='141164'

select * from zg_zysy_rc where 1=1 and rowguid in (select distinct rcguid from zg_zysy_rc_major where rclevelname ='骨干' )  order by  createdate  desc

select * from zg_zysy_rc rc inner join zg_zysy_rc_major rcm on rc.rowguid = rcm.rcguid where 1=1 and rc.rowguid in (select distinct rcguid from zg_zysy_rc_major where rclevelname ='骨干' )  order by  rc.createdate  desc

select count(1) total,sum(case when sex='1' then 1 else 0 end) as malenum,sum(case when sex='2' then 1 else 0 end) as femalenum from 
zg_zysy_rc zzr where zzr.oucode like '3306%' and zzr.ouguid is not null and zzr.ouguid !=''

select  count(1) total,sum(case when sex='1' then 1 else 0 end) as malenum,sum(case when sex='2' then 1 else 0 end) as femalenum from 
(select * from zg_zysy_rc where 1=1 and oucode like '3306%'and (sex='1' or sex='2') and rowguid in 
(select distinct rcguid from zg_zysy_rc_major where employstatus !='04' or employstatus is null)) a



select count(1) total,sum(case when sex='1' then 1 else 0 end) as malenum,sum(case when sex='2' then 1 else 0 end) as femalenum from 
zg_zysy_rc zzr where zzr.oucode like '3306%' and (sex = '1' or sex ='2') and rowguid in(select distinct rcguid from zg_zysy_rc_major where employstatus !='04' or employstatus is null)

select count(1) from zg_zysy_rc where 1=1 and oucode like '3306%' and sex ='1' and rowguid in (select distinct rcguid from zg_zysy_rc_major where employstatus !='04' or employstatus is null )   order by  createdate  desc

select count(1) totalnumber,sum(case when TIMESTAMPDIFF(YEAR,birthdate,CURDATE())<=35 then 1 else 0 end) as underage,
sum(case when TIMESTAMPDIFF(YEAR,birthdate,CURDATE())>35 and TIMESTAMPDIFF(YEAR,birthdate,CURDATE())<=49 then 1 else 0 end) as betweenage,
sum(case when TIMESTAMPDIFF(YEAR,birthdate,CURDATE())>=50 then 1 else 0 end) aboveage 
from zg_zysy_rc zzr where exists (select 1 from zg_zysy_rc_major zzrm where zzrm.rcguid= zzr.rowguid and zzrm.employstatus='01') and birthdate is not null and zzr.oucode like  '3306%'

select
	ouname as text, oucode as value 
from frame_ou 
where case when length('33060515')=4 then (oucode like '33060515%' and (length(oucode)=6 or length(oucode)=4)) 
when length('33060515')=6 then (oucode like '33060515%' and (length(oucode)=8 or length(oucode)=6)) 
when length('33060515')=8 then (oucode like '33060515%' and (length(oucode)=10 or length(oucode)=8))
when length('33060515')=10 then (oucode like '33060515%' and (length(oucode)=10)) end 
order by value asc
select * from a_personal_item_report where 1=1 and reporttime >= ? order by createdate  desc


select ouname name, warndetail detail, warnlevel level,oucode from zg_sjcj_dwts_warn where oucode like '330602%'  and length(oucode) = 8  order by oucode limit 8;


select * from b04 where 1=1 and b0401 = 'f1ac5469-806f-4ba1-8ca3-1a0690f54d05' order by  B0406  desc

select max(treecode) from ga_warn_category where treecode like 

	select max(treecode) from ga_warn_category where length(treecode)=4
	
	select a.A0100,b.DISPLAYNAME as username from a27 a left join frame_user b on a.a0100=b.USERGUID where username = '';
select * from workflow_processversion where processversionname like '个人%'

select * from zg_sjcj_szqd_zruser order by Createdate desc 


select * from zg_sjcj_ggcx_gadn_apply order by OperateDate desc 

select * from zg_sjcj_ggcx_gadn_apply where 1=1 and rowguid in (select relationguid from zg_sjcj_ggcx_user_relelation where username like "%张%") and isdelete = 0 and applyuserguid = "141164" order by  applydate  desc

select * from zysy_specialty_treatise left join frame_user using(userguid) left join frame_ou using(ouguid) where 1=1 and oucode like '330601%' order by  createdate  desc


select * from zg_sjcj_jdgl_apply_opinion where 1=1 and applyguid = '0b1f3655-25a9-401f-bf12-58f4d24022b3' order by  createdate  desc


c5c0e056-c692-4f56-9d5f-32b1b56c462e

select flowstatus, count(*) rycount from jsbj_sjcj_ryq_reward_info where userguid = 'c5c0e056-c692-4f56-9d5f-32b1b56c462e' and isdelete='0' group by flowstatus

select rowguid, createuserguid, userguid ,applydate , flowstatus ,reason ,group_concat(rewardname separator ';') rynames from jsbj_sjcj_ryq_reward_info where isdelete = '0' and userguid ='c5c0e056-c692-4f56-9d5f-32b1b56c462e' group by rowguid  

select * from frame_user where USERGUID ='c5c0e056-c692-4f56-9d5f-32b1b56c462e'
select * from frame_user where USERGUID ='833b225f-ed92-4bc1-ae98-58f404c13482'

select distinct rowguid, categorycode, categoryname from zj_target_category where 1=1

select Categoryguid,Categoryname from jsbj_zysy_road_zb group by Categoryguid,Categoryname


select rzb.Zbname zbname, rzb.Collectname collectname, rzb.isqualified isqualified from jsbj_zysy_road_zb rzb join zj_target z on rzb.Zbguid = z.rowguid where z.categoryguid = 'e8760a40-b5d1-4e45-89f2-11a945bd3bcc' and rzb.Isqualified = '1'  and rzb.Roadguid = '001' and rzb.Zbname ='辅助决策'

select count(*) num, rzb.Zbname zbname, rzb.Collectname collectname, rzb.isqualified isqualified from jsbj_zysy_road_zb rzb join zj_target z on rzb.Zbguid = z.rowguid group by rzb.isqualified

select count(*) num , rzb.isqualified isqualified from jsbj_zysy_road_zb rzb join zj_target z on rzb.Zbguid = z.rowguid where z.categoryguid = 'e8760a40-b5d1-4e45-89f2-11a945bd3bcc' and rzb.Roadguid = '001' and Isqualified = '1'

select* from jsbj_zysy_road_zb rzb join zj_target z on rzb.Zbguid = z.rowguid group by Isqualified 

select * from jsbj_zysy_personal_post 


select count(distinct r.Tcguid) from jsbj_rck_tc_apply a join jsbj_rck_tc_apply_relation r on a.rowguid =r.Applyguid where a.Flowstatus in('02','03') and a.isdelete='0'

select * from jsbj_zysy_notice_post_intention where noticepostguid = '22045004-cfa2-4ae3-a92e-f55ecf65f486'