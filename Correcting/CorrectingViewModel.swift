//
//  CorrectingViewModel.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class CorrectingStudentModel: CorrectingCellModel, CorrectingStudentCellDataSource {
    var avatar: String?
    
    var name: String?
    
    var detail: String?
}

class CorrectingTextModel: CorrectingCellModel, CorrectingTextCellDataSource {
    var text: String?
}

class CorrectingCellModel: CorrectingInputCellDataSource {
    ///学生作业类型
    enum WorkStyle {
        case student
        case text
        case voice
        case image
        case video
    }
    var style: WorkStyle = .text
        
    class Corrects {
        
        var isEmpty: Bool {
            get {
                if (voices.count > 0) || (mark.count > 0) {
                    return true
                }
                return false
            }
        }
        
        ///教师信息
        struct Teacher {
            var avatar: String?
            
            var name: String?
        }
        var teacher = Teacher()
        
        ///语音点评
        struct Voice {
            var vid: String
        }
        var voices: [Voice] = []
        
        ///文字点评
        var mark: String = ""
    }
    var corrects = Corrects()
}

class CorrectingViewModel {
    
    var cells: [CorrectingCellModel] = []
        
    func loadRequestForCorrecting(complete: ((Bool) -> Void)?) {
        
        for idx in 0...3 {
            if idx == 0 {
                let student = CorrectingStudentModel()
                student.style = .student
                student.avatar = "moonShadow"
                student.name = "月之暗面-学生"
                student.detail = "提交于\(NSDate.now.description)"
                cells.append(student)
            } else {
                let text = CorrectingTextModel()
                text.style = .text
                text.text = "这个页面月之暗面不太确定，请大神指导下，只能祝客户端万寿无疆，工程师身体永远健康！"
                
                text.corrects.teacher.avatar = "moonShadow"
                text.corrects.teacher.name = "月之暗面-老师"
                
                text.corrects.voices = [.init(vid: "001"), .init(vid: "002")]
                
                text.corrects.mark = "Buckethead，著名吉他手Paul Gilbert的高徒，他的音乐风格是将电子乐，吉他噪音，独特的创意，融合到一起。Buckethead 共收集有 40 余个 现已停产的肯德基桶，并将它作为自己的帽子，这就是 Buckethead 名字的由来。Buckethead 任何时候都带着白色的面具，没有人见过他的真面目。"
                                
                cells.append(text)
            }
        }
        
        complete?(true)
    }
}
