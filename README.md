# resumeCollection
iOS面试题整理
将用swift和h5结合编写，且swift和h5可交互，持续更新中。。。
js调用swift
js代码
```
window.webkit.messageHandlers.pushWebPage.postMessage({method:"openWebPage",data:{'url':"",'title':""}});
```
swift代码
```
// 这段代码目前没用到
 wkWebView .evaluateJavaScript("returnLastPage", completionHandler: { [weak self](resut, error) in
  self?.navigationController?.setNavigationBarHidden(true, animated: true)
  })
```



### 2018年4月24日，搭建项目
### 2018年4月25日，第一天面试题
-----
![img](https://github.com/wutao23yzd/resumeCollection/blob/master/firstDay.png)
### 2018年4月26日，第二天面试题
![img](https://github.com/wutao23yzd/resumeCollection/blob/master/secondday.png)
### 2018年10月23日，用h5实现波浪效果
![img](https://github.com/wutao23yzd/resumeCollection/blob/master/wave.gif)
小船晃动效果，上下移动 + 加角度的左右摆动
```
@keyframes sway{
  0% {transform: translate3d(0,10px,0) rotate(-15deg); }
  17% {transform: translate3d(0,0,0) rotate(25deg); }
  34% {transform: translate3d(0,-10px,0) rotate(-20deg); }
  50% {transform: translate3d(0,-5px,0) rotate(15deg); }
  67% {transform: translate3d(0,5px,0) rotate(-25deg); }
  84% {transform: translate3d(0,7.5px,0) rotate(15deg); }
  100% {transform: translate3d(0,10px,0) rotate(-15deg); }
}
```
波浪效果
```
@keyframes wave{
  from {transform: translate3d(16.5vw,0,0);}
  to {transform: translate3d(150vw,0,0);}
}
@keyframes wave-bg{
  from {transform: translate3d(50vw,0,0);}
  to {transform: translate3d(183vw,0,0);}
}
```
