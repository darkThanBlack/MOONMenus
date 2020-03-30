//
//  CorrectHistoryAlertController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/26.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///CorrectHistoryCell 用户事件
protocol CorrectHistoryCellDelegate: class {
    func correctHistoryEvent(cell: CorrectHistoryCell)
}

///CorrectHistoryCell 数据源
protocol CorrectHistoryCellDataSource {
    var title: String? { get }
    var name: String? { get }
    var isNewest: Bool { get }
}

class CorrectHistoryCell: UITableViewCell {
    
    //MARK: Interface
    
    private weak var delegate: CorrectHistoryCellDelegate?
    func bindCell(delegate: CorrectHistoryCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: CorrectHistoryCellDataSource) {
        titleLabel.text = dataSource.title
        nameLabel.text = dataSource.name
        tagLabel.isHidden = !dataSource.isNewest
    }
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        loadViewsForCorrectHistory(box: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForCorrectHistory(box: UIView) {
        box.addSubview(titleLabel)
        box.addSubview(nameLabel)
        box.addSubview(tagLabel)
        box.addSubview(arrowBox)
        arrowBox.addSubview(hintLabel)
        arrowBox.addSubview(arrow)
        
        loadConstraintsForCorrectHistory(box: box)
    }
    
    private func loadConstraintsForCorrectHistory(box: UIView) {
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        tagLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        arrowBox.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(12.0)
            make.left.equalTo(box.snp.left).offset(16.0)
        }
        tagLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.left.equalTo(titleLabel.snp.right).offset(4.0)
            make.right.lessThanOrEqualTo(arrowBox.snp.left).offset(-8.0)
            make.width.equalTo(38.0)
            make.height.equalTo(16.0)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.left.equalTo(titleLabel.snp.left).offset(0)
            make.right.lessThanOrEqualTo(arrowBox.snp.left).offset(-4.0)
            make.bottom.equalTo(box.snp.bottom).offset(-0).priority(.low)
        }
        
        arrowBox.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
        }
        
        loadConstraintsForArrowBox(box: arrowBox)
    }
    
    private func loadConstraintsForArrowBox(box: UIView) {
        arrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(box.snp.centerY)
            make.right.equalTo(box.snp.right).offset(-16.0)
            make.width.equalTo(10.0)
            make.height.equalTo(10.0)
        }
        hintLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(arrow.snp.centerY)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(arrow.snp.left).offset(-10)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        titleLabel.textColor = CorrectingHelper.grayText()
        titleLabel.text = " "
        return titleLabel
    }()
    
    private lazy var tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        tagLabel.textColor = CorrectingHelper.orange()
        tagLabel.text = "最新"
        tagLabel.textAlignment = .center
        tagLabel.isHidden = true
        
        tagLabel.layer.borderColor = CorrectingHelper.orange().cgColor
        tagLabel.layer.borderWidth = 1.0
        tagLabel.layer.masksToBounds = true
        tagLabel.layer.cornerRadius = 2.0
        
        return tagLabel
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        nameLabel.textColor = CorrectingHelper.lightGrayText()
        nameLabel.text = " "
        return nameLabel
    }()
    
    private lazy var arrowBox: UIView = {
        let arrowBox = UIView()
        
        arrowBox.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(arrowBoxEvent(gesture:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        arrowBox.addGestureRecognizer(singleTap)
        
        return arrowBox
    }()

    private lazy var hintLabel: UILabel = {
        let hintLabel = UILabel()
        hintLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        hintLabel.textColor = CorrectingHelper.orange()
        hintLabel.text = "查看"
        return hintLabel
    }()

    private lazy var arrow: UIImageView = {
        let arrow = UIImageView(image: UIImage(named: "moonShadow"))
        return arrow
    }()
    
    //MARK: Event
    
    @objc private func arrowBoxEvent(gesture: UITapGestureRecognizer) {
        self.delegate?.correctHistoryEvent(cell: self)
    }

}

//MARK: -

class CorrectHistoryHeader: UIView {
    
    //MARK: Interface
    
    private var close: (() -> Void)?
    func bindEvent(close: (() -> Void)?) {
        self.close = close
    }
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewsForCorrectHistoryHeader(box: self)
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
    
    private func loadViewsForCorrectHistoryHeader(box: UIView) {
        box.addSubview(titleBox)
        titleBox.addSubview(titleLabel)
        titleBox.addSubview(closeButton)
        
        box.addSubview(hintLabel)
        
        loadConstraintsForCorrectHistoryHeader(box: box)
    }
    
    private func loadConstraintsForCorrectHistoryHeader(box: UIView) {
        titleBox.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
        }
        hintLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleBox.snp.bottom).offset(10.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.right.equalTo(box.snp.right).offset(-16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-10.0)
        }
        
        loadConstraintsForTitleBox(box: titleBox)
    }
    
    private func loadConstraintsForTitleBox(box: UIView) {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(11.0)
            make.left.equalTo(box.snp.left).offset(16.0)
            make.bottom.equalTo(box.snp.bottom).offset(-12.0)
        }
        closeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(box.snp.centerY)
            make.right.equalTo(box.snp.right).offset(-16.0)
            make.width.equalTo(30.0)
            make.height.equalTo(30.0)
        }
    }
    
    private lazy var titleBox: UIView = {
        let titleBox = UIView()
        titleBox.backgroundColor = .white
                
        return titleBox
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        titleLabel.textColor = CorrectingHelper.blackText()
        titleLabel.text = "批改记录"
        return titleLabel
    }()

    private lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "moonShadow"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonEvent), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var hintLabel: UILabel = {
        let hintLabel = UILabel()
        hintLabel.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        hintLabel.textColor = CorrectingHelper.lightGrayText()
        hintLabel.text = "此作业存在多条批改记录，请选择需要查看的批改记录。"
        return hintLabel
    }()
    
    //MARK: Event
    
    @objc private func closeButtonEvent() {
        close?()
    }
}

//MARK: -

class CorrectHistoryViewModel {
    class CellModel: CorrectHistoryCellDataSource {
        var title: String?
        var name: String?
        var isNewest: Bool = false
    }
    var cells: [CellModel] = []
    
    func mocks(complete: (() -> Void)?) {
        
        cells.removeAll()
        for index in 0...3 {
            let cellInfo = CellModel()
            cellInfo.title = "标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题"
            cellInfo.name = "名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称"
            cellInfo.isNewest = index == 0 ? true : false
            cells.append(cellInfo)
        }
        
        complete?()
    }
}

class CorrectHistoryAlertController: UIViewController {
    
    //MARK: Interface
    
    var viewInfo = CorrectHistoryViewModel()
    
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
        
        loadViewsForCorrectHistory(box: view)
        
        viewInfo.mocks {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
        
    //MARK: View
        
    private func loadViewsForCorrectHistory(box: UIView) {
        box.addSubview(header)
        box.addSubview(tableView)
        
        loadConstraintsForCorrectHistory(box: box)
    }
    
    private func loadConstraintsForCorrectHistory(box: UIView) {
        header.snp.makeConstraints { (make) in
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(tableView.snp.top).offset(0)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
            make.height.equalTo(272.0)
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CorrectHistoryCell.self, forCellReuseIdentifier: "CorrectHistoryCell")
        return tableView
    }()
    
    private lazy var header: CorrectHistoryHeader = {
        let header = CorrectHistoryHeader()
        header.backgroundColor = .white
        header.bindEvent {
            self.dismiss(animated: true, completion: nil)
        }
        return header
    }()
    
    //MARK: Event
    
    //MARK: - SubClass
    
}

extension CorrectHistoryAlertController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension CorrectHistoryAlertController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewInfo.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectHistoryCell") as? CorrectHistoryCell
        
        cell?.bindCell(delegate: self)
        cell?.configCell(dataSource: viewInfo.cells[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
}

extension CorrectHistoryAlertController: CorrectHistoryCellDelegate {
    
    func correctHistoryEvent(cell: CorrectHistoryCell) {
        let indexPath = tableView.indexPath(for: cell)
        let index = indexPath?.row ?? -1
        if (index < 0) || (index >= viewInfo.cells.count) { return }
        
        //MOON__TODO: show correct detail...
    }
}

