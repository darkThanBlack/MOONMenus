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
        
        enum Style {
            case image
            case voice
            case text
        }
        ///问题类型
        var style: Style { return .text }
        
        class Image: Question, ExamCellImageDataSource {
            override var style: ExamViewModel.Question.Style { return .image }
            
            var image: String?
        }
        class Voice: Question, ExamCellVoiceDataSource {
            override var style: ExamViewModel.Question.Style { return .voice }
            
        }
        class Text: Question, ExamCellTextDataSource {
            override var style: ExamViewModel.Question.Style { return .text }
            
            var text: String?
        }

    }
    var questions: [Question] = []
    
    ///答案详情
    class Answer {
        
    }
    
    func loadMocks(complete: (() -> Void)?) {
        
        questions.removeAll()
        
        let question_text = Question.Text()
        question_text.text = "试卷问题内容：\nwhat's his job?"
        questions.append(question_text)
        
        let question_image = Question.Image()
        question_image.image = "moonShadow"
        questions.append(question_image)
        
        let question_voice = Question.Voice()
        questions.append(question_voice)
        
        
        
        complete?()
    }
}
