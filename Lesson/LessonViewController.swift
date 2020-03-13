//
//  LessonViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/13.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {
    
    //MARK: Interface
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loadViewsForLesson()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: View
    
    private func loadNavigationsForLesson() {
        
    }
    
    private func loadViewsForLesson() {
        view.addSubview(basicView)
        
        loadConstraintsForLesson()
    }
    
    private func loadConstraintsForLesson() {
        basicView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private lazy var basicView: LessonView = {
        let basicView = LessonView()
        basicView.backgroundColor = .white
        return basicView
    }()

    
    //MARK: Data
    
    //MARK: Event
    
}

