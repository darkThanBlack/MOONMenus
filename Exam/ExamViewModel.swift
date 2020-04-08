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
    
    class Section {
        enum SectionStyle {
            case question
            case option
            case answer
            case english
            case explan
        }
        var sectionStyle: SectionStyle { return .question }
        
        ///问题
        class Question: Section {
            override var sectionStyle: SectionStyle { return .question }
            
            class Content {
                enum Style {
                    case text
                    case voice
                    case image
                }
                ///问题类型
                var style: Style { return .text }
                
                class Text: Content, ExamCellTextDataSource {
                    override var style: Style { return .text }
                    
                    var text: String?
                }

                class Voice: Content, ExamCellVoiceDataSource {
                    override var style: Style { return .voice }
                    
                }
                
                class Image: Content, ExamCellImageDataSource {
                    override var style: Style { return .image }
                    
                    var image: String?
                }
            }
            var contents: [Content] = []
        }
        
        ///选项
        class Option: Section {
            override var sectionStyle: SectionStyle { return .option }
            
            ///单选/多选
            var isMulti: Bool = false
            
            class Content: ExamOptionCellDataSource {
                ///序号
                var serial: String?
                ///未选中 | 正确 | 错误
                var state: ExamOptionCell.Options.State = .normal
                
                enum Style {
                    case text
                    case voice
                    case image
                }
                ///选项类型
                var style: Style { return .text }
                
                class Text: Content, ExamOptionCellTextDataSource {
                    override var style: Style { return .text }
                    
                    var optionText: String?
                }
                
                class Voice: Content, ExamOptionCellVoiceDataSource {
                    override var style: Style { return .voice }
                    
                }
                
                class Image: Content, ExamOptionCellImageDataSource {
                    override var style: Style { return .image }
                    
                }
            }
            var contents: [Content] = []
        }
        
        ///答案
        class Answer: Section {
            override var sectionStyle: SectionStyle { return .answer }
            
            class Content: ExamAnswerCellDataSource {
                var correctAnswer: String?
            }
            var contents: [Content] = []
        }
        
        ///口语测评
        class English: Section {
            override var sectionStyle: SectionStyle { return .english }
            
            class Content: ExamEnglishCellDataSource {
                var text: String?
                var rank: String?
                var star: Int64 = 0
            }
            var contents: [Content] = []
        }
        
        ///解析, cell 与"问题"类型相同
        class Explan: Question {
            override var sectionStyle: SectionStyle { return .explan }
            
            ///点击展开解析
            var isOpened: Bool = false
        }
        
    }
    var cells: [Section] = []
    
    ///章节名称
    class Lesson: ExamNavigateHeaderDataSource {
        var isSelected: Bool = false
        var title: String?
        var totalCount: Int {
            get {
                return topics.count
            }
        }
        ///第X题
        class Topic: ExamNavigateCellDataSource {
            var isSelected: Bool = false
            var title: String?
            var star: Int64?
        }
        var topics: [Topic] = []
    }
    var lessons: [Lesson] = []
    
    ///章节下标
    private var currentIndex: (lesson: Int, topic: Int) = (0, 0)

    ///是否显示导航目录
    var isNavOpened: Bool = false
    
}

extension ExamViewModel {
    
    ///章节标题集合
    func queryLessonTitles() -> [String] {
        return lessons.map { lesson in
            return lesson.title ?? ""
        }
    }
    
    ///章节下标
    func queryLessonIndex() -> Int {
        return currentIndex.lesson
    }
    
    ///尝试更新到上一题
    func updatePreviousIndex() -> Bool {
        return updateIndex(newIndex: getPreviousIndex())
    }
    ///是否存在上一题
    func canUpdatePreviousIndex() -> Bool {
        return getPreviousIndex() != currentIndex
    }
    ///尝试获取上一题下标
    private func getPreviousIndex() -> (Int, Int) {
        var previousIndex: (Int, Int)
        if isLegal(index: (currentIndex.lesson, currentIndex.topic - 1)) {
            previousIndex = (currentIndex.lesson, currentIndex.topic - 1)
        } else {
            if isLegal(index: (currentIndex.lesson - 1, 0)) {
                if isLegal(index: (currentIndex.lesson - 1, lessons[currentIndex.lesson - 1].topics.count - 1)) {
                    previousIndex = (currentIndex.lesson - 1, lessons[currentIndex.lesson - 1].topics.count - 1)
                } else {
                    previousIndex = currentIndex
                }
            } else {
                previousIndex = currentIndex
            }
        }
        return previousIndex
    }
    
    ///尝试更新到下一题
    func updateNextIndex() -> Bool {
        return updateIndex(newIndex: getNextIndex())
    }
    ///是否存在下一题
    func canUpdateNextIndex() -> Bool {
        return getNextIndex() != currentIndex
    }
    ///尝试获取下一题下标
    private func getNextIndex() -> (Int, Int) {
        var nextIndex: (Int, Int)
        if isLegal(index: (currentIndex.lesson, currentIndex.topic + 1)) {
            nextIndex = (currentIndex.lesson, currentIndex.topic + 1)
        } else {
            if isLegal(index: (currentIndex.lesson + 1, 0)) {
                nextIndex = (currentIndex.lesson + 1, 0)
            } else {
                nextIndex = currentIndex
            }
        }
        return nextIndex
    }
    
    ///更新选中状态
    func updateIndex(newIndex: (lesson: Int, topic: Int)) -> Bool {
        let success = (currentIndex != newIndex) && updateLessons(newIndex: newIndex)
        if success {
            currentIndex = newIndex
        }
        return success
    }
    
    ///更新数据源
    private func updateLessons(newIndex: (lesson: Int, topic: Int)) -> Bool {
        let success = isLegal(index: currentIndex) && isLegal(index: newIndex)
        if success {
            lessons[currentIndex.lesson].topics[currentIndex.topic].isSelected = false
            lessons[newIndex.lesson].topics[newIndex.topic].isSelected = true
        }
        return success
    }
    
    ///边界检查
    private func isLegal(index: (lesson: Int, topic: Int)) -> Bool {
        var success: Bool
        //边界检查
        if (index.lesson < 0) || (lessons.count <= index.lesson) {
            success = false
        } else {
            let tmpLesson = lessons[index.lesson]
            if (index.topic < 0) || (tmpLesson.topics.count <= index.topic) {
                success = false
            } else {
                success = true
            }
        }
        return success
    }
    
    
    
    func loadMocks(complete: (() -> Void)?) {
        
        cells.removeAll()
        
        let q = Section.Question()
        
        let q_text = Section.Question.Content.Text()
        q_text.text = "试卷问题内容：\nwhat's his job?"
        q.contents.append(q_text)
        
        let q_image = Section.Question.Content.Image()
        q_image.image = "moonShadow"
        q.contents.append(q_image)
        
        let q_voice = Section.Question.Content.Voice()
        q.contents.append(q_voice)
        
        cells.append(q)
        
        let op = Section.Option()
        
        let op_text = Section.Option.Content.Text()
        op_text.serial = "A"
        op_text.optionText = "试卷选项内容：test"
        op.contents.append(op_text)
        
        let op_voice = Section.Option.Content.Voice()
        op_voice.serial = "B"
        op_voice.state = .right
        op.contents.append(op_voice)
        
        let op_image = Section.Option.Content.Image()
        op_image.serial = "C"
        op_image.state = .wrong
        op.contents.append(op_image)
        
        cells.append(op)
        
        let a = Section.Answer()
        
        let a_ = Section.Answer.Content()
        a_.correctAnswer = "A, B"
        a.contents.append(a_)
        
        cells.append(a)
        
        let e = Section.English()
        
        let e_ = Section.English.Content()
        e_.text = "This is test English exam..."
        e_.rank = "Shift!"
        e_.star = 2
        e.contents.append(e_)
        
        cells.append(e)
        
        let ex = Section.Explan()
        
        let ex_text = Section.Explan.Content.Text()
        ex_text.text = "试卷问题内容：\nwhat's his job?"
        ex.contents.append(ex_text)
        
        let ex_image = Section.Explan.Content.Image()
        ex_image.image = "moonShadow"
        ex.contents.append(ex_image)
        
        let ex_voice = Section.Explan.Content.Voice()
        ex.contents.append(ex_voice)
        
        cells.append(ex)
        
        lessons.removeAll()
        
        for index in 0..<9 {
            let lesson = Lesson()
            lesson.title = "章节名称"
            lesson.isSelected = false
            
            for idx in 0..<7 {
                let topic = Lesson.Topic()
                topic.title = "第\(idx)题"
                topic.isSelected = false
                topic.star = 2
                lesson.topics.append(topic)
            }
            
            lessons.append(lesson)
        }
        
        lessons[0].isSelected = true
        lessons[0].topics[0].isSelected = true
        
        complete?()
    }
    
    
}
