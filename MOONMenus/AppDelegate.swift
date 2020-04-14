//
//  AppDelegate.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/2/15.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        MenuCore.core.start()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let nav = UINavigationController.init(rootViewController: DemoViewController.init())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            let historyVC = CorrectHistoryAlertController()
//            nav.present(historyVC, animated: true, completion: nil)
//            let leesonVC = CorrectingViewController()
//            nav.pushViewController(leesonVC, animated: true)
        }
        
//        let text = NSString(string: item.data?.text ?? "")
//        var idx: Int = 0
//        let attr = NSMutableAttributedString(string: text as String, attributes: base)
//        for detail in item.data?.result?.details ?? [] {
//            let range: NSRange = text.range(of: detail.char ?? "", options: NSString.CompareOptions.literal, range: NSRange(location: idx, length: text.length - idx))
//            idx = range.location + range.length
////                guard let range = text.range(of: detail.char ?? "") else { return }
////                text.removeSubrange(range)
//            attr.addAttributes(detail.queryTextStyle(), range: range)

        return true
    }


}

class DemoTempViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let enterView = CorrectingEnterView()
        enterView.style = .edited
        view.addSubview(enterView)
        enterView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
