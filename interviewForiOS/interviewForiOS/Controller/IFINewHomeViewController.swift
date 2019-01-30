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
        // 导航栏相关
        title = "首页"
        let returnButton = UIButton.init(type: UIButtonType.custom)
        returnButton.setTitle("返回", for: .normal)
        returnButton.setTitleColor(UIColor.lightGray, for: .normal)
        returnButton.addTarget(self, action: #selector(goback), for: .touchUpInside)
        returnButton.frame = CGRect.init(x: 0, y:  0, width: 60, height: 44)
        returnButton.isHidden = true
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: returnButton)
        // js交互相关
        WKWebViewJavascriptBridge.enableLogging()
        _bridge = WKWebViewJavascriptBridge(for: wkWebView)
        // js 调用 swift，先注册
        _bridge.registerHandler("action1") { [weak self] (data, responseCallback:WVJBResponseCallback?) in
            // 数据处理
            if let responseBlock = responseCallback {
                var href = "../../Web/html/"
                let dataDict = data as! Dictionary<String, Any>
                let id = dataDict["id"] as! String
                let pageIndex = dataDict["pageIndex"] as? NSNumber
                switch pageIndex?.intValue {
                case 0:
                    href = href + "IFIAnswer.html?id=" + id
                case 1:
                    href = href + "IFIAnswerT.html?id=" + id
                case 2:
                    href = href + "IFIWave.html"
                default:
                    print("no type")
                }
                let dict = ["href" : href]
                // 数据返还给js
                responseBlock(self?.getJSONStringFromDictionary(dictionary: dict as NSDictionary))
                self?.navigationItem.leftBarButtonItem?.customView?.isHidden = false;
            }
        }
        // 处理隐藏与展示导航按钮
        _bridge.registerHandler("showBackItem") { [weak self] (data, responseCallback:WVJBResponseCallback?) in
            // 数据处理
            let dataDict = data as! Dictionary<String, Any>
            let id = dataDict["hidden"] as! Bool
            self?.navigationItem.leftBarButtonItem?.customView?.isHidden = id
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
    @objc func goback(){
        // 返回webview的上一页
        wkWebView.goBack()
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
