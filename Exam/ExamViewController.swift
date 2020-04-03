//
//  ExamViewController.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/2.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController {
    
    //MARK: Interface
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewsForExam(box: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Data
    
    private func loadRequestForExam() {
        
    }
    
    //MARK: View
    
    private func loadNavigationsForExam() {
        
    }
    
    private func loadViewsForExam(box: UIView) {
        
        loadConstraintsForExam(box: box)
    }
    
    private func loadConstraintsForExam(box: UIView) {
        
    }
    
    //MARK: Event
    
    //MARK: - SubClass
    
}

