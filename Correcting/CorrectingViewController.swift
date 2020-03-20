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
            cell?.bindCell(delegate: self)
            cell?.configCell(dataSource: viewInfo.cells[indexPath.row] as! CorrectingTextCellModel)
            return cell ?? UITableViewCell()
        case .voice:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectingVoiceCell") as? CorrectingVoiceCell
            cell?.bindCell(delegate: self)
            cell?.configCell(dataSource: viewInfo.cells[indexPath.row] as! CorrectingVoiceCellModel)
            return cell ?? UITableViewCell()
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectingImageCell") as? CorrectingImageCell
            cell?.bindCell(delegate: self)
            cell?.configCell(dataSource: viewInfo.cells[indexPath.row] as! CorrectingImageCellModel)
            return cell ?? UITableViewCell()
        case .video:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectingVideoCell") as? CorrectingVideoCell
            cell?.bindCell(delegate: self)
            cell?.configCell(dataSource: viewInfo.cells[indexPath.row] as! CorrectingVideoCellModel)
            return cell ?? UITableViewCell()
        }
    }
}

extension CorrectingViewController: CorrectingCellDelegate {
    func correctAddEvent(cell: CorrectingCell) {
        let indexPath = tableView.indexPath(for: cell)
        let index = indexPath?.row ?? -1
        if (index < 0) || (index >= viewInfo.cells.count) { return }
        let corrects = viewInfo.cells[index].corrects
        
        let selectVC = AddCorrectAlertController()
        selectVC.correctSelected { (style) in
            switch style {
            case .voice:
                corrects.voices.append(.init(vid: "00X"))
            case .text:
                corrects.review.isEditing = true
                if corrects.review.text.count == 0 {
                    corrects.review.text = "张三为保证公司项目进度，根据领导指示要求李四留宿公司进行开发，后李四在开发过程中因心梗死亡，请问张三可能构成什么罪？\nA.过失致人死亡罪\nB.强迫劳动罪的间接正犯\nC.诈骗罪\nD.故意损坏财物罪"
                } else {
                    print("MOON__log 文字点评最多添加一条")
                }
            }
            self.tableView.reloadRows(at: [indexPath!], with: .fade)
        }
        self.present(selectVC, animated: true, completion: nil)
    }
    
    func correctEditEvent(cell: CorrectingCell, event: CorrectingCell.Events, object: CorrectingCell.EventsObject, context: [String : Any]?) {
        let indexPath = tableView.indexPath(for: cell)
        let index = indexPath?.row ?? -1
        if (index < 0) || (index >= viewInfo.cells.count) { return }
        let corrects = viewInfo.cells[index].corrects
        
        switch object {
        case .voice:
            switch event {
            case .delete:
                let idx = context?["index"] as? Int ?? -1
                if (idx < 0) || (idx >= corrects.voices.count) { return }
                corrects.voices.remove(at: idx)
            case .update:
                break
            }
        case .text:
            switch event {
            case .delete:
                corrects.review.isEditing = false
                corrects.review.text = ""
                break
            case .update:
                let text = context?["text"] as? String
                corrects.review.text = text ?? ""
                break
            }
        }
        tableView.reloadRows(at: [indexPath!], with: .fade)
    }
}

extension CorrectingViewController: CorrectingImageCellDelegate {
    func correctImageEvent(cell: CorrectingImageCell, event: CorrectingImageCell.ImageEvents) {
        switch event {
        case .show:
            print("MOON_log 展示图片浏览器...")
        case .edit:
            print("MOON_log 批改图片...")
        }
    }
}
