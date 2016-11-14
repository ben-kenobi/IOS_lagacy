# 首页

## 课程目标

* 网络 JSON 转模型
* 自定义 Cell

## 接口定义

### 文档地址

http://open.weibo.com/wiki/2/statuses/home_timeline

### 接口地址

https://api.weibo.com/2/statuses/home_timeline.json

### HTTP 请求方式

* GET

### 请求参数

| 参数 | 描述 |
| -- | -- |
| access_token | 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得 |
| since_id | 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0 |
| max_id | 若指定此参数，则返回ID小于或等于max_id的微博，默认为0 |

测试 URL：https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.00ml8IrFLUkOXB32bb2d4ddd0u2gmj

