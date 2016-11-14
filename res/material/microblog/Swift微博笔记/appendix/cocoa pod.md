
# cocoa pods

* `CocoaPods` 是 iOS 最常用最有名的类库管理工具
* 作为 iOS 程序员，掌握 `CocoaPods` 的使用是必不可少的基本技能

## pod 命令汇总

```bash
# 创建默认的 Podfile
$ pod init

# 第一次使用安装框架
$ pod install

# 安装框架，不更新本地索引，速度快
$ pod install --no-repo-update

# 今后升级、添加、删除框架，或者框架不好用
$ pod update

# 更新框架，不更新本地索引，速度快
$ pod update --no-repo-update

# 搜索框架
$ pod search XXX

# 帮助
$ pod --help
```

## Pod file 格式说明

```
# 最低支持的 iOS 版本
platform :ios, '8.0'
# Swift 项目需要将框架转换为 frameworks 才能使用
use_frameworks!
# 框架列表
pod 'AFNetworking'
```

## Pod 安装

```bash
# 添加源
$ sudo gem sources -a http://ruby.taobao.org/
# 删除源
$ sudo gem sources -r https://rubygems.org/
# 安装
$ sudo gem install cocoapods
# 设置
$ pod setup
```

## gem 常用命令

```bash
# 查看gem源
$ gem sources –l
# gem自身升级
$ sudo gem update --system
# 查看版本
$ gem --version
# 清除过期的gem
$ sudo gem cleanup
# 安装包
$ sudo gem install cocoapods
# 删除包
$ gem uninstall cocoapods
# 更新包
$ sudo gem update
# 列出本地安装的包
$ gem list
```

## Alcatraz

```bash
curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh
```

* github 地址：https://github.com/supermarin/Alcatraz

> 提示：由于 cocoapods 和 Xcode 都升级非常频繁，建议通过终端使用 Cocoapods


