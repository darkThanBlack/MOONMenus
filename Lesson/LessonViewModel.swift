//
//  LessonViewModel.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/3/15.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class LessonDetailModel: LessonDetailCellDataSource {
    var imageName: String?
    
    var title: String?
    
    var detail: String?
    
    var tag: String?
    
}

class SubLessonModel: SubLessonCellDataSource {
    var title: String?

    var counts: String?
    
    var details: [LessonDetailModel] = []
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
            cellInfo.author = "创作者创作者创作者创作者创作者创作者"
            cellInfo.counts = "共\(idx + 10)讲"
            for idx in 0...2 {
                let subCellInfo = SubLessonModel()
                subCellInfo.title = "少儿英语启蒙少儿英语启蒙少儿英语启蒙少儿英语启蒙"
                subCellInfo.counts = "第\(idx)讲"
                for idx in 0...4 {
                    let detailCellInfo = LessonDetailModel()
                    detailCellInfo.imageName = ""
                    detailCellInfo.title = "三角函数课前预习完整讲义完整讲义完整讲义"
                    detailCellInfo.detail = "学员可见 | 3.4M | 2020-03-02 12:23"
                    detailCellInfo.tag = "作业"
                    subCellInfo.details.append(detailCellInfo)
                }
                cellInfo.subLessons.append(subCellInfo)
            }
            lessons.append(cellInfo)
        }
        complete?(true)
    }
}
