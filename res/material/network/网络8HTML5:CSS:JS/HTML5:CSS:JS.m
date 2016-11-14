/*------------------------------------- 01 HTML5 ---------------------------------------*/

重点:1.了解 HTML5 .
{
    1. 什么是 HTML5 ?
    
    HTML 的全称是:HyperText Markup Language :超文本标记语言! 实质是一个文本(字符串),由 浏览器负责将它解析成网页内容!
    
    HTML5 是 html(网页) 的第五版标准,历时8年才制定完! HTML5 的设计理念就是移动先行!设计目的就是为了在移动设备上支持多媒体!
    
    HTML5 的 优点: 注意, HTML5 的运行平台式浏览器!
    
        跨平台: 利用 HTML5 编写的 UI 界面代码能够运行在所有拥有浏览器的平台(PC/iOS/android)
    
    HTML5 并不是万能的! 不能完成一些特定的功能!比如 拍照/相册(UIImagePickerController).
    
    HTML5 是未来的一种趋势! 作为移动端开发人员,要有所了解!
    
    2. 手机 app 的开发模式:
    
    未来手机 app(iOS 端) 的开发模式大概有以下几种:
    
    {
        1> 原生的开发模式(纯 OC);
        
        2> 纯 HTML5;
        
        3> 原生 + HTML5
        
    }
    
    3. HTML5 的开发可能使用的框架: Sencha-touch  jQuery-Mobile  PhoneGap. 对于 iOS 开发人员必须知道有这些框架!
    
    4. 开发工具: 不同的系统有不同的开发工具,大概有几下几种:
    
    {
        1> android : eclipse, myEclipse, android studio.
        
        2> iOS : Xcode .
        
        3> HTML5 : 由于 html 已经有几十年的开发时间,积累了大量的优秀的开发工具!
        
            *  eclipse, myEclipse(后台最爱)
            *  Dreamwaver (美工最爱, 网页三剑客: Dreamwaver , Flash , Fireworks -> Adobe)
            *  subline text(前端最爱,大神编辑器,可以安装各种各样的插件,配色完美.)
            *  WebStorm (前端喜爱 ,默认集成了各种插件)
    }
    
    5. 不同工程师的职责:
    
    平面设计师(美工) : 切图 , HTML ,CSS ,静态网页
    前端工程师 : HTML ,JS ,模板技术
    后台工程师 : 服务器代码的编写(Java , .Net , php),数据库
    移动工程师 : (iOS, android) : 手机 UI 界面(OC , HTML5),跟服务器交互.
    
}

/*------------------------------------  02 HTML5 语法/标签 ---------------------------*/
重点:1.了解 HTML 语法结构  2.了解 HTML 中的常见标签.
{
    1. HTML 的内容都是由标签构成的! 一个完整的 html 文档的基本结构如下:
    
    基本结构:
    
    ￼<!-- html是所有网⻚的根标签 -->
    <html>
    
        ￼<!-- 网页的配置信息 -->
        ￼<head>
            ￼<meta charset="UTF-8">
            <title>第⼀个网页</title>
        ￼</head>
        
        ￼<!-- 网⻚的具体内容 -->
        ￼<body>
            Hello World!
        ￼</body>
    
    </html>
    
    在 html 中添加注释如下:
    
    ￼<!-- 我是注释 -->
    
    2. HTML 中的常见标签: 一般标签都有开始标签和结束标签.当然没有内容的标签不需要结束标签,比如:<input>(输入框标签), <br>(换行标签)
    
    <h> : 标题标签 h1 文字最大, h1 > h2 > h3 > h4...
    
    <a> : 链接标签; 在标签中增加属性 href = "www.baidu.com" ,href 属性的值 就是链接地址(点击之后就会跳转到一个网页所在地址).默认是覆盖原来的网页跳转.如果想跳转之后再打开一个新的网页,增加一个属性: target = "_blank";
    
    <img src = "test.png" > : 图片标签; 属性 src 的值就是需要添加的图片地址!
    注意: 图片地址可以访问一个 url ,需要添加协议名称! 注意不要跨域访问!可以使用保存在本地文件之下的相对路径!
    
    <div> : 容器标签/类似于 iOS 中的 UIView. 里面可以添加任意的标签! 一般一个网页中的 div 是最多的!
    
    <br> : 换行标签: 一个标签就是一行! 不需要结束标签!
    
    <input> :输入框标签,是跨平台的,会自动跳出输入框!同样不需要结束标签! 属性 placeholder = "占位文字", value = "文本框文字";
    选择不同的 type 属性,会出来不同的东西:
    
    type = "color" 选择颜色;
    type = "checkbox" 对勾框;
    type = "radio" 选择点;
    type = "range" 进度选择;
    type = "date" 日期选择;
    
    HTML 语法非常松散,可以随便写!
    
}
/*------------------------------------- 03  CSS/属性  -----------------------------*/
重点:1.了解 CSS   2. 给 html 标签添加样式
{
    1. 什么是 CSS ?
    
    CSS 全称是  Cascading Style Sheets, 层叠样式表!
    
    CSS 用来控制 html 标签中的样式,主要是用来美化网页的!
    
    CSS 的编码格式是键值对的形式: 冒号 : 左面是属性名,右面是属性值!
    
    属性名:属性值;
    color :red;
    background-color :blue;
    font-size :20px;
    
    
    2. 常见的 CSS 样式:
    单值属性: 只有一个值的属性!
    
    有些样式只需要一个值就能确定,如下:

    文字颜色: "color : red";
    背景颜色: "backgroud-color :blue";
    文字大小: "font-size :18px";
    文字水平居中: "text-align :center";
    文字的行高: "line-height :80" 让文字的行高等于标签的高度,可以设置文字的垂直居中!
    "vertical-align :middle" ,对文字居中没有影响!
    标签的宽度: "width : 200px"
    标签的高度: "height : 80px"
    
    复合属性:有多个值的属性! 有些属性需要多个值共同确定!比如边框;
    
    边框: "border :2px dashed blue ;宽度为 2个像素,虚线边框,边框颜色为蓝色!"
    边框: "border :2px solid green ;宽度为 2个像素,实线边框,边框颜色为绿色!"
    
    3. 给 html 标签添加样式的三种方式:

    1> 行内样式(内联样式):直接在 标签 的 style 属性中书写!
    {
        <input type="text" style="color:red"/>
        
        缺点:
        
        1.只能更改某一个标签内的样式!如果有多个相同的标签,样式不能重用!
        
        2.会使 html 页面源码变得比较混乱!样式代码(CSS)和 html 代码混排在一起!
    }
    
    2> 页内样式:
    {
        在 本网页的 <style> 标签中书写!一般写在 html 的 <head> 标签里!
        
        <style>
        
            body{
                background-color: blue;
            }
            
            div{
                color: red;
                font-size: 30px;
                border: 2px solid green;
                background-color: yellow;
            }
            
            span{
                color: green;
                border: 2px dashed red;
            }
        
        </style>
        
        优点: 一份样式,可以给多个标签使用!
    }
    
    3. 外部样式: 在单独的 CSS 文件中书写!然后在网页中用 <link> 标签引用! 也是写在 <head> 标签中!
    {
        <link rel = "stylesheet" href = "index.css">
        
        注意: 必须添加 rel = "stylesheet";表明链接文件是样式表; rel 用来标明链接文件和 html 的关系!
        
        使用外部样式,可以将别人写好的样式,直接拿过来用!
    }
    
    就近原则: 哪个样式离标签近,就会显示哪种样式!后面的样式会覆盖之前的样式!
    
    一个标签中有可能添加了多个重复的样式,一般情况下,遵循就近原则!
}
/*------------------------------------- 04 CSS/选择器 ---------------------------------------*/
重点: 1.了解 CSS 中的选择器
{
    CSS 中的注释: /* 我是CSS中的注释 */
    
    选择器的作用是 选择对应的标签,为其添加样式!
    
    选择器有如下几种:
    
    0> 通配选择器: 为 html 中所有的标签都添加样式! 选择器格式: * { }
    
    1> 标签选择器: 直接为标签添加样式!  选择器格式: div { }
    
    2> 类选择器: 通过类名(class = "high")选择标签!  选择器格式: .high { }
    
    3> id 选择器: 通过唯一标识符(id = "first")选择标签!  选择器格式: #first {}
    
    4> 并列选择器: 选择器组合,'或'的关系! 选择器格式:  div , .high { }  是div标签或者类名为 high 都满足条件!
    
    5> 复合选择器: 选择器组合,'与'的关系! 选择器格式:  div.high { }  只有两个条件都满足,才可以! 注意中间没有空格!
    
    6> 后代选择器: 选择器格式: div p { }  只有 div 标签中的所有 p 子标签才复合要求! 中间是空格!
    
    7> 直接后代选择器: 选择器格式: div > p { } 只有 div 标签中的直接 p 子标签才复合要求!
    
    8> 相邻兄弟选择器: 选择器格式: div + p { } 只有 与 div 相邻的 p 复合要求!
    
    9> 属性选择器: 通过标签的属性选择对应的标签; 选择器格式: div[name] { } 或者 div[name = "jack"] { } 或者 div[name][age] { }
    
    知道CSS 中有些选择器就 OK 了! 另外还有 伪类选择器/ 伪元素选择器等等!
    
    选择器的优先级: 选择器的针对性越强,它的优先级就越高! 只有在级别的选择器中才遵循就近原则!
    
    "!important" :无条件优先!
    
    div{
        /* 所有的 div 标签中的属性都会无条件添加下面的样式 */
        background-color: black !important;
        color: white !important;
    }
    
    优先级排序: important > 内联 > id > 类 > 标签|伪类|属性 > 伪元素 > 通配符 > 继承
}
/*---------------------------------- 05 利用 CSS 修改 html 标签类型 -------------------------------*/
重点:1.了解 html 中的标签类型! 2. 学会使用 CSS 修改 html 中的标签类型!
{
    1. HTML 中的标签类型!
    
    HTML 中有很多标签!根据显示的类型,主要分为三大类:
    
    1> 块级标签: 独占一行的标签!
    
    特点: 能够随时设置标签的宽度和高度(比如: div ,p ,h1 ,ul ,li)
    
    2> 行内标签(内联标签): 多个行内标签能同时显示在一行!
    
    特点: 宽度和高度取决于内容的尺寸(比如: span ,a ,label)
    
    3> 行内-块级标签)(内联-块级标签)
    
    特点: 多个行内-块级标签可以显示在同一行!
    能够随时设置宽度和高度 (比如: input ,button)
    
    2. CSS 修改标签的显示类型!
    
    CSS 中有个 display 属性! 利用这个属性,能够修改标签的显示类型!
    
    display: inline : 让标签变成行内标签
    display: inline-block : 让标签变成行内-块级标签
    display: block : 让标签变成块级标签
    display: none : 隐藏标签
    
}
/*--------------------------------------- 06 响应式设计 ------------------------------------*/
重点:了解响应式设计的概念!
{
    响应式设计:
    
    概念: 简而言之,就是一个网站能够兼容多个终端!
    
    响应式设计是为了解决移动互联网浏览而诞生的!
    
    可以智能的根据用户行为以及使用的设备环境(系统平台/屏幕尺寸/屏幕定向等)进行相应的布局!
}

/*--------------------------------------- 07 JavaScript/JS -----------------------------------*/
重点:1.了解 JavaScript !
{
    node.js :编写服务器代码!
    
    0. 什么是 JavaScript ?
    
    JavaScript 是一门广泛适用于"浏览器客户端"的'脚本'语言.简称 JS .
    
    由 Netspace 公司设计,当时跟 Sun 公司合作,所以名字像 Java .
    
    JS 的作用: 使网页(HTML)"动"起来;
    
    1> HTML DOM 操作(节点操作,比如 添加,修改,删除节点!)
    
    2> 给 HTML 页面增加动态功能,比如动画.
    
    3> 事件处理: 比如监听鼠标点击, 鼠标滑动 ,键盘输入等.
    
    1. JS 基本语法:
    
    1> 数据类型: js中包括如下数据类型!
    
    number : 包括所有数字(整数/小数).
    boolean : 正常取值 true 或者 false
    string : 字符串, 可以使用双引号或者单引号引住的内容.
    object : 对象类型 (包括数组[]和字典{})
    function : 函数类型
    
    字符串拼接: JS 中拼接字符串直接用 + 号将字符串连接起来就 OK !
    
    JS调试:{
        
        console.log(对象) :在控制台打印信息!
        alert("hello world") :弹出对话框!
        console.log(typeof dog) :查看 dog 对象!
        
    }
    
    2> 函数
    
    函数的定义格式: 注意不能有返回值!
    
    function 函数名(参数列表)
    {
        // 函数体
    }
    
    函数的调用格式:
    
    var result = 函数名(参数值);
    
    注意: this:当前函数属于哪个对象,this 就代表这个对象!
    调用构造函数 new ,可以创建一个新的对象!
    如果函数中没有传递参数,就是 undefined ;
    每一个函数内部都有一个隐藏参数: arguments:是一个数组!
    
    3> 对象的函数调用
    
    var result = 对象.函数名(参数值);
    
    4> JS 中的逻辑运算符: || , && .
    || : 返回第一个为真的值.
    && : 只有前面一个值为真,才会执行后面的方法.
    

    2. JavaScript 的书写方式:
    
    1> 页内 JS: 在当前网页的<script> 标签中编写!
    <script type ="test/javascript"> </script>
    
    2> 外部 JS
    <script src = "index.js"> </script>
    
}

/*--------------------------------------- 08 JS 中的内置对象 -----------------------------------*/
重点: 利用 document 获得 HTML 中的元素!
{
    1. JS 中的内置对象
    
    在 JS 中有两个内置对象: window 和 document;
    
    1> window 特点:
    
    * 所有全局变量都是它的属性.
    * 所有全局函数都是它的函数.
    
    2> 通过 JS 代码动态跳转页面:
    location.href = "http://www.baidu.com";
    window.location.href = "http://www.baidu.com";
    
    
    2.通过 document 可以获得网页中的任意一个元素!
    
    通过 document 获得 HTML 元素的方式:
    
    document.getElementById("icon"); 通过标签唯一标识符获得元素,得到的就是具体的元素(标签)!
    
    document.getElementsByTagName(标签名); 通过标签名获得元素,得到的是所有同名的元素(标签)数组!
    
    document.getElementsByClassName(类名-class 属性值); 通过类名获得拥有相同类名的元素(标签)数组!
    
    document.getElementsByName(name属性值); 通过 name属性值获得拥有相同name属性值的元素(标签)数组!
    
    删除 HTML 的某个元素/节点;
    
    var footer = document.getElementsByTagName("footer")[0];
    footer.remove();
    
    或者: document.getElementsByTagName('footer')[0].remove();
    
    字符串的判断操作:
    
    string.indexOf("test.png"); 判断字符串 string 中是否含有 test.png;如果没有,返回 -1;如果有,返回一个整数值!
    
    
    一些事件:
    
    btn.onclick : 按钮的点击事件;
    
    icon.onmouseover = function(){
        
        鼠标滑入图片!
    }
    
    icon.onmousemove = function(){
        
        鼠标在图片上移动!
    }
    
    icon.onmouseout = function(){
        
        鼠标离开图片!
    }
    
    2. 通过 document 可以创建 HTML 元素;
    document.write(<img src = "123.png">); 将 img 元素插入 body 的最前面!
}

/*--------------------------------------- 09 UIWebView 与 JS交互 -----------------------------------*/
重点: 了解 JS 代码在 OC 中的使用! 利用 WebView 执行 JS 代码!
{
    // str 是执行完最后一句 JS 代码时返回的值!
    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"JS代码"];
    
    // 通过 JS 代码拿到网页的源代码!(包含 html 标签)
    document.getElementsByTagName("html")[0].outerHTML;
    
    // 通过 JS 代码拿到网页的源代码!(不包含 html 标签)
    document.getElementsByTagName("html")[0].innerHTML;
    
}









