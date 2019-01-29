//
//  IFINewHomeViewController.swift
//  interviewForiOS
//
//  Created by wutao on 2019/1/29.
//  Copyright © 2019 wutao. All rights reserved.
//

import UIKit

class IFINewHomeViewController: UIViewController,WKUIDelegate,WKNavigationDelegate {

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
    
    var _bridge:WKWebViewJavascriptBridge!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        WKWebViewJavascriptBridge.enableLogging()
        _bridge = WKWebViewJavascriptBridge(for: wkWebView)
        // js 调用 swift，先注册
        _bridge.registerHandler("action1") { [weak self] (data, responseCallback:WVJBResponseCallback?) in
            // 数据处理
            if let responseBlock = responseCallback {
                var href = "../../Web/html/IFIAnswer.html?id="
                if data is Dictionary<String, String> {
                    let dict = data as! Dictionary<String, String>
                    href = "../../Web/html/IFIAnswer.html?id=" + dict["id"]!
                }
                let dict = ["href" : href]
                // 数据返还给js
                responseBlock(self?.getJSONStringFromDictionary(dictionary: dict as NSDictionary))
            }
        }
        _bridge.setWebViewDelegate(self)
        startLoad()
        if #available(iOS 11.0, *) {
            wkWebView.scrollView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        wkWebView.frame = view.bounds
    }
    func startLoad() {
        let filePath = Bundle.main.path(forResource: "IFIHomePage", ofType: "html", inDirectory: "WebForVue/html")
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
        
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
    func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
