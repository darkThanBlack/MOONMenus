//
//  LessonSelectViewModel.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/16.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class SubLessonSelectModel {
    
}

class LessonSelectModel: LessonSelectCellDataSource {
    var title: String?
    
}

class LessonSelectViewModel {
    
    var lessons: [LessonSelectModel] = []
    
    func loadRequestForLessonSelect(complete: ((Bool) -> Void)?) {
        for idx in 0...3 {
            let cellInfo = LessonSelectModel()
            cellInfo.title = "高\(idx)数学备课本数学备课本数学备课本数学备课本数学备课本"
            lessons.append(cellInfo)
        }
        complete?(true)
    }
}
