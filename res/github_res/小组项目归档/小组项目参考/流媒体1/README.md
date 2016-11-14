
##一个音乐播放器的设计与实现

###这个medo，关于歌曲播放的主要功能都实现了的。下一曲、上一曲，暂停，根据歌曲的播放进度动态滚动歌词，将当前正在播放的歌词放大显示，拖动进度条，歌曲跟着变化，并且使用Time Profiler进行了优化，还使用XCTest对几个主要的类进行了单元测试。

<p align="center">

<img src = "http://images2015.cnblogs.com/blog/471463/201511/471463-20151102154201946-1826580766.png">
<img src ="http://images2015.cnblogs.com/blog/471463/201511/471463-20151102154248477-2145448265.png">
<img src ="http://images2015.cnblogs.com/blog/471463/201511/471463-20151102154429196-284424656.png">

相应的，我还设置了锁屏下的歌曲信息展示：

<img src ="http://images2015.cnblogs.com/blog/471463/201511/471463-20151102165151305-1555357191.jpg">

这是使用Instruments的Time Profiler时的情景:

<img src ="http://images2015.cnblogs.com/blog/471463/201511/471463-20151102165639899-229503385.png">


这篇博客记录了我在编写这个播放器过程中遇到的问题以及解决方案：http://www.cnblogs.com/ziyi--caolu/p/4930378.html