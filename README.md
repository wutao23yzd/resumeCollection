# resumeCollection
iOS面试题整理
将用swift和h5结合编写，且swift和h5可交互，持续更新
## 第二阶段 利用WebViewJavascriptBridge实现

在第一阶段说过（见下方第一阶段），swift和h5的交互可以使用WKWebView的`userContentController`和webkit的`messageHandlers`功能，这种方法是可行的；经过后续的调查发现一种更好的方案，**WebViewJavascriptBridge**（在github上搜索）这个三方库，不仅可实现h5和原生的交互，方便且稳定，而且在web中加载`vue-bridge-webview.js`后，还可以实现和安卓原生的交互，也就是说web页面只需维护一套代码，便可同时实现iOS和安卓原生的交互。这次主要更新以下内容：

- 利用WebViewJavascriptBridge实现了原生和js的交互，由于该三方库使用OC语言编写，因而采用了桥接的形式
- 由于以前h5代码采用jquery编写(Web文件夹)，导致代码非常乱。后续将逐步采用Vue编写（WebForVue文件夹）
- 项目中集成的`vue-bridge-webview`文件（可在npm上搜索），不仅可以实现js和iOS原生交互，也可以实现js和安卓的原生交互。

在`appDelegate.swift`中，两种方式。
```
// old : 采用userContentController 和 js交互
//self.window?.rootViewController = IFINavigationController(rootViewController: IFIHomeViewController())
// new : 采用WKWebViewJavascriptBridge框架，利用桥接文件和js交互
self.window?.rootViewController = IFINavigationController(rootViewController: IFINewHomeViewController())
```

## 第一阶段 利用WKWebView的特性实现
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

### 2018年4月25日，第一天面试题
-----
![img](https://github.com/wutao23yzd/resumeCollection/blob/master/firstDay.png)
### 2018年4月26日，第二天面试题
![img](https://github.com/wutao23yzd/resumeCollection/blob/master/secondday.png)
### 2018年10月23日，用h5实现波浪效果
![img](https://github.com/wutao23yzd/resumeCollection/blob/master/wave.gif)
-----
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

