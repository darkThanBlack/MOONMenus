//
//  LessonSelectCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/16.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///LessonSelectCell 数据源
protocol LessonSelectCellDataSource {
    var title: String? { get }
}

class LessonSelectCell: UITableViewCell {
    
    //MARK: Interface
        
    func configCell(dataSource: LessonSelectCellDataSource) {
        titleLabel.text = dataSource.title ?? " "
    }

    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForLessonSelect(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForLessonSelect(box: UIView) {
        box.addSubview(titleLabel)
        box.addSubview(arrow)
        
        loadConstraintsForLessonSelect(box: box)
    }
    
    private func loadConstraintsForLessonSelect(box: UIView) {
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(11.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-12.0)
        }
        arrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(box.snp.centerY)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(16.0)
            make.right.equalTo(box.snp.right).offset(-16.0)
            make.width.equalTo(10.0)
            make.height.equalTo(10.0)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        titleLabel.textColor = LessonSelectHelper.grayText()
        titleLabel.text = " "
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var arrow: UIImageView = {
        let arrow = UIImageView(image: UIImage(named: ""))
        arrow.backgroundColor = .red
        return arrow
    }()
    
}
