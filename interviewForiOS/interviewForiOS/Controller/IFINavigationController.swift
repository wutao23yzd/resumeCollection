//
//  IFINavigationController.swift
//  interviewForiOS
//
//  Created by 吴涛 on 2018/4/24.
//  Copyright © 2018年 wutao. All rights reserved.
//

import UIKit

class IFINavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.isEnabled = false
        configureNavBarTheme()
    }
    func configureNavBarTheme() {
        // 1.设置背景图片
        navigationBar.setBackgroundImage(createImageWithColor(IFINavBgColor), for: .default)
        // 2.设置导航栏标题字体属性
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18),NSAttributedStringKey.foregroundColor:UIColor.white];
        navigationBar.isTranslucent = false
        
        let barItem = UIBarButtonItem.appearance()
        let barButtonItemDict = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor:IFINavItemColor]
        barItem.setTitleTextAttributes(barButtonItemDict, for: .normal)
        barItem.setTitleTextAttributes(barButtonItemDict, for: .highlighted)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController?{
        
        return topViewController
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
