# V友伙伴匹配系统

## 1、需求分析

用户添加标签、标签的分类（要有哪些标签、怎么把标签进行分类）学习方向java/c++，工作/大学

1. 主动搜索：允许用户根据标签去搜索其他用户
    1. redis缓存
2. 组队
    1. 创建队伍
    2. 加入队伍
    3. 根据标签查询队伍
    4. 邀请其他人
3. 允许用户修改标签
4. 推荐
    1. 相似度计算算法 + 本地分布式计算

## 2、技术栈

### 前端

1. Vue 3 开发框架（提高页面开发的效率）
2. Vant UI（基于 Vue 的移动端组件库）（React 版 Zent）
3. Vite 2（打包工具，快！）
4. Nginx 来单机部署

### 后端

1. Java 编程语言 + SpringBoot 框架
2. SpringMVC + MyBatis + MyBatis Plus（提高开发效率）
3. MySQL 数据库
4. Redis 缓存
5. Swagger + Knife4j 接口文档

### 开发页面经验

1. 多参考
2. 从整体到局部
3. 先想清楚页面要做成什么样子，再写代码



## 3、开发

前端页面

### 1.前端项目初始化

> Vant4文档[Vant 4 - A lightweight, customizable Vue UI library for mobile web apps.](https://vant-contrib.gitee.io/vant/#/zh-CN/)
> 

用脚手架初始化

> Vite3中文文档[Vite](https://cn.vitejs.dev/guide/)

或者使用Vue-cli

安装vant3的组件插件

```bash
yarn add unplugin-vue-components -D
```

配置脚手架配置

```js
import vue from '@vitejs/plugin-vue';
import Components from 'unplugin-vue-components/vite';
import { VantResolver } from 'unplugin-vue-components/resolvers';

export default {
  plugins: [
    vue(),
    Components({
      resolvers: [VantResolver()],
    }),
  ],
};
```

2.前端主页+组件概况

### 2.设计

导航条：名称

主页搜索框——>搜索页——>搜索结果页面（标签筛选页）

内   容：

tab 栏：

- 主页（推荐页+**广告**）
    - 搜索框
    - banner
    - 推荐信息流
- 队伍页
- 用户页（消息-暂时用邮件）

很多页面要复用组件/样式，重复写很麻烦，不利于维护，因此抽象一个通用的布局（layout）

### 3.数据库表设计