//
//  CorrectingStudentCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///CorrectingStudentCell 数据源
protocol CorrectingStudentCellDataSource {
    var avatar: String? { get }
    var name: String? { get }
    var detail: String? { get }
}

class CorrectingStudentCell: UITableViewCell {
    
    //MARK: Interface
    
    func configCell(dataSource: CorrectingStudentCellDataSource) {
        avatar.image = UIImage(named: dataSource.avatar ?? "")
        nameLabel.text = dataSource.name
        detailLabel.text = dataSource.detail
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForCorrcetingStudent(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForCorrcetingStudent(box: UIView) {
        box.addSubview(avatar)
        box.addSubview(nameLabel)
        box.addSubview(detailLabel)
        
        loadConstraintsForCorrcetingStudent(box: box)
    }
    
    private func loadConstraintsForCorrcetingStudent(box: UIView) {
        
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 20.0
        avatar.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(16.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-2.0)
            make.width.equalTo(40.0)
            make.height.equalTo(40.0)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatar.snp.top).offset(2.0)
            make.left.equalTo(avatar.snp.right).offset(10.0)
            make.right.lessThanOrEqualTo(box.snp.right).offset(-16.0)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(2.0)
            make.left.equalTo(nameLabel.snp.left).offset(0)
            make.right.lessThanOrEqualTo(box.snp.right).offset(-16.0)
        }
    }
    
    private lazy var avatar: UIImageView = {
        let avatar = UIImageView(image: UIImage(named: ""))
        avatar.backgroundColor = CorrectingHelper.grayText()
        return avatar
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        nameLabel.textColor = CorrectingHelper.blackText()
        nameLabel.text = " "
        return nameLabel
    }()
    
    private lazy var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        detailLabel.textColor = CorrectingHelper.lightGrayText()
        detailLabel.text = " "
        return detailLabel
    }()
    
}

