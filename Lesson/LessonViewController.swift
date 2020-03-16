//
//  LessonViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/13.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {
    
    //MARK: Interface
    
    //MARK: Property
    
    private var viewInfo = LessonViewModel()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loadViewsForLesson()
        
        loadRequestForLesson()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: View
    
    private func loadNavigationsForLesson() {
        
    }
    
    private func loadViewsForLesson() {
        view.addSubview(tableView)
        
        loadConstraintsForLesson()
    }
    
    private func loadConstraintsForLesson() {
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(LessonCell.self, forCellReuseIdentifier: "LessonCell")
        return tableView
    }()
    
    //MARK: Data
    
    private func loadRequestForLesson() {
        viewInfo.loadRequestForLesson { (success) in
            self.tableView.reloadData()
        }
    }
    
    //MARK: Event
    
}

extension LessonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subVC = SubLessonViewController()
        subVC.viewInfo = viewInfo.lessons[indexPath.row].subLessons
        self.navigationController?.pushViewController(subVC, animated: true)
    }
}

extension LessonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewInfo.lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell") as? LessonCell
        cell?.configCell(dataSource: viewInfo.lessons[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    
}

