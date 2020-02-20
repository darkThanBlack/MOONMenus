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

//MARK: Switch

class MOONSegmentThemes {
    enum ThemeStyle {
        case xm_orange
    }
    var style = ThemeStyle.xm_orange {
        didSet {
            switch self.style {
            case .xm_orange:
                
                break
            }
        }
    }
    
    required init(style: ThemeStyle? = .xm_orange) {
        self.style = style ?? .xm_orange
    }
    
    var sliderColor: UIColor = UIColor.init(red: 255/255.0, green: 133/255.0, blue: 52/255.0, alpha: 1.0)
    var highLightTextColor = UIColor.white
    var normalTextColor = UIColor.init(red: 255/255.0, green: 133/255.0, blue: 52/255.0, alpha: 1.0)
    
    var radius: CGFloat = 3.0
    var borderWidth: CGFloat = 1.0
    var borderColor: UIColor = UIColor.init(red: 255/255.0, green: 133/255.0, blue: 52/255.0, alpha: 1.0)
}

class MOONSegment: UIView {
    
    private var theme = MOONSegmentThemes()
    
    required init(theme: MOONSegmentThemes? = MOONSegmentThemes()) {
        super.init(frame: .zero)
        self.theme = theme ?? MOONSegmentThemes()
        
        self.addSubview(slider)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var index_: Int = 0
    
    private var items: [UILabel] = []
    
    var titles: [String] = [] {
        didSet {
            for item in self.items {
                item.removeFromSuperview()
            }
            items.removeAll()
            for (index, title) in self.titles.enumerated() {
                let item = UILabel.init()
                item.numberOfLines = 1
                item.textAlignment = .center
                item.textColor = (index == 0) ? theme.highLightTextColor : theme.normalTextColor
                item.font = UIFont.systemFont(ofSize: 13.0)
                item.text = title
                
                item.tag = index
                item.isUserInteractionEnabled = true
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(itemDidSelected(gesture:)))
                singleTap.numberOfTapsRequired = 1
                singleTap.numberOfTouchesRequired = 1
                item.addGestureRecognizer(singleTap)
                
                items.append(item)
                
                self.addSubview(item)
            }
        }
    }
    
    private lazy var slider: UIView = {
        let slider = UIView(frame: .zero)
        slider.backgroundColor = self.theme.sliderColor
        return slider
    }()
    
    private var itemWidth: CGFloat = 0
    private var itemHeight :CGFloat = 0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        return CGSize(width: itemWidth * CGFloat(items.count), height: max(size.height, itemHeight))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = theme.radius
        
        self.layer.borderWidth = theme.borderWidth
        self.layer.borderColor = theme.borderColor.cgColor
        
        //求出单个最大宽高
        for item in items {
            item.sizeToFit()
            itemWidth = max(item.bounds.width, itemWidth)
            itemHeight = max(item.bounds.height, itemHeight)
        }
        //如果外部设置了更大的总宽高
        if (self.bounds.width > itemWidth * CGFloat(items.count)) {
            itemWidth = self.bounds.width / CGFloat(items.count)
        }
        if (self.bounds.height > itemHeight) {
            itemHeight = self.bounds.height
        }
        //保证不小于
        itemWidth = max(45.0, itemWidth)
        itemHeight = max(24.0, itemHeight)
        
        for (index, item) in items.enumerated() {
            item.frame = CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: itemHeight)
        }
        
        slider.frame = CGRect(x: itemWidth * CGFloat(index_), y: 0, width: itemWidth, height: itemHeight)
    }
    
    @objc private func itemDidSelected(gesture: UITapGestureRecognizer) {
        
        index_ = gesture.view?.tag ?? 0
        UIView.animate(withDuration: 0.2) {
            
            for (index, item) in self.items.enumerated() {
                item.textColor = (index == self.index_) ? self.theme.highLightTextColor : self.theme.normalTextColor
            }
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    
}
