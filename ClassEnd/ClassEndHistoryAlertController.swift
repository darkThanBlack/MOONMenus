//
//  ClassEndHistoryAlertController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/5/4.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class ClassEndHistoryAlertController: UIViewController {
    
    //MARK: Interface
    
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
        
        loadViewsForClassEndHistoryAlert(box: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Data
    
    private func loadRequestForClassEndHistoryAlert() {
        
    }
    
    //MARK: View
    
    private func loadNavigationsForClassEndHistoryAlert() {
        
    }
    
    private func loadViewsForClassEndHistoryAlert(box: UIView) {
        
        loadConstraintsForClassEndHistoryAlert(box: box)
    }
    
    private func loadConstraintsForClassEndHistoryAlert(box: UIView) {
        
    }
    
    //MARK: Event
    
}

