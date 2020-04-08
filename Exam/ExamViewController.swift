//
//  ExamViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/2.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///答题记录/测评模块详情
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
    
    private func reloadDatas() {
        self.tableView.reloadData()
        self.collectionView.reloadData()
        
        self.pagesView.updateSelected(newIndex: viewInfo.queryLessonIndex())
        
        let canLeft = viewInfo.canUpdateNextIndex()
        let canRight = viewInfo.canUpdatePreviousIndex()
        if canLeft && canRight {
            self.stepView.configView(state: .middle)
        } else if canRight {
            self.stepView.configView(state: .first)
        } else if canLeft {
            self.stepView.configView(state: .last)
        } else {
            self.stepView.configView(state: .disable)
        }
    }
    
    private func loadRequestForExam() {
        viewInfo.loadMocks {
            self.pagesView.configView(titles: self.viewInfo.queryLessonTitles(), defIndex: 0)
            self.collectionView.reloadData()
            self.tableView.reloadData()
            self.stepView.configView(state: .first)
        }
    }
    
    //MARK: View
    
    private func loadNavigationsForExam() {
        
    }
    
    private func loadViewsForExam(box: UIView) {
        
        self.edgesForExtendedLayout = .bottom
        
        box.addSubview(pagesView)
        box.addSubview(tableView)
        box.addSubview(stepView)
        box.addSubview(collectionView)
        
        loadConstraintsForExam(box: box)
    }
    
    private func loadConstraintsForExam(box: UIView) {
        pagesView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(pagesView.snp.bottom).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
        }
        stepView.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
            make.height.equalTo(48.0)
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(pagesView.snp.bottom).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
        }
    }
    
    private lazy var pagesView: ExamPagesView = {
        let pagesView = ExamPagesView()
        pagesView.backgroundColor = .white
        pagesView.bindView(delegate: self)
        return pagesView
    }()
    
    private lazy var stepView: ExamStepView = {
        let stepView = ExamStepView()
        stepView.backgroundColor = .white
        stepView.bindView(delegate: self)
        stepView.configView(state: .disable)
        return stepView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = ExamHelper.background()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(ExamHeader.Option.self, forHeaderFooterViewReuseIdentifier: "ExamHeader.Option")
        tableView.register(ExamHeader.Answer.self, forHeaderFooterViewReuseIdentifier: "ExamHeader.Answer")
        tableView.register(ExamHeader.English.self, forHeaderFooterViewReuseIdentifier: "ExamHeader.English")
        tableView.register(ExamHeader.Explan.self, forHeaderFooterViewReuseIdentifier: "ExamHeader.Explan")
        
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
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 48.0)
        flowLayout.minimumLineSpacing = 12.0
        flowLayout.minimumInteritemSpacing = 12.0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.isHidden = true
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ExamNavigateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExamNavigateHeader")
        
        collectionView.register(ExamNavigateCell.Single.self, forCellWithReuseIdentifier: "ExamNavigateCell.Single")
        collectionView.register(ExamNavigateCell.Star.self, forCellWithReuseIdentifier: "ExamNavigateCell.Star")
        
        return collectionView
    }()
        
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
            return data.isOpened ? data.contents.count : 0
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
                    data.isOpened = !data.isOpened
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

extension ExamViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewInfo.updateIndex(newIndex: (indexPath.section, indexPath.row)) {
            self.pagesView.updateOpenState()
            reloadDatas()
        }
    }
}

extension ExamViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewInfo.lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExamNavigateHeader", for: indexPath) as! ExamNavigateHeader
            header.configView(dataSource: viewInfo.lessons[indexPath.section])
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewInfo.lessons[section].topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExamNavigateCell.Star", for: indexPath) as! ExamNavigateCell.Star
        cell.configCell(dataSource: viewInfo.lessons[indexPath.section].topics[indexPath.row])
        return cell
    }
}

extension ExamViewController: ExamPagesDelegate {
    func examPages(event: ExamPagesView.Event) {
        switch event {
        case .item(let index):
            if viewInfo.updateIndex(newIndex: (index, 0)) {
                reloadDatas()
            }
        case .arrow(let isOpened):
            collectionView.isHidden = !isOpened
        }
    }
}

extension ExamViewController: ExamStepViewDelegate {
    func examStepEvent(event: ExamStepView.Event) {
        switch event {
        case .previous:
            if viewInfo.updatePreviousIndex() {
                reloadDatas()
            }
        case .next:
            if viewInfo.updateNextIndex() {
                reloadDatas()
            }
        }
    }
}
