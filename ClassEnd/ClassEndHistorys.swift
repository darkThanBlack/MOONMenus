//
//  ClassEndHistoryAlertController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/5/4.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///Cell 数据源
fileprivate protocol ClassEndHistoryCellDataSource {
    var time: String? { get }
    var teacher: String? { get }
}

///结课记录
class ClassEndHistory {
    
    class ViewModel {
        
        struct CellInfo: ClassEndHistoryCellDataSource {
            var time: String?
            var teacher: String?
        }
        var cells: [CellInfo] = []
        
        func loadMocks(complete: (() -> Void)?) {
            
            let data1 = CellInfo(time: "结课时间：2019-09-10 10:26", teacher: "操作人：吴老师")
            cells.append(data1)
            
            let data2 = CellInfo(time: "结课时间：2019-09-10 09:14", teacher: "操作人：吴老师")
            cells.append(data2)
            
            complete?()
        }
    }
    
    @objc(ClassEndHistoryAlertController)
    class AlertController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        //MARK: Interface
        
        private let viewInfo = ViewModel()
        
        //MARK: Life Cycle
        
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            
            modalTransitionStyle = .crossDissolve
            modalPresentationStyle = .overCurrentContext
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            view = UIView(frame: .zero)
            view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loadViewsForAlert(box: view)
            
            viewInfo.loadMocks {
                self.tableView.reloadData()
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
        }
        
        //MARK: Data
        
        private func loadRequestForAlert() {
            
        }
        
        //MARK: View
        
        override func viewDidLayoutSubviews() {
            self.tableHeader.sizeToFit()
            tableView.tableHeaderView = self.tableHeader
        }
        
        private func loadViewsForAlert(box: UIView) {
            box.addSubview(header)
            box.addSubview(tableView)
            
            loadConstraintsForAlert(box: box)
        }
        
        private func loadConstraintsForAlert(box: UIView) {
            header.snp.makeConstraints { (make) in
                make.left.equalTo(box.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-0)
                make.height.equalTo(44.0)
            }
            tableView.snp.makeConstraints { (make) in
                make.top.equalTo(header.snp.bottom).offset(0)
                make.left.equalTo(box.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-0)
                make.bottom.equalTo(box.snp.bottom).offset(-0)
                make.height.equalTo(348.0)
            }
        }
        
        private lazy var header: Header = {
            let header = Header()
            header.backgroundColor = .white
            header.bindEvent {
                self.dismiss(animated: true, completion: nil)
            }
            return header
        }()
        
        private lazy var tableHeader: TableHeader = {
            let tableHeader = TableHeader()
            return tableHeader
        }()
        
        private lazy var tableView: UITableView = {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.backgroundColor = .white
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(Cell.self, forCellReuseIdentifier: "ClassEndHistory.Cell")
            return tableView
        }()
        
        //MARK: UITableView
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //do nth.
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewInfo.cells.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClassEndHistory.Cell", for: indexPath) as? ClassEndHistory.Cell
            if indexPath.row < viewInfo.cells.count {
                cell?.configCell(dataSource: viewInfo.cells[indexPath.row])
            }
            return cell ?? UITableViewCell()
        }
    }
    
    
    @objc(ClassEndHistoryHeader)
    class Header: UIView {
        
        //MARK: Interface
        
        private var close: (() -> Void)?
        func bindEvent(close: (() -> Void)?) {
            self.close = close
        }
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForHeader(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private var shape = CAShapeLayer()
        override func draw(_ rect: CGRect) {
            shape.removeFromSuperlayer()
            
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
            shape.path = path.cgPath
            layer.mask = shape
        }
        
        private func loadViewsForHeader(box: UIView) {
            box.addSubview(titleLabel)
            box.addSubview(closeButton)
            box.addSubview(singleLine)
            
            loadConstraintsForHeader(box: box)
        }
        
        private func loadConstraintsForHeader(box: UIView) {
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.left.equalTo(box.snp.left).offset(16.0)
            }
            closeButton.snp.makeConstraints { (make) in
                make.centerY.equalTo(box.snp.centerY)
                make.right.equalTo(box.snp.right).offset(-16.0)
                make.width.equalTo(30.0)
                make.height.equalTo(30.0)
            }
            singleLine.snp.makeConstraints { (make) in
                make.left.equalTo(box.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-0)
                make.bottom.equalTo(box.snp.bottom).offset(-0)
                make.height.equalTo(0.5)
            }
        }
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
            titleLabel.textColor = ClassEndHelper.blackText()
            titleLabel.text = "结课记录"
            return titleLabel
        }()
        
        private lazy var closeButton: UIButton = {
            let closeButton = UIButton(type: .custom)
            closeButton.setImage(UIImage(named: "moonShadow"), for: .normal)
            closeButton.addTarget(self, action: #selector(closeButtonEvent), for: .touchUpInside)
            return closeButton
        }()
        
        private lazy var singleLine: UIView = {
            let singleLine = UIView()
            singleLine.backgroundColor = ClassEndHelper.singleLine()
            return singleLine
        }()
        
        //MARK: Event
        
        @objc private func closeButtonEvent() {
            self.close?()
        }
        
    }
    
    
    @objc(ClassEndHistoryTableHeader)
    class TableHeader: UIView {
        
        //MARK: Interface
        
        //MARK: Life Cycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            loadViewsForTableHeader(box: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForTableHeader(box: UIView) {
            box.addSubview(titleLabel)
        }
        
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            let labelSize = titleLabel.sizeThatFits(CGSize(width: size.width - 32.0, height: size.height - 24.0))
            return CGSize(width: labelSize.width + 32.0, height: labelSize.height + 24.0)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            let labelSize = titleLabel.sizeThatFits(CGSize(width: self.bounds.width - 32.0, height: self.bounds.height - 24.0))
            titleLabel.frame = CGRect(x: 16.0, y: 12.0, width: labelSize.width, height: labelSize.height)
        }
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            titleLabel.textColor = ClassEndHelper.lightGrayText()
            titleLabel.text = "“已结课”的课程进行续费或转课后会变为“正常上课”状态，再次结课后就会增加1条结课记录。"
            titleLabel.numberOfLines = 0
            return titleLabel
        }()
        
    }
    
    @objc(ClassEndHistoryCell)
    class Cell: UITableViewCell {
        
        //MARK: Interface
        
        fileprivate func configCell(dataSource: ClassEndHistoryCellDataSource) {
            timeLabel.text = dataSource.time
            teacherLabel.text = dataSource.teacher
        }
        
        //MARK: Life Cycle
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.selectionStyle = .none
            
            loadViewsForCell(box: contentView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForCell(box: UIView) {
            box.addSubview(circle)
            box.addSubview(line)
            box.addSubview(timeLabel)
            box.addSubview(teacherLabel)
            
            loadConstraintsForCell(box: box)
        }
        
        private func loadConstraintsForCell(box: UIView) {
            
            line.setContentHuggingPriority(.defaultHigh, for: .vertical)
            line.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            
            timeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            
            circle.layer.cornerRadius = 4.0
            circle.layer.masksToBounds = true
            circle.snp.makeConstraints { (make) in
                make.centerY.equalTo(timeLabel.snp.centerY)
                make.left.equalTo(box.snp.left).offset(16.0)
                make.width.equalTo(8.0)
                make.height.equalTo(8.0)
            }
            
            line.snp.makeConstraints { (make) in
                make.centerX.equalTo(circle.snp.centerX)
                make.top.equalTo(circle.snp.bottom).offset(4.0)
                make.bottom.equalTo(box.snp.bottom).offset(-0)
                make.width.equalTo(2.0)
            }
            
            timeLabel.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(0)
                make.left.equalTo(circle.snp.right).offset(8.0)
                make.right.equalTo(box.snp.right).offset(-16.0)
            }
            
            teacherLabel.snp.makeConstraints { (make) in
                make.top.equalTo(timeLabel.snp.bottom).offset(0)
                make.left.equalTo(timeLabel.snp.left).offset(0)
                make.right.equalTo(box.snp.right).offset(-16.0)
                make.bottom.equalTo(box.snp.bottom).offset(-16.0)
            }
            
        }
        
        private lazy var circle: UIView = {
            let circle = UIView()
            circle.backgroundColor = ClassEndHelper.grayLayer()
            return circle
        }()
        
        private lazy var line: UIView = {
            let line = UIView()
            line.backgroundColor = ClassEndHelper.grayLayer()
            return line
        }()
        
        private lazy var timeLabel: UILabel = {
            let timeLabel = UILabel()
            timeLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            timeLabel.textColor = ClassEndHelper.blackText()
            timeLabel.text = " "
            return timeLabel
        }()
        
        private lazy var teacherLabel: UILabel = {
            let teacherLabel = UILabel()
            teacherLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            teacherLabel.textColor = ClassEndHelper.blackText()
            teacherLabel.text = " "
            return teacherLabel
        }()
        
        
    }
    
    
}

