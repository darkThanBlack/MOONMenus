//
//  LessonDetailCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/16.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///LessonDetailCell 数据源
protocol LessonDetailCellDataSource {
    var imageName: String? { get }
    var title: String? { get }
    var detail: String? { get }
    var tag: String? { get }
}

class LessonDetailCell: UITableViewCell {
        
    //MARK: Interface
        
    func configCell(dataSource: LessonDetailCellDataSource) {
        fileImageView.image = UIImage(named: dataSource.imageName ?? "")
        titleLabel.text = dataSource.title ?? " "
        detailLabel.text = dataSource.detail ?? " "
        tagLabel.isHidden = (dataSource.tag == nil) ? true : false
        tagLabel.text = dataSource.tag
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForLessonDetail(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForLessonDetail(box: UIView) {
        box.addSubview(fileImageView)
        box.addSubview(titleLabel)
        box.addSubview(detailLabel)
        box.addSubview(tagLabel)
        
        loadConstraintsForLessonDetail(box: box)
    }
    
    private func loadConstraintsForLessonDetail(box: UIView) {
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        fileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(12)
            make.left.equalTo(box.snp.left).offset(20)
            make.bottom.equalTo(box.snp.bottom).offset(-12).priority(.low)
            make.width.equalTo(36.0)
            make.height.equalTo(44.0)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fileImageView.snp.top).offset(3.0)
            make.left.equalTo(fileImageView.snp.right).offset(16.0)
        }
        tagLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(8.0)
            make.right.equalTo(box.snp.right).offset(-30.0)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(2.0)
            make.left.equalTo(titleLabel.snp.left).offset(0)
            make.right.lessThanOrEqualTo(box.snp.right).offset(-30.0)
        }
    }
    
    private lazy var fileImageView: UIImageView = {
        let fileImageView = UIImageView(image: UIImage(named: ""))
        fileImageView.backgroundColor = .blue
        return fileImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        titleLabel.textColor = LessonHelper.grayText()
        titleLabel.text = " "
        return titleLabel
    }()
    
    private lazy var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        detailLabel.textColor = LessonHelper.lightGrayText()
        detailLabel.text = " "
        return detailLabel
    }()
    
    private lazy var tagLabel: EdgeLabel = {
        let tagLabel = EdgeLabel()
        tagLabel.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        tagLabel.textColor = LessonHelper.grayText()
        tagLabel.text = " "
        
        tagLabel.insets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        tagLabel.layer.borderWidth = 0.5
        tagLabel.layer.borderColor = LessonHelper.grayLayer().cgColor
        tagLabel.layer.masksToBounds = true
        tagLabel.layer.cornerRadius = 2.0
        
        return tagLabel
    }()
    
    //MARK: - SubClass
    
    class EdgeLabel: UILabel {
        var insets: UIEdgeInsets = .zero {
            didSet {
                sizeToFit()
            }
        }
        
        //https://www.jianshu.com/p/5bffffdd7b45
        override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
            var rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
            
            rect.origin.x    -= insets.left;
            rect.origin.y    -= insets.top;
            rect.size.width  += (insets.left + insets.right);
            rect.size.height += (insets.top + insets.bottom);
            
            return rect
        }
        
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: insets))
        }
    }
    
}

