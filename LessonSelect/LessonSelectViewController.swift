//
//  LessonSelectViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/16.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class LessonSelectViewController: UIViewController {
    
    //MARK: Interface
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewsForLessonSelect(box: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: View
    
    private func loadNavigationsForLessonSelect() {
        
    }
    
    private func loadViewsForLessonSelect(box: UIView) {
        
        loadConstraintsForLessonSelect(box: box)
    }
    
    private func loadConstraintsForLessonSelect(box: UIView) {
        
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(LessonSelectCell.self, forCellReuseIdentifier: "LessonSelectCell")
        return tableView
    }()
    
    //MARK: Data
    
    //MARK: Event
    
    //MARK: - SubClass
    
}

extension LessonSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension LessonSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonSelectCell") as? LessonSelectCell
        
        return cell ?? UITableViewCell()
    }
}


