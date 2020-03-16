//
//  SubSubLessonViewController.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/3/15.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class SubLessonHeaderView: UIView {
    
    //MARK: Interface
    
    var title: String? = " " {
        didSet {
            titleLabel.text = title
        }
    }
    
    var time: String? = "" {
        didSet {
            authorView.time = time
        }
    }
    
    var author: String? = "" {
        didSet {
            authorView.author = author
        }
    }
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewsForSubLessonHeader(box: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
//    override var intrinsicContentSize: CGSize {
//        get {
//            return CGSize(width: bounds.width, height: bounds.width * 184.0 / 375.0)
//        }
//    }
//
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        return CGSize(width: size.width, height: size.width * 184.0 / 375.0)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        bgView.frame = bounds
//
//        let size = titleLabel.sizeThatFits(CGSize(width: bounds.width - 40.0, height: bounds.height))
//        titleLabel.frame = CGRect(x: 20.0, y: 74.0, width: size.width, height: size.height)
//
//        authorView.frame = CGRect(x: 20.0, y: titleLabel.frame.maxY + 20.0, width: bounds.width - 40.0, height: 20.0)
//    }
    
    private func loadViewsForSubLessonHeader(box: UIView) {
        box.addSubview(bgView)
        box.addSubview(titleLabel)
        box.addSubview(authorView)
        
        loadConstraintsForSubLessonHeader(box: box)
    }
    
    private func loadConstraintsForSubLessonHeader(box: UIView) {
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(box)
        }
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(74.0)
            make.left.equalTo(box.snp.left).offset(20.0)
            make.right.equalTo(box.snp.right).offset(-20.0)
        }
        authorView.snp_makeConstraints { (make) in
            make.left.equalTo(box.snp.left).offset(20.0)
            make.bottom.equalTo(box.snp.bottom).offset(-20.0)
            make.right.lessThanOrEqualTo(box.snp.right).offset(-20.0).priority(.low)
        }
    }
    
    private lazy var bgView: UIImageView = {
        let bgView = UIImageView(image: UIImage(named: ""))
        bgView.backgroundColor = LessonHelper.orange()
        return bgView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 19.0, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.text = " "
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private lazy var authorView: LessonAuthorView = {
        let authorView = LessonAuthorView(theme: .white)
        return authorView
    }()
        
}


class SubLessonViewController: UIViewController {
    
    //MARK: Interface
    
    var viewInfo = [SubLessonModel]() {
        didSet {
            header.title = "少儿英语启蒙少儿英语启蒙少儿英语启蒙少儿英语启蒙"
            header.time = NSDate.now.description
            header.author = "是新新是新新是新新是新新是新新是新新"
                        
            tableView.reloadData()
        }
    }
    
    //MARK: Property
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loadViewsForSubLesson()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: View
    
    override func viewDidLayoutSubviews() {
        reloadTableViewHeaders()
    }
    
    private func reloadTableViewHeaders() {
        header.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: view.bounds.width * 184.0 / 375.0))
        tableView.tableHeaderView = header
    }
    
    private func loadNavigationsForSubLesson() {
        
    }
    
    private func loadViewsForSubLesson() {
        view.addSubview(tableView)
        
        loadConstraintsForSubLesson()
    }
    
    private func loadConstraintsForSubLesson() {
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private lazy var header: SubLessonHeaderView = {
        let header = SubLessonHeaderView()
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(SubLessonCell.self, forCellReuseIdentifier: "SubLessonCell")
        return tableView
    }()
    
    //MARK: Data
    
    private func loadRequestForSubLesson() {
        
    }
    
    //MARK: Event
    
}

extension SubLessonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = LessonDetailViewController()
        detailVC.viewInfo = viewInfo[indexPath.row].details
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SubLessonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubLessonCell") as? SubLessonCell
        cell?.configCell(dataSource: viewInfo[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    
}
