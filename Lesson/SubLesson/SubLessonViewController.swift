//
//  SubSubLessonViewController.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/3/15.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class SubLessonViewController: UIViewController {
    
    //MARK: Interface
    
    var viewInfo = LessonModel()
    
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
    
    private func loadNavigationsForSubLesson() {
        
    }
    
    private func loadViewsForSubLesson() {
        view.addSubview(basicView)
        
        loadConstraintsForSubLesson()
    }
    
    private func loadConstraintsForSubLesson() {
        basicView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private lazy var basicView: LessonView = {
        let basicView = LessonView()
        basicView.backgroundColor = .white
        return basicView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(LessonCell.self, forCellReuseIdentifier: "LessonCell")
        return tableView
    }()
    
    //MARK: Data
    
    private func loadRequestForSubLesson() {
        
    }
    
    //MARK: Event
    
}

extension SubLessonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension SubLessonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell") as? LessonCell

        return cell ?? UITableViewCell()
    }
    
    
}
