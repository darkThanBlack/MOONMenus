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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = ExamHelper.background()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(ExamHeader.Option.self, forHeaderFooterViewReuseIdentifier: "ExamHeader.Option")
        tableView.register(ExamHeader.Answer.self, forHeaderFooterViewReuseIdentifier: "ExamHeader.Answer")
        tableView.register(ExamHeader.English.self, forHeaderFooterViewReuseIdentifier: "ExamHeader.English")
        
        tableView.register(ExamCell.Text.self, forCellReuseIdentifier: "ExamCell.Text")
        tableView.register(ExamCell.Voice.self, forCellReuseIdentifier: "ExamCell.Voice")
        tableView.register(ExamCell.Image.self, forCellReuseIdentifier: "ExamCell.Image")

        tableView.register(ExamOptionCell.Text.self, forCellReuseIdentifier: "ExamOptionCell.Text")
        tableView.register(ExamOptionCell.Voice.self, forCellReuseIdentifier: "ExamOptionCell.Voice")
        tableView.register(ExamOptionCell.Image.self, forCellReuseIdentifier: "ExamOptionCell.Image")
        
        tableView.register(ExamAnswerCell.self, forCellReuseIdentifier: "ExamAnswerCell")
        tableView.register(ExamEnglishCell.self, forCellReuseIdentifier: "ExamEnglishCell")
        
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewInfo.cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = viewInfo.cells[section]
        switch sectionInfo.sectionStyle {
        case .question:
            let data = sectionInfo as! ExamViewModel.Section.Question
            return data.contents.count
        case .option:
            let data = sectionInfo as! ExamViewModel.Section.Option
            return data.contents.count
        case .answer:
            let data = sectionInfo as! ExamViewModel.Section.Answer
            return data.contents.count
        case .english:
            let data = sectionInfo as! ExamViewModel.Section.English
            return data.contents.count
        case .explan:
            let data = sectionInfo as! ExamViewModel.Section.Explan
            return data.contents.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionInfo = viewInfo.cells[section]
        switch sectionInfo.sectionStyle {
        case .question:
            return nil
        case .option:
            let data = sectionInfo as! ExamViewModel.Section.Option
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExamHeader.Option") as! ExamHeader.Option
            header.title = data.isMulti ? "多选题" : "单选题"
            return header
        case .answer:
            let data = sectionInfo as! ExamViewModel.Section.Answer
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExamHeader.Answer") as! ExamHeader.Answer
            return header
        case .english:
            let data = sectionInfo as! ExamViewModel.Section.English
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExamHeader.English") as! ExamHeader.English
            return header
        case .explan:
            let data = sectionInfo as! ExamViewModel.Section.Explan
            if data.isOpened {
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExamHeader.Option") as! ExamHeader.Option
                header.title = "解析"
                return header
            } else {
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExamHeader.Explan") as! ExamHeader.Explan
                header.bindEvent {
                    self.tableView.reloadSections(IndexSet(integer: section), with: .none)
                }
                return header
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionInfo = viewInfo.cells[indexPath.section]
        switch sectionInfo.sectionStyle {
        case .question, .explan:
            let data = sectionInfo as! ExamViewModel.Section.Question
            let cellInfo = data.contents[indexPath.row]
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
        case .option:
            let data = sectionInfo as! ExamViewModel.Section.Option
            let cellInfo = data.contents[indexPath.row]
            switch cellInfo.style {
            case .image:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExamOptionCell.Image") as! ExamOptionCell.Image
                cell.configCell(dataSource: cellInfo as! ExamOptionCellImageDataSource)
                return cell
            case .voice:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExamOptionCell.Voice") as! ExamOptionCell.Voice
                cell.configCell(dataSource: cellInfo as! ExamOptionCellVoiceDataSource)
                return cell
            case .text:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExamOptionCell.Text") as! ExamOptionCell.Text
                cell.configCell(dataSource: cellInfo as! ExamOptionCellTextDataSource)
                return cell
            }
        case .answer:
            let data = sectionInfo as! ExamViewModel.Section.Answer
            let cellInfo = data.contents[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExamAnswerCell") as! ExamAnswerCell
            cell.configCell(dataSource: cellInfo)
            return cell
        case .english:
            let data = sectionInfo as! ExamViewModel.Section.English
            let cellInfo = data.contents[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExamEnglishCell") as! ExamEnglishCell
            cell.configCell(dataSource: cellInfo)
            return cell
        }
    }
}

