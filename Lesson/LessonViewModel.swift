//
//  LessonViewModel.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/3/15.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class SubLessonModel {
    
}

class LessonModel: LessonCellDataSource {
    var title: String?
    
    var time: String?
    
    var author: String?
    
    var counts: String?
    
    var subLessons: [SubLessonModel] = []
}

class LessonViewModel {
    var lessons: [LessonModel] = []
    
    func loadRequestForLesson(complete: ((Bool) -> Void)?) {
        for idx in 0...3 {
            let cellInfo = LessonModel()
            cellInfo.title = "备课本名称\(idx)"
            cellInfo.time = NSDate.now.description
            cellInfo.author = "创作者"
            cellInfo.counts = "共\(idx + 10)讲"
            lessons.append(cellInfo)
        }
        complete?(true)
    }
}
