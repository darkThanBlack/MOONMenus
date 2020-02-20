//
//  AppDelegate.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/2/15.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

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
    
    private lazy var segment: MOONSegment = {
        let segment = MOONSegment()
//        segment.backgroundColor = .yellow
        segment.titles = ["日", "周", "每月"]
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(segment)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.title = "Menus Demo"
    }
    
    override func viewDidLayoutSubviews() {
        segment.sizeToFit()
        segment.center = view.center
    }
}


