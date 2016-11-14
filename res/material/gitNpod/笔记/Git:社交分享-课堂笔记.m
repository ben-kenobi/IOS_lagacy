
#pragma mark - 一. Git

#pragma mark 1. Git介绍/Git与SVN区别(了解)
分布式管理工具

#pragma mark 2. Git命令行演练-单人(掌握/重点)
Git和SVN相比有两道门(暂存区/本地版本库)

前提: 创建好文件夹, cd进入
一. 常见命令
0. 查看帮助: git help
1. 仓库的初始化 : git init
2. 初始化项目: touch Car.h
3. 查看状态: git status .
4. 添加文件到暂存区: git add Car.h
5. 提交文件到当前分支(本地版本库) : git commit -m "初始化项目"
6. 添加本地目录下, 所有未在暂存区的文件: git add .


注意: 本地演练, 不需要配置账号信息. 如果需要给服务器push, 需要提前配置账号
红色,没有被添加到本地暂存区 或者 文件被修改 或者 发生了冲突 / 绿色, 已经被添加本地暂存区

二. 配置账号
名字: git config user.name huizhubo
邮箱: git config user.email huizhubo@itcast.cn

配置全局账号
名字: git config --global user.name huizhubo
邮箱: git config --global user.email huizhubo@itcast.cn

三. 起别名(给命令重新命名)
git config alias.st "status" : 这里的st, 代表着将来你要替换的简称, ""内容是原有命令的全称

四. 配置全局命令
配置的文件在, finder, 前往--> 个人 找隐藏的.git文件
配置的时候, 只需要在config 后面拼接 --global即可

五. 打印日志
git log
版本号: 83c83c99de0cc61ebe48a2ff45dccee1116ee1fe : 40位的哈希值
增强版log : 配置之后, 版本号只会显示前7位, 信息更加精简.

# 配置带颜色的log别名
$ git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"


#pragma mark 3. Git工作原理(掌握/难点)
文件先要add添加到暂存区, 然后commit提交给本地当前分支

#pragma mark 4. Git多人开发(掌握/重点)
一. 常见命令
前提, 进入到指定目录
唐僧操作:
1. 初始化服务器仓库 : git init --bare / bare : 空的
本地仓库的路径 /Users/itheima/Desktop/Git演练/QQ/
2. 克隆远程服务器(下载代码/保持和服务器的连接) :git clone /Users/itheima/Desktop/Git演练/QQ/
3. 进入到git目录中, 进行初始化项目: 使用Xcode创建项目. 默认已经被添加过, 文件基本是A和M状态
4. 如果要提交给服务器/让别人收到最新的代码, 需要push : git push (push之前, 必须提交绿色标志的代码)

新人加入开发:
1. clone
2. 想要获取最新代码: git pull

解决冲突:
1. 先pull, 在commit. 如果冲突了, 那么文件就多了冲突的代码
2. 删除不认识的代码, 然后手动调整代码
3. 需要将冲突解决完毕的文件, 先add, 再commit, 最后push

注意: 已经有了git管理的目录, xcode在创建项目时, 不能在勾选底部git选项.

二. Xcode集成Git

1. 忽略文件的制作: echo -e "输入拷贝的代码" > .gitignore
2. 上传忽略文件. 注意, 在整个项目提交到远程服务器(push)之前, 一定要添加忽略文件. 此文件一定要放到git管理目录中
3. 添加完毕, 需要add, commit, push
4. 使用Xcode创建项目(Xcode会自动帮我们做add操作, 项目的配置文件一定要提交)
5. 模拟xcode冲突: 跟SVN一样. 需要解决冲突, 然后提交在push

注意: Xcode7的bug

删除文件 : git rm -f .DS_Store : 删除文件, 需要提交, 在push

#pragma mark 5. Git远程服务器-OSChina(了解)


#pragma mark 6. Git分支管理(了解)























#pragma mark - 二. 社交分享

#pragma mark 1. 自带分享
1. 判断服务类型是否可用
2. 创建分享控制器 --> 绑定服务类型 --> 可以自定义属性
3. 模态视图弹出显示

定位的位置: 模拟器随机可以拿到位置
         真机肯定可以获取位置. 只能在手机微博客户端中, 点击微博详细才能看到

#pragma mark 2. 友盟分享
一. 授权问题
1. 分享需要授权
模拟器中: 弹出网页, 输入账号密码, 点击授权
真机中 : 跳到对应的第三方程序, 点击授权

2. 两种授权方式:
模拟器是OAuth2.0授权 --> 弹出网页
真机是SSO授权 --> 跳转第三方程序

二. 集成方式
1. 看文档集成 , iOS9适配. 记得配置http

三. 注意点
如果想要自己的程序分享时, 底部显示自己的程序(点击可以跳转自己的官网).
1. 注册各个平台, 创建应用, 并提交审核.
2. 审核通过之后, 将需要的信息(APPKEY , APPID), 配置到友盟后台
3. 点击自己所创建的程序, 找到左边 社会化分享 , 再次点击 设置, 最后填入对应的值即可.


#pragma mark 3. SSO授权 - 分享
SSO授权定义: SSO指单点登录，当用户安装了对应第三方客户端且登录时，可以在登录时免去输入账号密码的过程，简化分享流程

集成流程: 1.导入框架 2.配置URLScheme(sina.友盟key保证唯一性) 3. 导入头文件 4. 拷贝相关方法 5. 一定要注意跳转问题--> iOS9白名单



#pragma mark 4. SSO授权 - 第三方登录
必须有第三方程序存在
第三方登陆定义: 第三方登录主要用于简化用户登录流程，通过用户拥有的微博、QQ、微信等第三方账号进行登录并且构建APP自己的登录账号体系。


#pragma mark 5. SSO授权优势
模拟器是OAuth2.0授权 --> 弹出网页
真机是SSO授权 --> 跳转第三方程序

一. OAuth2.0 和 SSO 不同
OAuth2.0 -->  弹出网页, 输入账号密码, 点击授权(如果没有授权过, 需要点击)
SSO : 跳到对应的第三方程序, 点击授权(首次需要点击, 之后直接发生跳转, 完成验证).

二. SSO的优势
缺点: 必须按照第三方

优点:
1. 方便, 不用输入账号密码 (忘记密码, 密码太长, 密码输错)
2. 安全, 可以保护用户信息安全 . 不用将账号密码信息泄露给你要使用的程序服务器(陌陌)
3. 可以最大限度保留用户(产品经理非常喜欢)






