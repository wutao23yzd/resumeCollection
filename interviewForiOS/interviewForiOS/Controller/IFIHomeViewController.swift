//
//  IFIHomeViewController.swift
//  interviewForiOS
//
//  Created by 吴涛 on 2018/4/24.
//  Copyright © 2018年 wutao. All rights reserved.
//

import UIKit
import WebKit
class IFIHomeViewController: UIViewController,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler{
    
    var webPage:Int = 0;
    
    lazy var wkConfig:WKWebViewConfiguration = {
        let tempWkConfig = WKWebViewConfiguration()
        tempWkConfig.allowsInlineMediaPlayback = true
        tempWkConfig.allowsPictureInPictureMediaPlayback = true
        return tempWkConfig
    }()
    lazy var wkWebView:WKWebView = {
       let tempWkWebView = WKWebView(frame: view.bounds, configuration: wkConfig)
        tempWkWebView.navigationDelegate = self
        tempWkWebView.uiDelegate = self
        view.addSubview(tempWkWebView)
        return tempWkWebView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "首页"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style:  UIBarButtonItemStyle.plain, target: self, action: #selector(goback))
        navigationController?.setNavigationBarHidden(true, animated: true)
        if #available(iOS 11.0, *) {
            wkWebView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        startLoad()
    }
    @objc func goback(){
        
        if webPage == 1 {
            wkWebView.goBack()
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wkWebView.configuration.userContentController.add(self, name: "pushWebPage")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        wkWebView.configuration.userContentController.removeScriptMessageHandler(forName: "pushWebPage")
    }
   override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        wkWebView.frame = view.bounds
    }
    func startLoad() {
        let filePath = Bundle.main.path(forResource: "IFIHomePage", ofType: "html", inDirectory: "web/html")
        let url = URL.init(fileURLWithPath: filePath!, relativeTo: nil)
        let request = URLRequest.init(url: url)
        wkWebView.load(request)
    }
    // webview 开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    // webview 加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    // webview 加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    // webview 页面跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // 允许页面跳转
        print(navigationAction.request.url)
        
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // js调用oc
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let dict = message.body as! Dictionary<String, Any>
        
        let methodName = dict["method"] as! String
        let param = dict["data"] as! Dictionary<String, String>
        
        if methodName == "openWebPage" {
            navigationController?.setNavigationBarHidden(false, animated: true)
            title = param["title"]
            webPage = 1
        }
    }
    // oc调用js
    func ocCallJs() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
