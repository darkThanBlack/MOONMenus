//
//  MenuRootController.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/2/16.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class MenuRootController: UIViewController {

    private lazy var closeView: UIView = {
        let closeView = UIView.init()
        closeView.backgroundColor = .clear
        closeView.isHidden = true
        
        closeView.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(updateMunuEvent))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        closeView.addGestureRecognizer(singleTap)
        
        return closeView
    }()
    
    private lazy var basicMenu: BasicMenuView = {
        let basicMenu = BasicMenuView.init(customConfig: nil)
        basicMenu.backgroundColor = .systemPink
        
        basicMenu.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(updateMunuEvent))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        basicMenu.addGestureRecognizer(singleTap)

        return basicMenu
    }()
    
    private lazy var subMenu: SubMenuView = {
        let subMenu = SubMenuView.init(frame: .zero)
        
        subMenu.layer.cornerRadius = 18.0
        subMenu.layer.masksToBounds = true
        
        return subMenu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(closeView)
        view.addSubview(basicMenu)
        
        basicMenu.configSubMenu(menu: subMenu)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        closeView.frame = view.bounds
    }
    
    //MARK: Event
    
    @objc private func updateMunuEvent() {
        basicMenu.updateMenuState { (state) in
            self.closeView.isHidden = (state == .isClose) ? true : false
        }
    }
}
