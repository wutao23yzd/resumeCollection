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
