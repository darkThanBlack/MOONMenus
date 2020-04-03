//
//  DemoViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/2.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

//MARK: - header

class TJSignUpIncomeHeader: UITableViewHeaderFooterView {
    
    var price: String? {
        didSet {
            self.priceLabel.text = self.price ?? " "
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        loadViews(box: self.contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadViews(box: UIView) {
        box.addSubview(bgView)
        box.addSubview(hintLabel)
        box.addSubview(priceLabel)
        box.addSubview(sepLine)
        
        loadConstraints(box: box)
    }
    
    private func loadConstraints(box: UIView) {
        hintLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        hintLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box)
            make.left.equalTo(box).offset(16.0)
            make.height.equalTo(50.0)
            make.bottom.equalTo(box.snp.bottom).offset(0).priority(.low)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(hintLabel.snp_centerY)
            make.left.equalTo(hintLabel.snp_right).offset(0)
            make.right.lessThanOrEqualTo(box.snp_right).offset(-16)
        }
        sepLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    private lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    private lazy var hintLabel: UILabel = {
        let hintLabel = UILabel()
        hintLabel.font = UIFont.systemFont(ofSize: 15.0)
        hintLabel.textColor = .lightGray
        hintLabel.text = "应收："
        return hintLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.systemFont(ofSize: 17.0)
        priceLabel.textColor = .gray
        priceLabel.numberOfLines = 1
        priceLabel.text = ""
        return priceLabel
    }()
    
    private lazy var sepLine: UIView = {
        let sepLine = UIView()
        sepLine.backgroundColor = .separator
        return sepLine
    }()
}

//MARK: - cell

class TJSignUpIncomeGradientView: UIView {
    override func draw(_ rect: CGRect) {
        let gradinent = CAGradientLayer()
        gradinent.colors = [UIColor.white.cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)]
        gradinent.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradinent.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradinent.frame = self.bounds
        self.layer.mask = gradinent
    }
}

class TJSignUpIncomeArrow: UIView {
    private let themeColor = UIColor(red: 255/255.0, green: 133/255.0, blue: 52/255.0, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        themeColor.setStroke()
        let content = UIGraphicsGetCurrentContext()
        content?.setLineWidth(1.0)
        content?.move(to: .zero)
        content?.addLine(to: CGPoint(x: bounds.width / 2.0, y: bounds.height))
        content?.addLine(to: CGPoint(x: bounds.width, y: 0))
        content?.strokePath()
    }
}

class TJSignUpIncomeButton: UIView {
    ///0展开，1收起
    var data: (style: Int, title: String?) = (0, "") {
        didSet {
            if data.style == 0 {
                titleLabel.text = self.data.title
                self.arrow.transform = .identity
            } else {
                titleLabel.text = "收起"
                self.arrow.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }
        }
    }
    
    private let titleColor = UIColor(red: 255/255.0, green: 133/255.0, blue: 52/255.0, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(boxView)
        boxView.addSubview(titleLabel)
        boxView.addSubview(arrow)
        
        boxView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        arrow.snp.makeConstraints { (make) in
            make.height.equalTo(6)
            make.width.equalTo(10)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.left.equalTo(titleLabel.snp.right).offset(9)
            make.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var boxView: UIView = {
        let boxView = UIView()
        boxView.backgroundColor = .clear
        return boxView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 13.0)
        titleLabel.textColor = self.titleColor
        return titleLabel
    }()
    
    private lazy var arrow: TJSignUpIncomeArrow = {
        let arrow = TJSignUpIncomeArrow()
        arrow.backgroundColor = .clear
        return arrow
    }()
}

class TJSignUpIncomeButtonView: UIView {
    
    private let buttonColor = UIColor(red: 255/255.0, green: 133/255.0, blue: 52/255.0, alpha: 0.1)
    ///0展开，1收起
    var data: (style: Int, title: String?) = (0, "") {
        didSet {
            self.moreButton.data = self.data
            if self.data.style == 0 {
                self.moreButton.snp.remakeConstraints { (make) in
                    make.top.equalTo(self.snp.top).offset(8)
                    make.left.equalTo(self.snp.left).offset(11)
                    make.right.equalTo(self.snp.right).offset(-11).priority(.low)
                    make.bottom.equalTo(self.snp.bottom).offset(-8).priority(.low)
                    make.height.equalTo(26)
                }
            } else {
                self.moreButton.snp.remakeConstraints { (make) in
                    make.top.equalTo(self.snp.top).offset(5)
                    make.left.equalTo(self.snp.left).offset(11)
                    make.right.equalTo(self.snp.right).offset(-11).priority(.low)
                    make.bottom.equalTo(self.snp.bottom).offset(-8).priority(.low)
                    make.height.equalTo(26)
                }
            }
        }
    }
    
    private lazy var moreButton: TJSignUpIncomeButton = {
        let moreButton = TJSignUpIncomeButton()
        moreButton.backgroundColor = self.buttonColor
        return moreButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(moreButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        moreButton.layer.masksToBounds = true
        moreButton.layer.cornerRadius = moreButton.bounds.height / 2.0
    }
    
}

protocol TJSignUpIncomeCellDelegate: class {
    func extraButtonAction()
}

protocol TJSignUpIncomeCellDataSource {
    var title: String? { get }
    var detail: String? { get }
    var price: String? { get }
    var buttonTitle: String? { get }
    var style: Int { get }
}

class TJSignUpIncomeCell: UITableViewCell {
    
    private weak var delegate: TJSignUpIncomeCellDelegate?
    
    func configCell(delegate: TJSignUpIncomeCellDelegate) {
        self.delegate = delegate
    }
    
    func configCell(dataSource: TJSignUpIncomeCellDataSource) {
        titleLabel.text = dataSource.title
        detailLabel.text = dataSource.detail
        priceLabel.text = dataSource.price
        buttonView.data = ((dataSource.style == 2) ? 1 : 0, dataSource.buttonTitle)
        
        if dataSource.style == 0 {
            cellView.snp.remakeConstraints { (make) in
                make.top.left.right.bottom.equalToSuperview()
            }
            gradientView.isHidden = true
            buttonView.isHidden = true
        } else if dataSource.style == 1 {
            cellView.snp.remakeConstraints { (make) in
                make.top.left.right.equalToSuperview()
            }
            gradientView.isHidden = false
            buttonView.isHidden = false
            gradientView.snp.remakeConstraints { (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(50.0)
            }
            buttonView.snp.remakeConstraints { (make) in
                make.top.equalTo(gradientView.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
            gradientView.setNeedsDisplay()
        } else {
            cellView.snp.remakeConstraints { (make) in
                make.top.left.right.equalToSuperview()
            }
            gradientView.isHidden = true
            buttonView.isHidden = false
            buttonView.snp.remakeConstraints { (make) in
                make.top.equalTo(cellView.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cellView: UIView = {
        let cellView = UIView()
        cellView.backgroundColor = .white
        return cellView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.font = UIFont.systemFont(ofSize: 15.0)
        titleLabel.textColor = .gray
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    lazy var detailLabel: UILabel = {
        let detailLabel = UILabel(frame: .zero)
        detailLabel.font = UIFont.systemFont(ofSize: 13.0)
        detailLabel.textColor = .lightGray
        detailLabel.numberOfLines = 1
        return detailLabel
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel(frame: .zero)
        priceLabel.font = UIFont.systemFont(ofSize: 15.0)
        priceLabel.textColor = .gray
        priceLabel.numberOfLines = 1
        return priceLabel
    }()
    
    private lazy var gradientView: TJSignUpIncomeGradientView = {
        let gradient = TJSignUpIncomeGradientView()
        gradient.backgroundColor = .white
        return gradient
    }()
    
    private lazy var buttonView: TJSignUpIncomeButtonView = {
        let buttonView = TJSignUpIncomeButtonView()
        buttonView.backgroundColor = .white
        
        buttonView.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(expandButtonEvent))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        buttonView.addGestureRecognizer(singleTap)
        
        return buttonView
    }()
    
    private func loadViews() {
        contentView.addSubview(cellView)
        loadViewsForCell(box: cellView)
        
        contentView.addSubview(gradientView)
        
        contentView.addSubview(buttonView)
    }
    
    private func loadViewsForCell(box: UIView) {
        self.selectionStyle = .none
        
        box.addSubview(titleLabel)
        box.addSubview(detailLabel)
        box.addSubview(priceLabel)
                
        loadConstraintsForCell(box: box)
    }
    
    func loadConstraintsForCell(box: UIView) {
        
        detailLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp_top).offset(12.0)
            make.left.equalTo(box.snp_left).offset(16.0)
            make.right.equalTo(box.snp_right).offset(-16.0)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(7.0)
            make.left.equalTo(box.snp_left).offset(16.0)
            make.bottom.equalTo(box.snp_bottom).offset(-12.0)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(detailLabel.snp_centerY)
            make.left.greaterThanOrEqualTo(detailLabel.snp_right).offset(12.0)
            make.right.equalTo(box.snp_right).offset(-16.0)
        }
    }
    
    @objc func expandButtonEvent() {
        if self.delegate != nil {
            self.delegate?.extraButtonAction()
        }
    }
}

extension TJSignUpIncomeCell {
    ///卡片式 Cell
    func cornerCard(radio: CGFloat, indexPath: IndexPath) {
        func checkCellIndexPath(indexPath: IndexPath) -> UIRectCorner? {
            //拿到Cell的TableView
            var view: UIView? = superview
            while view != nil && !(view is UITableView) {
                view = view!.superview
            }
            guard let tableView = view as? UITableView else {return nil}
            if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                // 1.只有一行
                return .allCorners
            } else if indexPath.row == 0 {
                // 2.每组第一行
                return [.topLeft, .topRight]
            } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                // 3.每组最后一行
                return [.bottomLeft, .bottomRight]
            } else {
                return nil
            }
        }
        
        let corner = checkCellIndexPath(indexPath: indexPath)
        let contentBounds = CGRect(origin: CGPoint(x: 10, y: 0), size: CGSize(width: bounds.width - 20, height: bounds.height))
        let layer = CAShapeLayer()
        layer.bounds = contentBounds
        layer.position = CGPoint(x: contentBounds.midX ,y: contentBounds.midY)
        layer.path = UIBezierPath(roundedRect: contentBounds, byRoundingCorners: corner ?? [], cornerRadii: CGSize(width: radio, height: radio)).cgPath
        self.layer.mask = layer
    }
}

//MARK: - VC

class TJSignUpIncomeCellModel: TJSignUpIncomeCellDataSource {
    
    var title: String?
    var detail: String?
    var price: String?
    var buttonTitle: String?
    var style: Int = 0

}

class SignUpIncomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var needExpand = true
    
    private var cellArray = [TJSignUpIncomeCellModel]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TJSignUpIncomeHeader.self, forHeaderFooterViewReuseIdentifier: "TJSignUpIncomeHeader")
        tableView.register(TJSignUpIncomeCell.self, forCellReuseIdentifier: "TJSignUpIncomeCell")
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loadMockDatas()
            self.tableView.reloadData()
        }
        
    }
    
    private func loadMockDatas() {
        self.cellArray.removeAll()
        let datas = [0, 1, 2, 3, 4, 5]
        for (index, _) in datas.enumerated() {
            let cellInfo = TJSignUpIncomeCellModel()
            cellInfo.title = "完成课后练习第五单元第3小节完成课后练习第五单元" + ((index % 2) == 1 ? "完成课后练习第五单元第3小节完成课后练习第五单元第3小节" : "")
            cellInfo.detail = "购买24个月；赠送4个月"
            cellInfo.price = "￥1200"
            cellInfo.buttonTitle = ""
            if self.needExpand {
                if index == 3 {
                    cellInfo.style = 1
                    cellInfo.buttonTitle = "展开\(datas.count)项"
                    self.cellArray.append(cellInfo)
                    break
                }
            } else {
                if index == (datas.count - 1) {
                    cellInfo.style = 2
                    cellInfo.buttonTitle = "收起"
                }
            }
            self.cellArray.append(cellInfo)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.title = "Menus Demo"
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: TJSignUpIncomeHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TJSignUpIncomeHeader") as! TJSignUpIncomeHeader
        header.price = "2345.67"
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let newCell = cell as! TJSignUpIncomeCell
//        newCell.cornerCard(radio: 20, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TJSignUpIncomeCell") as! TJSignUpIncomeCell
        cell.configCell(delegate: self)
        cell.configCell(dataSource: cellArray[indexPath.row])
        return cell
    }
    
}

extension SignUpIncomeViewController: TJSignUpIncomeCellDelegate {
    func extraButtonAction() {
        self.needExpand = !self.needExpand
        self.loadMockDatas()
        
        self.tableView.reloadSections(IndexSet([0]), with: .fade)
    }
}


