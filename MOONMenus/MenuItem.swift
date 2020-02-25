//
//  MenuItem.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/2/24.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class MenuItem: UIView {
    
    var config: ItemConfigs = ItemConfigs()
    
    required init(config: ItemConfigs) {
        super.init(frame: .zero)
        
        self.config = config
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MOONStyleItem: MenuItem {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        
        return titleLabel
    }()
    
    required init(config: ItemConfigs) {
        super.init(config: config)
        
        loadConfigs()
        loadViewsForMOONStyleItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadConfigs() {
        imageView.image = config.image
        titleLabel.text = config.title
    }
    
    func loadViewsForMOONStyleItem() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: self.bounds.width, height: self.bounds.width))
        
        let size = titleLabel.sizeThatFits(self.bounds.size)
        titleLabel.frame = CGRect(origin: CGPoint(x: 0, y: self.bounds.height - size.height), size: size)
    }
}
