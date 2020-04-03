//
//  ExamPageViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/2.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class ExamPageViewController: UIViewController {
    
    //MARK: Interface
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewsForExamPage(box: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Data
    
    private func loadRequestForExamPage() {
        
    }
    
    //MARK: View
    
    private func loadNavigationsForExamPage() {
        
    }
    
    private func loadViewsForExamPage(box: UIView) {
        
        loadConstraintsForExamPage(box: box)
    }
    
    private func loadConstraintsForExamPage(box: UIView) {
        
    }
    
    private lazy var pages: UIPageViewController = {
        let pages = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//        pages.dataSource = self
        return pages
    }()
    
    //MARK: Event
    
    //MARK: - SubClass
    
}

