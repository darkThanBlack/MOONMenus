//
//  DemoViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/2.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
    
    //MARK: Interface
    
    //    private let menus = ["SignUpIncome", "Correcting", "SubLesson"]
    
    private let menus: [MenuModel] = [.init(name: "SignUpIncomeViewController"),
                                      .init(name: "CorrectingViewController"),
                                      .init(name: "CorrectHistoryAlertController",
                                            navigationStyle: .present),
                                      .init(name: "LessonViewController"),
                                      .init(name: "ExamViewController"),
                                      .init(name: "OrgT")
    ]
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewsForDemo(box: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Data
    
    private func loadRequestForDemo() {
        
    }
    
    //MARK: View
    
    private func loadNavigationsForDemo() {
        
    }
    
    private func loadViewsForDemo(box: UIView) {
        box.addSubview(tableView)
        loadConstraintsForDemo(box: box)
    }
    
    private func loadConstraintsForDemo(box: UIView) {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.top).offset(0)
            make.left.equalTo(box.snp.left).offset(0)
            make.right.equalTo(box.snp.right).offset(-0)
            make.bottom.equalTo(box.snp.bottom).offset(-0)
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        return tableView
    }()
    
    //MARK: Event
    
    //MARK: - SubClass
    
    private class MenuModel {
        var name: String
        
        enum NavigationStyle {
            case push
            case present
            case none
        }
        var navigationStyle: NavigationStyle
        
        required init(name: String, navigationStyle: NavigationStyle? = .push) {
            self.name = name
            self.navigationStyle = navigationStyle ?? .push
        }
    }
    
    private class MenuCell: UITableViewCell {
        
        //MARK: Interface
        
        var cellInfo: MenuModel? {
            didSet {
                self.titleLabel.text = cellInfo?.name
            }
        }
        
        //MARK: Life Cycle
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.selectionStyle = .none
            loadViewsForMenu(box: contentView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: View
        
        private func loadViewsForMenu(box: UIView) {
            box.addSubview(titleLabel)
            loadConstraintsForMenu(box: box)
        }
        
        private func loadConstraintsForMenu(box: UIView) {
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(box.snp.top).offset(0)
                make.left.equalTo(box.snp.left).offset(16.0)
                make.right.equalTo(box.snp.right).offset(-16.0)
                make.bottom.equalTo(box.snp.bottom).offset(-0).priority(.low)
                make.height.equalTo(44.0)
            }
        }
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            titleLabel.textColor = .black
            titleLabel.text = " "
            titleLabel.numberOfLines = 0
            return titleLabel
        }()
    }
    
    
}

extension DemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellInfo = menus[indexPath.row]
        
        let projName = Bundle.main.infoDictionary?[kCFBundleExecutableKey as String]
        let vcName = "\(cellInfo.name)"
        let subVC = (NSClassFromString("\(projName ?? "").\(vcName)") as! UIViewController.Type).init()
        
        switch cellInfo.navigationStyle {
        case .push:
            self.navigationController?.pushViewController(subVC, animated: true)
        case .present:
            self.present(subVC, animated: true, completion: nil)
        case .none:
            break
        }
        
    }
}

extension DemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        cell.cellInfo = menus[indexPath.row]
        return cell
    }
}
