//
//  ExamViewModel.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/2.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit


///测评试卷详情
class ExamViewModel {
    
    
    ///问题详情
    class Question {
        ///问题类型
        enum Style {
            case image
            case voice
            case text
        }
        var style: Style { return .text }
    }
    class ImageQeustion: Question {
        override var style: ExamViewModel.Question.Style { return .image }
        
    }
    class VoiceQuestion: Question {
        override var style: ExamViewModel.Question.Style { return .voice }
        
    }
    class TextQeustion: Question {
        override var style: ExamViewModel.Question.Style { return .text }
        
    }
    var questions: [Question] = []
    
    ///答案详情
    class Answer {
        
    }
}
