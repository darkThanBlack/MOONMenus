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
        
        MOONMenu.core.start()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let nav = UINavigationController.init(rootViewController: DemoViewController.init())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func configAttrs(string: String?) -> NSAttributedString {
        let text = NSString(string: string ?? "")
        var idx: Int = 0
        let attr = NSMutableAttributedString(string: text as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)])
        
        let normal = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let green = [NSAttributedString.Key.font: UIColor.green]
        let red = [NSAttributedString.Key.font: UIColor.red]
        
        for index in 0..<4 {
            let range: NSRange = text.range(of: "moon", options: NSString.CompareOptions.literal, range: NSRange(location: idx, length: text.length - idx))
            idx = range.location + range.length
            if idx > text.length - 1 {
                break
            }
            //                guard let range = text.range(of: detail.char ?? "") else { return }
            //                text.removeSubrange(range)
            attr.addAttributes( (index % 2 == 0) ? green : red, range: range)
        }
        return attr
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
