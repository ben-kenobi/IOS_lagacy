# 下拉刷新 & 上拉加载

## 课程目标

- KVO的使用
- UIScrollView使用


## 接口准备

- 新浪微博下拉刷新与上拉加载需要有两个重要的参数

| 参数名 | 说明 |
| -- | -- |
| since_id | 返回ID比since_id大的微博（即比since_id时间晚的微博） |
| max_id | 返回ID小于或等于max_id的微博 |

以上可知：
1. 如果传入since_id，服务器会返回ID比since_id大的微博（即比since_id时间晚的微博），也就是最新的微博，所以这个参数可以用于下拉刷新.
2. 传入max_id，服务器会返回ID小于`或等于`max_id的微博，id 越小时间越早，所以可以用作上拉加载。(特别注意：会返回ID小于`或等于`)


- 更改微博数据加载的方法-> `HMStatusListViewModel` 中 `loadStatuses` 方法添加参数

```swift
/// 加载微博数据的方法
func loadData(isPullUp isPullUp: Bool, completion: (isSuccessed: Bool)->()) {
    // 定义 url 与参数
    let urlString = "https://api.weibo.com/2/statuses/friends_timeline.json"

    let since_id = isPullUp ? 0 : (statuses?.first?.status?.id ?? 0)
    let max_id = isPullUp ? (statuses?.last?.status?.id ?? 0) : 0

    let params = [
        "access_token": HMUserAccountViewModel.sharedUserAccount.accessToken!,
        "since_id": since_id,
        "max_id": max_id
    ]
    ...
}
```


