//
//  ExamViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/2.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController {
    
    //MARK: Interface
    
    let viewInfo = ExamViewModel()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewsForExam(box: view)
        
        loadRequestForExam()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Data
    
    private func loadRequestForExam() {
        viewInfo.loadMocks {
            self.tableView.reloadData()
        }
    }
    
    //MARK: View
    
    private func loadNavigationsForExam() {
        
    }
    
    private func loadViewsForExam(box: UIView) {
        box.addSubview(tableView)
        loadConstraintsForExam(box: box)
    }
    
    private func loadConstraintsForExam(box: UIView) {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = ExamHelper.background()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(ExamHeader.Option.self, forHeaderFooterViewReuseIdentifier: "ExamHeader.Option")
        tableView.register(ExamHeader.Answer.self, forHeaderFooterViewReuseIdentifier: "ExamHeader.Answer")
        tableView.register(ExamHeader.English.self, forHeaderFooterViewReuseIdentifier: "xamHeader.English")
        
        tableView.register(ExamCell.Text.self, forCellReuseIdentifier: "ExamCell.Text")
        tableView.register(ExamCell.Voice.self, forCellReuseIdentifier: "ExamCell.Voice")
        tableView.register(ExamCell.Image.self, forCellReuseIdentifier: "ExamCell.Image")

        tableView.register(ExamOptionCell.Text.self, forCellReuseIdentifier: "ExamOptionCell.TextCell")
        tableView.register(ExamOptionCell.Voice.self, forCellReuseIdentifier: "ExamOptionCell.VoiceCell")
        tableView.register(ExamOptionCell.Image.self, forCellReuseIdentifier: "ExamOptionCell.ImageCell")
        
        return tableView
    }()
    
    //MARK: Event
    
    //MARK: - SubClass
    
}

extension ExamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ExamViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var number: Int = 0
        number += viewInfo.questions.count > 0 ? 1 : 0
        number += viewInfo.options.count > 0 ? 1 : 0
        number += viewInfo.correctAnswer != nil ? 1 : 0
        number += viewInfo.english != nil ? 1 : 0
        number += viewInfo.explans.count > 0 ? 1 : 0
        
        return number
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewInfo.questions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExamHeader.Option")
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInfo = viewInfo.questions[indexPath.row]
        switch cellInfo.style {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExamCell.Image") as! ExamCell.Image
            cell.configCell(dataSource: cellInfo as! ExamCellImageDataSource)
            return cell
        case .voice:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExamCell.Voice") as! ExamCell.Voice
            cell.configCell(dataSource: cellInfo as! ExamCellVoiceDataSource)
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExamCell.Text") as! ExamCell.Text
            cell.configCell(dataSource: cellInfo as! ExamCellTextDataSource)
            return cell
        }
        return UITableViewCell()
    }
}

