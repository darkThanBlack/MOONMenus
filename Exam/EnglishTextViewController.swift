//
//  EnglishTextViewController.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/4/23.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class EnglishTextViewController: UIViewController {
    
    var details: [Detail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        loadMocks()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.englishLabel.attributedText = self.configEnglishAttrs(originalText: "you are the woman i love best of all in my lifehe, a gentleman, was regarded to be the most handsome man in the world, wonderfully urbaneextremely agreeable.", details: self.details)
        }
        
        view.addSubview(englishLabel)
        englishLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(-0)
        }
    }
    
    private lazy var englishLabel: UILabel = {
        let englishLabel = UILabel()
        englishLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        englishLabel.textColor = .black
        englishLabel.text = " "
        englishLabel.numberOfLines = 0
        englishLabel.textAlignment = .center
        return englishLabel
    }()
    
    class Detail {
        var score: Int64?
        var text: String?
        
        func queryTextStyle() -> [NSAttributedString.Key : Any] {
            let normal = [NSAttributedString.Key.foregroundColor: ExamHelper.blackText()]
            let red = [NSAttributedString.Key.foregroundColor: ExamHelper.red()]
            let green = [NSAttributedString.Key.foregroundColor: ExamHelper.green()]
            
            if score ?? 0 < 50 {
                return red
            } else if score ?? 0 > 85 {
                return green
            } else {
                return normal
            }
        }
    }
    
    private func configEnglishAttrs(originalText: String?, details: [Detail]) -> NSMutableAttributedString {
        
        let base = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]
        
        let text = NSString(string: originalText ?? "")
        var index: Int = 0  //不重复渲染
        let attr = NSMutableAttributedString(string: text as String, attributes: base)
        for detail in details {
            if text.length < index { break }
            let range: NSRange = text.range(of: detail.text ?? "", options: NSString.CompareOptions.literal, range: NSRange(location: index, length: text.length - index))
            if range.location == NSNotFound { continue }
            attr.addAttributes(detail.queryTextStyle(), range: range)
            index = range.location + range.length
        }
        return attr
    }
    
    
    private func loadMocks() {
        for index in 0..<10 {
            let detail = Detail()
            switch index {
            case 0:
                detail.score = 57
                detail.text = "you are the woman i love best of all in my lifehe,"
            case 1:
                detail.score = 57
                detail.text = ","
            case 2:
                detail.score = 0
                detail.text = "a gentleman,"
            case 3:
                detail.score = 0
                detail.text = ","
            case 4:
                detail.score = 0
                detail.text = "was regarded to be the most handsome man in the world,"
            case 5:
                detail.score = 0
                detail.text = ","
            case 6:
                detail.score = 0
                detail.text = "wonderfully urbaneextremely agreeable."
            case 7:
                detail.score = 0
                detail.text = "."
            default:
                continue
            }
            self.details.append(detail)
        }
    }
    
}
