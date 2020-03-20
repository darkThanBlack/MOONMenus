//
//  CorrectingImageCell.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///CorrectingImageCell 用户事件
protocol CorrectingImageCellDelegate: CorrectingCellDelegate {
    func correctImageEvent(cell: CorrectingImageCell, event: CorrectingImageCell.ImageEvents)
}

///CorrectingImageCell 数据源
protocol CorrectingImageCellDataSource: CorrectingCellDataSource {
    var image: String? { get }
}

class CorrectingImageCell: CorrectingCell {
    
    //MARK: Interface
    enum ImageEvents {
        case show
        case edit
    }
    
    private weak var delegate: CorrectingImageCellDelegate?
    func bindCell(delegate: CorrectingImageCellDelegate) {
        super.bindCell(delegate: delegate)
        self.delegate = delegate
    }
    
    func configCell(dataSource: CorrectingImageCellDataSource) {
        super.configCell(dataSource: dataSource)
        
        workImageView.image = UIImage(named: dataSource.image ?? "")
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForCorrectingImage(box: workView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    private func loadViewsForCorrectingImage(box: UIView) {
        box.addSubview(workImageView)
        box.addSubview(edit)
        
        loadConstraintsForCorrectingImage(box: box)
    }
    
    private func loadConstraintsForCorrectingImage(box: UIView) {
        workImageView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0).priority(.low)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
            make.height.equalTo(135.0)
        }
        edit.snp.makeConstraints { (make) in
            make.left.equalTo(box.snp.left).offset(8.0)
            make.bottom.equalTo(box.snp.bottom).offset(-8.0)
        }
        
        edit.layoutIfNeeded()
        edit.layer.masksToBounds = true
        edit.layer.cornerRadius = edit.bounds.height / 2.0
    }
    
    private lazy var workImageView: UIImageView = {
        let workImageView = UIImageView()
        workImageView.layer.masksToBounds = true
        workImageView.layer.cornerRadius = 5.0
        workImageView.contentMode = .scaleAspectFill
        
        workImageView.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(workImageViewEvent(gesture:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        workImageView.addGestureRecognizer(singleTap)
        
        return workImageView
    }()
    
    private lazy var edit: EditView = {
        let edit = EditView()
        
        edit.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(editEvent(gesture:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        edit.addGestureRecognizer(singleTap)
        
        return edit
    }()
    
    //MARK: Event
    
    @objc private func workImageViewEvent(gesture: UITapGestureRecognizer) {
        self.delegate?.correctImageEvent(cell: self, event: .show)
    }

    @objc private func editEvent(gesture: UITapGestureRecognizer) {
        self.delegate?.correctImageEvent(cell: self, event: .edit)
    }
    
    //MARK: - SubClass
    
    class EditView: UIView {
                
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            loadViewsForEdit(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
                
        private func loadViewsForEdit(box: UIView) {
            box.addSubview(hintImageView)
            box.addSubview(titleLabel)
            
            loadConstraintsForEdit(box: box)
        }
        
        private func loadConstraintsForEdit(box: UIView) {
            hintImageView.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(6)
                make.left.equalTo(box.snp.left).offset(8)
                make.bottom.equalTo(box.snp.bottom).offset(-6)
                make.width.equalTo(16.0)
                make.height.equalTo(16.0)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.left.equalTo(hintImageView.snp.right).offset(2.0)
                make.right.equalTo(box.snp.right).offset(-8.0)
            }
        }
        
        private lazy var hintImageView: UIImageView = {
            let hintImageView = UIImageView(image: UIImage(named: "moonShadow"))
            hintImageView.contentMode = .scaleAspectFill
            return hintImageView
        }()
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            titleLabel.textColor = CorrectingHelper.blackText()
            titleLabel.text = "圈划批改"
            titleLabel.textAlignment = .center
            return titleLabel
        }()
        
    }

}

