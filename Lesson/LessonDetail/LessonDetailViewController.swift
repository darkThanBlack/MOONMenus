//
//  LessonDetailViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/16.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class LessonDetailViewController: UIViewController {
    
    //MARK: Interface
    
    var viewInfo = [LessonDetailModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewsForLessonDetail(box: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: View
    
    private func loadNavigationsForLessonDetail() {
        
    }
    
    private func loadViewsForLessonDetail(box: UIView) {
        box.addSubview(tableView)
        
        loadConstraintsForLessonDetail(box: box)
    }
    
    private func loadConstraintsForLessonDetail(box: UIView) {
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(LessonDetailCell.self, forCellReuseIdentifier: "LessonDetailCell")
        return tableView
    }()
    
    //MARK: Data
    
    //MARK: Event
    
}

extension LessonDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension LessonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonDetailCell") as? LessonDetailCell
        cell?.configCell(dataSource: viewInfo[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
}
