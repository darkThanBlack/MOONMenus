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
        
        return true
    }


}

class DemoViewController: UIViewController {
    
    private lazy var testLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "test"
        label.backgroundColor = .yellow
        return label
    }()
    
    private lazy var segment: MOONSegment = {
        let segment = MOONSegment()
//        segment.backgroundColor = .yellow
        segment.titles = ["日", "周", "每月", "每季度", "每年"]
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(testLabel)
        view.addSubview(segment)
        segment.snp.makeConstraints { (make) in
            make.center.equalToSuperview()            
        }
        testLabel.snp.makeConstraints { (make) in
            make.left.equalTo(segment.snp_right)
            make.centerY.equalTo(segment.snp_centerY)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.segment.titles = ["日", "周"]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.segment.snp.remakeConstraints { (make) in
                    make.centerY.equalToSuperview()
                    make.left.equalToSuperview()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.title = "Menus Demo"
    }
    
    override func viewDidLayoutSubviews() {
//        segment.sizeToFit()
//        segment.center = view.center
    }
}


