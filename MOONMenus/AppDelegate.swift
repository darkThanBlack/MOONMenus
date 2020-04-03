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
