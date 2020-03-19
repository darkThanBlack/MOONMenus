//
//  CorrectingViewModel.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/3/18.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///学生信息，没有点评父类
class CorrectingStudentModel: CorrectingCellModel, CorrectingStudentCellDataSource {
    var avatar: String?
    
    var name: String?
    
    var detail: String?
}

///作业 - 文本类型
class CorrectingTextCellModel: CorrectingCellModel, CorrectingTextCellDataSource {
    var text: String?
}
///作业 - 音频类型
class CorrectingVoiceCellModel: CorrectingCellModel, CorrectingVoiceCellDataSource {
    
}
///作业 - 图片类型
class CorrectingImageCellModel: CorrectingCellModel, CorrectingImageCellDataSource {
    
}
///作业 - 视频类型
class CorrectingVideoCellModel: CorrectingCellModel, CorrectingVideoCellDataSource {
    
}

///批改作业 - 父类 cell 类型
class CorrectingCellModel: CorrectingCellDataSource {
    ///学生作业类型
    enum WorkStyle {
        case student
        case text
        case voice
        case image
        case video
    }
    var style: WorkStyle = .text
    
    ///老师点评内容
    class Corrects {
        
        var isEmpty: Bool {
            get {
                if (voices.count > 0) || review.isEditing {
                    return false
                }
                return true
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
        struct Review {
            ///是否需要展示输入框
            var isEditing: Bool = false
            var text: String = ""
        }
        var review = Review()
    }
    var corrects = Corrects()
}

///批改作业 - 基础页面模型
class CorrectingViewModel {
    
    var cells: [CorrectingCellModel] = []
        
    func loadRequestForCorrecting(complete: ((Bool) -> Void)?) {
        
        for idx in 0...30 {
            if idx == 0 {
                let student = CorrectingStudentModel()
                student.style = .student
                student.avatar = "moonShadow"
                student.name = "月之暗面-学生"
                student.detail = "提交于\(NSDate.now.description)"
                cells.append(student)
            } else {
                let text = CorrectingTextCellModel()
                text.style = .text
                text.text = "这个页面月之暗面一直做不好，请大神指导下，大神只能祝福祝伟大的客户端万寿无疆，人民的工程师身体永远健康！"
                
                text.corrects.teacher.avatar = "moonShadow"
                text.corrects.teacher.name = "月之暗面-老师"
                
                text.corrects.voices = [.init(vid: "001"), .init(vid: "002")]
                
                text.corrects.review.isEditing = true
                text.corrects.review.text = "Buckethead，著名吉他手Paul Gilbert的高徒，他的音乐风格是将电子乐，吉他噪音，独特的创意，融合到一起。Buckethead 共收集有 40 余个 现已停产的肯德基桶，并将它作为自己的帽子，这就是 Buckethead 名字的由来。Buckethead 任何时候都带着白色的面具，没有人见过他的真面目。"
                                
                cells.append(text)
            }
        }
        
        complete?(true)
    }
}
