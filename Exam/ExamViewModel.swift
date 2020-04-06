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
    
    ///问题
    class Question {
        
        enum Style {
            case text
            case voice
            case image
        }
        ///问题类型
        var style: Style { return .text }
        
        class Text: Question, ExamCellTextDataSource {
            override var style: ExamViewModel.Question.Style { return .text }
            
            var text: String?
        }

        class Voice: Question, ExamCellVoiceDataSource {
            override var style: ExamViewModel.Question.Style { return .voice }
            
        }
        
        class Image: Question, ExamCellImageDataSource {
            override var style: ExamViewModel.Question.Style { return .image }
            
            var image: String?
        }
        
    }
    var questions: [Question] = []
    
    ///单选/多选
    var isMultiOption: Bool = false
    ///选项
    class Option: ExamOptionCellDataSource {
        ///序号
        var serial: String?
        ///未选中 | 正确 | 错误
        var state: ExamOptionCell.Options.State = .normal
        
        enum ContentState {
            case text
            case voice
            case image
        }
        ///选项类型
        var contentState: ContentState { return .text }
        
        class Text: Option, ExamOptionCellTextDataSource {
            override var contentState: ExamViewModel.Option.ContentState { return .text }
            
            var optionText: String?
        }
        
        class Voice: Option, ExamOptionCellVoiceDataSource {
            override var contentState: ExamViewModel.Option.ContentState { return .voice }
            
        }
        
        class Image: Option, ExamOptionCellImageDataSource {
            override var contentState: ExamViewModel.Option.ContentState { return .voice }
            
        }
    }
    var options: [Option] = []
    
    ///答案
    class Answer {
        
    }
    var correctAnswer: String?
    
    ///口语测评
    class English: ExamEnglishCellDataSource {
        var text: String?
        var rank: String?
        var star: Int64 = 0
    }
    
    ///点击展开解析
    var isExplanOpened: Bool = false
    ///解析
    class Explan: Question {
        //与题目类型相同
    }
    var explans: [Explan] = []
    
    
    
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
        
        isMultiOption = false
        
        let option_text = Option.Text()
        option_text.optionText = ""
        
        complete?()
    }
}
