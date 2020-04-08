//
//  ExamHistoryViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/8.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class ExamHistoryViewModel {
    
    class History: ExamHistoryCellDataSource {
        var title: String?
        var star: Int64 = 0
        var times: String?
    }
    
    var cells: [History] = []
    
    func loadMocks(complete: (() -> Void)?) {
        cells.removeAll()
        for index in 0...3 {
            let cellInfo = History()
            cellInfo.title = "今天 18:00"
            cellInfo.star = 3
            cellInfo.times = "用时：10分20秒"
            cells.append(cellInfo)
        }
    }
}

class ExamHistoryViewController: UIViewController {
    
    //MARK: Interface
    
    private var viewInfo = ExamHistoryViewModel()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewsForExamHistory(box: view)
        
        loadRequestForExamHistory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Data
    
    private func loadRequestForExamHistory() {
        viewInfo.loadMocks {
            self.tableView.reloadData()
        }
    }
    
    //MARK: View
    
    private func loadNavigationsForExamHistory() {
        
    }
    
    private func loadViewsForExamHistory(box: UIView) {
        
        loadConstraintsForExamHistory(box: box)
    }
    
    private func loadConstraintsForExamHistory(box: UIView) {
        
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = ExamHelper.background()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ExamHistoryCell.self, forCellReuseIdentifier: "ExamHistoryCell")
        return tableView
    }()
    
    
}

extension ExamHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ExamHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewInfo.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExamHistoryCell")  as! ExamHistoryCell
        cell.configCell(dataSource: viewInfo.cells[indexPath.row])
        return cell
    }
}
