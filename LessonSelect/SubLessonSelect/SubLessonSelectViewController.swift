//
//  SubLessonSelectViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/17.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class SubLessonSelectViewController: UIViewController {
    
    //MARK: Interface
    
    var viewInfo = LessonSelectViewModel()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewsForSubLessonSelect(box: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Data
    
    private func loadRequestForSubLessonSelect() {
        viewInfo.loadRequestForLessonSelect { (success) in
            self.tableView.reloadData()
        }
        
    }
    
    //MARK: View
    
    private func loadNavigationsForSubLessonSelect() {
        
    }
    
    private func loadViewsForSubLessonSelect(box: UIView) {
        box.addSubview(tableView)
        
        loadConstraintsForSubLessonSelect(box: box)
    }
    
    private func loadConstraintsForSubLessonSelect(box: UIView) {
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(box)
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = LessonSelectHelper.background()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(SubLessonSelectCell.self, forCellReuseIdentifier: "SubLessonSelectCell")
        return tableView
    }()
        
    //MARK: Event
    
    //MARK: - SubClass
    
}

extension SubLessonSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SubLessonSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(origin: .zero, size: CGSize(width: 200.0, height: 34.0))
        titleLabel.font = UIFont.systemFont(ofSize: 13.0)
        titleLabel.textColor = LessonSelectHelper.lightGrayText()
        titleLabel.text = "备课本"
        return titleLabel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewInfo.lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubLessonSelectCell") as? SubLessonSelectCell
        
        return cell ?? UITableViewCell()
    }
}
