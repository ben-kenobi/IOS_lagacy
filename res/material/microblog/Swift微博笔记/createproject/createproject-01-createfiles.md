# 创建文件

## 准备工作

### 删除模板文件

* ViewController.swift
* Main.storyboard
* LaunchScreen.xib

### 创建项目结构

#### 主目录 `Classes`

#### 二级目录

| 目录名 | 说明 |
| -- | -- |
| Model | 数据模型 |
| View | 视图和控制器 |
| ViewModel | 业务逻辑模型 |
| Tools | 工具类 |

#### `View` 子目录

| 目录名 | 说明 |
| -- | -- |
| Main | 主要 |
| Home | 首页 |
| Message | 消息 |
| Compose | 撰写 |
| Discover | 发现 |
| Profile | 我 |

#### `View中每个文件夹` 子目录
| 目录名 | 说明 |
| -- | -- |
| Controller | 控制器 |
| View | 自定义View控件 |


## 创建项目文件

### Main

| 目录 | Controller |
| -- | -- |
| Main | HMMainViewController.swift(`:UITabBarController`) |

### 功能模块

| 目录 | Controller |
| -- | -- |
| Home | HMHomeTableViewController.swift |
| Message | HMMessageTableViewController.swift |
| Discover | HMDiscoverTableViewController.swift |
| Profile | HMProfileTableViewController.swift |

#### 细节

* 每个 ViewController 继承自 `UITableViewController`
* 搭建完成的文件结构图如下：

![](./images/Icons/功能模块文件结构.png)

* 修改 `AppDelegate` 中的 `didFinishLaunchingWithOptions` 函数，设置启动控制器

```swift
window?.rootViewController = MainViewController()
```
