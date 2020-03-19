//
//  CorrectingViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class CorrectingViewController: UIViewController {
    
    //MARK: Interface
    
    var viewInfo = CorrectingViewModel()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewsForCorrecting(box: view)
        
        loadRequestForCorrecting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Data
    
    private func loadRequestForCorrecting() {
        viewInfo.loadRequestForCorrecting { (success) in
            self.tableView.reloadData()
        }
    }
    
    //MARK: View
    
    private func loadNavigationsForCorrecting() {
        
    }
    
    private func loadViewsForCorrecting(box: UIView) {
        box.addSubview(tableView)
        
        loadConstraintsForCorrecting(box: box)
    }
    
    private func loadConstraintsForCorrecting(box: UIView) {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = CorrectingHelper.background()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(CorrectingStudentCell.self, forCellReuseIdentifier: "CorrectingStudentCell")
        tableView.register(CorrectingTextCell.self, forCellReuseIdentifier: "CorrectingTextCell")
        tableView.register(CorrectingVoiceCell.self, forCellReuseIdentifier: "CorrectingVoiceCell")
        tableView.register(CorrectingImageCell.self, forCellReuseIdentifier: "CorrectingImageCell")
        tableView.register(CorrectingVideoCell.self, forCellReuseIdentifier: "CorrectingVideoCell")

        return tableView
    }()
    
    //MARK: Event
        
    //MARK: - SubClass
    
}

extension CorrectingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension CorrectingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewInfo.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInfo = viewInfo.cells[indexPath.row]
        switch cellInfo.style {
        case .student:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectingStudentCell") as? CorrectingStudentCell
            cell?.configCell(dataSource: viewInfo.cells[indexPath.row] as! CorrectingStudentModel)
            return cell ?? UITableViewCell()
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectingTextCell") as? CorrectingTextCell
            cell?.configCell(dataSource: viewInfo.cells[indexPath.row] as! CorrectingTextCellModel)
            return cell ?? UITableViewCell()
        case .voice:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectingVoiceCell") as? CorrectingVoiceCell
            cell?.configCell(dataSource: viewInfo.cells[indexPath.row] as! CorrectingVoiceCellModel)
            return cell ?? UITableViewCell()
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectingImageCell") as? CorrectingVoiceCell
            cell?.configCell(dataSource: viewInfo.cells[indexPath.row] as! CorrectingImageCellModel)
            return cell ?? UITableViewCell()
        case .video:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectingVideoCell") as? CorrectingVoiceCell
            cell?.configCell(dataSource: viewInfo.cells[indexPath.row] as! CorrectingVideoCellModel)
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
