01. 建立代码仓库(专门用于团队开发的代码仓库)
================================================================================

# 切换目录
$ cd /Users/liufan/Desktop/git演练/公司/weibo
# 建立空白代码库(专门用于团队开发)
$ git init --bare

02. 项目经理准备项目(前奏)
================================================================================

# 切换目录
$ cd /Users/liufan/Desktop/git演练/经理
# "克隆"代码库到本地
$ git clone /Users/liufan/Desktop/git演练/公司/weibo/

# 个人信息配置(因为要演示一台机器上的多人协作，日常开发可以忽略)
$ git config user.name manager
$ git config user.email manager@163.com

.gitignore
--------------------------------------------------------------------------------
.gitignore可以指定哪些文件不纳入版本库的管理

参考网址：https://github.com/github/gitignore

# 命令行中进入与.git同级的目录
$ cd /Users/liufan/Desktop/git演练/经理/weibo

将以下命令一次性粘贴到命令行中
--------------------------------------------------------------------------------
echo -e "# Xcode
#
build/
*.pbxuser
*.mode1v3
*.mode2v3
*.perspectivev3
xcuserdata
*.xccheckout
*.moved-aside
DerivedData
*.hmap
*.ipa
*.xcuserstate
# CocoaPods
#
# We recommend against adding the Pods directory to your .gitignore. However
# you should judge for yourself, the pros and cons are mentioned at:
# http://guides.cocoapods.org/using/using-cocoapods.html#should-i-ignore-the-pods-directory-in-source-control
#
# Pods/" > .gitignore
--------------------------------------------------------------------------------
# 将.gitignore添加到代码库
$ git add .gitignore

03. 创建项目
================================================================================
提交同时"push"到远程代码仓库

04. 新人加入
================================================================================

...

05. 分布式的代码库 - 仅供参考
================================================================================
由于git是分布式的，任何一台计算机上都保留有完整的代码库的内容，因此可以把团队开发的代码库放在任何位置


多个远程代码库之间的同步演练"提示，此演练仅供了解，具体的使用，需要一定的团队规模之后，才能够体会"


06. 分支管理 - Tag
================================================================================
# 查看当前标签
$ git tag
# 在本地代码库给项目打上一个标签
$ git tag -a v1.0 -m 'Version 1.0'
# 将标签添推送到远程代码库中
$ git push origin v1.0

# 使用tag，就能够将项目快速切换到某一个中间状态，例如产品开发线上的某一个稳定版本
# 签出v1.0标签
$ git checkout v1.0
# 从签出状态创建v1.0bugfix分支
$ git checkout -b bugfix1.0

# 查看远程分支
$ git branch -r
# 删除远程分支
$ git branch -r -d origin/bugfix1.0

