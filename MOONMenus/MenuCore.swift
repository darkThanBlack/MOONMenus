//
//  MOONMCore.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/2/15.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///Singleton
class MenuCore {
    static let core = MenuCore()
    private init() {}
    
    private lazy var rootVC: MenuRootController = {
        let rootVC = MenuRootController()
        return rootVC
    }()
    
    private lazy var window: Window = {
        let window = Window(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController.init(rootViewController: self.rootVC)
        window.noResponseView = self.rootVC.view
        return window
    }()
    
    func start() {
        window.isHidden = false
    }
}

class Window: UIWindow {
    
    var noResponseView: UIView? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.windowLevel = .alert
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return (view?.isEqual(noResponseView) ?? false) ? nil : view
    }
    
}


