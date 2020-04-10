//
//  MakeHomeworkAlertController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/10.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///布置单次作业 - 选择作业类型
class MakeHomeworkAlertController: UIViewController {
    
    //MARK: Interface
    
    private var complete: (() -> Void)?
    func bindEvent(complete: (() -> Void)?) {
        self.complete = complete
    }
    
    //MARK: Life Cycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewsForMakeHomework(box: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func loadView() {
        view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
    }
    
    //MARK: View
        
    private func loadViewsForMakeHomework(box: UIView) {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12.0
        
        box.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.centerY.equalTo(box.snp.centerY).offset(-54.0)
            make.left.equalTo(box.snp.left).offset(25.0)
            make.right.equalTo(box.snp.right).offset(-25.0)
        }
        box.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(box.snp.centerX)
            make.top.equalTo(contentView.snp.bottom).offset(32.0)
            make.width.equalTo(22.0)
            make.height.equalTo(22.0)
        }
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(tableView)
        contentView.addSubview(nextButton)
        
        loadConstraintsForMakeHomeworkContent(box: contentView)
    }
    
    private func loadConstraintsForMakeHomeworkContent(box: UIView) {
        
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 22.0
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(box.snp.centerX)
            make.top.equalTo(box.snp.top).offset(24.0)
        }
        subTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(box.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(14.0)
            make.left.equalTo(box.snp.left).offset(12.0)
            make.right.equalTo(box.snp.right).offset(-12.0)
            make.height.equalTo(200.0)
        }
        nextButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(box.snp.centerX)
            make.top.equalTo(tableView.snp.bottom).offset(9.0)
            make.bottom.equalTo(box.snp.bottom).offset(-24.0)
            make.width.equalTo(180.0)
            make.height.equalTo(44.0)
        }
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        titleLabel.textColor = ExamHelper.blackText()
        titleLabel.text = "选择作业类型"
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        subTitleLabel.textColor = ExamHelper.lightGrayText()
        subTitleLabel.text = "请选择本次布置的单次作业类型"
        subTitleLabel.textAlignment = .center
        return subTitleLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MakeHomeworkAlertCell.self, forCellReuseIdentifier: "MakeHomeworkAlertCell")
        return tableView
    }()
    
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton(type: .custom)
        nextButton.backgroundColor = ExamHelper.heavyOrange()
        nextButton.setTitle("去布置", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .highlighted)
        nextButton.addTarget(self, action: #selector(nextButtonEvent), for: .touchUpInside)
        return nextButton
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.backgroundColor = .clear
        closeButton.setImage(UIImage(named: "moonShadow"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonEvent), for: .touchUpInside)
        return closeButton
    }()
        
    @objc private func nextButtonEvent() {
        self.complete?()
    }
    
    @objc private func closeButtonEvent() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension MakeHomeworkAlertController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MakeHomeworkAlertController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MakeHomeworkAlertCell") as! MakeHomeworkAlertCell
        cell.configCell(style: indexPath.row == 0 ? .normal : .exam)
        return cell
    }
}

//MARK: -

class MakeHomeworkAlertCell: UITableViewCell {
    
    //MARK: Interface
    
    fileprivate enum Style {
        case normal
        case exam
    }
        
    fileprivate func configCell(style: Style) {
                
        switch style {
        case .normal:
            boxView.layer.borderColor = ExamHelper.heavyOrange().cgColor
            boxView.layer.borderWidth = 2.0
            
            hintImageView.image = UIImage(named: "")
            titleLabel.text = "普通作业"
            tagsLabel.text = ""
            detailLabel.text = "适用机构：素质拓展类机构\n支持老师适用文字、图片、视频、语音布置单次课后作业。"
            masksView.isHidden = true
            
        case .exam:
            boxView.layer.borderColor = ExamHelper.border().cgColor
            boxView.layer.borderWidth = 1.0
            
            hintImageView.image = UIImage(named: "")
            titleLabel.text = "测评作业"
            tagsLabel.text = "请使用电脑端布置"
            detailLabel.text = "适用机构：英语类机构\n支持老师布置课后练习题/英语口语测评，学生提交后系统自动阅卷。"
            masksView.isHidden = false
        }
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.contentView.addSubview(boxView)
        boxView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(6.0)
            make.left.equalTo(contentView.snp.left).offset(0)
            make.right.equalTo(contentView.snp.right).offset(-0)
            make.bottom.equalTo(contentView.snp.bottom).offset(-6.0).priority(.low)
        }
        
        loadViewsForMakeHomeworkAlert(box: boxView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //MARK: View
    
    private func loadViewsForMakeHomeworkAlert(box: UIView) {
        box.addSubview(hintImageView)
        box.addSubview(titleLabel)
        box.addSubview(tagsLabel)
        box.addSubview(detailLabel)
        box.addSubview(masksView)
        
        loadConstraintsForMakeHomeworkAlert(box: box)
    }
    
    private func loadConstraintsForMakeHomeworkAlert(box: UIView) {
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        detailLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        hintImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(box.snp.centerY)
            make.left.equalTo(box.snp.left).offset(14.0)
            make.width.equalTo(60.0)
            make.height.equalTo(60.0)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(12.0)
            make.left.equalTo(hintImageView.snp.right).offset(14.0)
        }
        tagsLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.left.equalTo(titleLabel.snp.right).offset(8.0)
            make.right.lessThanOrEqualTo(box.snp.right).offset(-16.0)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.left.equalTo(titleLabel.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-8.0)
            make.bottom.equalTo(box.snp.bottom).offset(-12.0)
        }
        masksView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
        }
    }
    
    private lazy var boxView: UIView = {
        let boxView = UIView()
        boxView.backgroundColor = .white
        boxView.layer.masksToBounds = true
        boxView.layer.cornerRadius = 5.0
        return boxView
    }()
    
    private lazy var hintImageView: UIImageView = {
        let hintImageView = UIImageView()
        hintImageView.clipsToBounds = true
        hintImageView.contentMode = .scaleAspectFill
        return hintImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        titleLabel.textColor = ExamHelper.blackText()
        titleLabel.text = " "
        return titleLabel
    }()

    private lazy var tagsLabel: UILabel = {
        let tagsLabel = UILabel()
        tagsLabel.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        tagsLabel.textColor = ExamHelper.heavyOrange()
        tagsLabel.text = "请使用电脑端布置"
        return tagsLabel
    }()

    private lazy var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        detailLabel.textColor = ExamHelper.grayText()
        detailLabel.text = " "
        detailLabel.numberOfLines = 0
        return detailLabel
    }()
    
    private lazy var masksView: UIView = {
        let masksView = UIView()
        masksView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return masksView
    }()
    
    private lazy var close: UIImageView = {
        let close = UIImageView(image: UIImage(named: "moonShadow"))
        close.clipsToBounds = true
        close.contentMode = .scaleAspectFill
        return close
    }()

}
