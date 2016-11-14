#pragma mark - 一. SVN

#pragma mark 1. 源代码管理起源(了解)
1. 分类
SVN : 集中式
Git : 分布式

2. 建议现在就开始使用源代码管理工具

#pragma mark 2. SVN介绍(了解)


#pragma mark 3. SVN服务器搭建及配置(了解)
1. 端口号: http 80
          https 443
2. 远程仓库的版本: 每次对服务器进行一次操作, 版本就会叠加1

#pragma mark 4. 常见UNIX命令行的使用(掌握)

#pragma mark 5. SVN基本操作(掌握)

一. 常用命令行介绍 --> 模拟多人开发
1> 唐僧(经理初始化项目)
前提: 进入到指定的目录下
1. svn checkout http://192.168.19.167/svn/QQ --username=tangseng --password=tangseng : 下载代码, 只需要做一次
注意: 需要进入到svn管理的目录, 否则就会出现working copy的问题
2. touch Car.h : 初始化项目(用一个文件模拟项目)
3. svn status : 查看文件的状态, 如果本地和服务器一致, 命令执行后没有任何结果
4. svn add Car.h : 添加文件到本地版本库
5. svn commit -m "初始化项目" : 提交本地版本库的代码到远程服务器. -m 的意识是写注释: ""之内的内容应该有意义, 应该填写这次的版本变化内容
6. svn log : 查看日志
7. svn update : 更新代码为服务器最新代码(自己修改的不会被覆盖)
8. svn delete Car.h : 删除文件, 还要提交
9. svn help : 查看所有命令
10. svn revert Car.h : 回退版本

2> 悟空加入开发
1. 进入到正确目录下, 然后checkout
2. 正常开发

3> 八戒加入开发
1. 进入到正确目录下, 然后checkout
2. 正常开发

二. 状态的解释
? : 文件已经添加到了本地路径, 但是没有被本地版本库管理
A : 代表文件/文件夹已经被添加到本地管理仓库中
M : 文件已经本修改, 但是服务器不知道, 需要提交
U : 文件被更新
D : 文件已经被本地版本库删除, 服务器不知道, 需要提交
G : 文件发生过冲突

三. 命令的简写
1. 提交:  svn ci -m 删除了Car.h
2. 监测状态: svn st
3. 更新: svn up
4. 下载: svn co

四. 注意事项
1. 常见报错is not a working copy: 代表不是一个SVN管理的目录. 说明文件路径. 灵活运用pwd来查看是否在svn管理目录
2. 如果删除文件时, 只是移除废纸篓, 那么update就可以恢复.
3. 命令行checkout时, 可以不跟用户名和密码, 会提示输入(如果没有提示, 那就说明有了默认账号)
4. 文件过期 is out of date . 自己的版本跟服务器不一致, 而且发生了冲突. 应该更新
5. svn服务器的每个文件都有单独的版本号
6. 一般公司会给你svn加trunk的地址以及用户名密码. 如果没有给, 及时要
7. 及时提交: 先更新, 在提交. 可以最大化避免解决冲突
8. 谁最后提交, 谁来解决冲突.


#pragma mark 6. 解决文件冲突(掌握)
一. 代码冲突
冲突: 同一个文件, 同一行写了不同的代码. 不同的人提交了

Conflict discovered in '/Users/itheima/Desktop/SVN演练/沙僧/WeiXin/Car.h'.

(p) postpone : 延迟处理(程序员手动解决冲突, 然后再提交)
(mc) mine-conflict : 使用我的代码, 把其他人的代码覆盖
(tc) theirs-conflict : 使用其他人的版本(服务器最新版本), 丢弃我的代码

(df) diff-full : 展示不同
(e) edit : 在命令行中编辑
(s) show all options: 展示其他选项

发生冲突的解决方案
1. 如果发生了冲突, 一般建议选p, 延迟处理
2. 打开文件删除不认识的代码, 然后自己看情况调整代码
3. 告诉本地版本库解决了冲突: svn resolved Car.h
4. 提交代码


<<<<<<< .mine ~ ======= : 自己写的代码
======= ~ >>>>>>> .r5   : 服务器的最新代码(其他人的代码)

<<<<<<< .mine
@property (nonatomic,strong)NSString *banana2; // 悟空增加了香蕉3

@property (nonatomic,strong)NSString *banana3; // 悟空增加了香蕉4=======
@property (nonatomic,strong)NSString *banana2; // 悟空增加了香蕉3

@property (nonatomic,strong)NSString *apple; // 沙僧增加了苹果>>>>>>> .r5


二. 界面(SB/Xib)冲突

#pragma mark 7. 使用第三方图形化工具(掌握)
1. 添加远程代码仓库(如果提前拷贝了svn地址, Cornerstone自动会填入网址)
2. checkout到本地目录
3. 由经理初始化项目, 然后当需要添加时(?), 需要到工具中长按add, 选择下面的选项
4. 提交代码. 接下来其他人就可以继续checkout, 然后合作开发

代码冲突的问题:
跟前面解决方式一样1. 需要手动删除不认识的代码, 合并代码.
                2. 工具中点击下方的resolve按钮, 告诉本地以及解决了冲突
                3. 提交代码

忽略文件的问题: UserInterfaceState.xcuserstate / xcuserdata 可以不用提交

#pragma mark 8. 使用Xcode集成SVN(掌握)
一. checkout方式:
1. 欢迎界面, 选择最底下的选项即可
2. xcode --> 偏好设置 --> account --> 点击底部添加仓库
3. 选中xcode, 选择菜单的source control --> checkout (最方便)

二. 建议大家一定要记住的快捷键
提交的快捷键: com + option + c
提交的快捷键: com + option + x

三. 解决代码冲突
更新时, 一旦出现了冲突, 直接提示让你选择. 点击问号, 然后选择底部的四个小按钮, 然后点击update命令. 完成之后, 再次提交. (xcode没有resolved)

四. 界面冲突
1. 右键SB/Xib文件 --> open as --> source code --> (呈现的xml文件), 需要自己逐行比对, 看缺少了什么代码, 自己补充.
2. 工作中一定要避免Xcode界面发生冲突.

解决界面冲突:
1. 分模块: 首页4个模块, 每个模块自己搞一个SB
2. 沟通: 提前沟通好, 可以最大化避免
3. 丢弃自己的修改: 点击SB文件, 右键--> source control --> 丢弃修改

#pragma mark 9. SVN目录结构(掌握)
trunk: 主分支, 一般项目都在这个文件夹里面
branches: 分支, 将主分支的某些版本, 分离出来进行开发. 开发完成之后可以合并
tags : 主要用户备份重大版本(每次发布appStore的版本可以做备份)



#pragma mark - 二. 支付宝

#pragma mark 1. 支付流程介绍(了解)
1. 下载地址: open.alipay.com --> 找文档中心
2. 旧版的SDK, 里面有两个文档, 一个是看参数说明的, 一个是看集成方式的

#pragma mark 2. 支付宝集成(掌握)
看文档集成, 找Demo

