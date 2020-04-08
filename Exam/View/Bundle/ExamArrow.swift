//
//  ExamArrow.swift
//  MOONMenus
//
//  Created by 徐一丁 on 2020/4/8.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

///代码绘制箭头，布局时要放死成正方形
class ExamArrow: UIView {
    
    //MARK: Interface
    
    enum Direction {
        case top
        case left
        case right
        case bottom
    }
    
    func updateArrow(color: UIColor? = nil, bgColor: UIColor? = nil, direction: Direction? = nil, height: CGFloat? = nil) {
        if height != nil {
            can.snp.updateConstraints { (make) in
                make.height.equalTo(height ?? 6.0)
            }
        }
        if color != nil {
            can.updateArrow(lineColor: color ?? UIColor.black, fillColor: bgColor)
        }
        if direction != nil {
            switch direction ?? .top {
            case .top:
                can.transform = .identity
            case .left:
                can.transform = CGAffineTransform(rotationAngle: -0.5 * .pi)
            case .right:
                can.transform = CGAffineTransform(rotationAngle: 0.5 * .pi)
            case .bottom:
                can.transform = CGAffineTransform(rotationAngle: .pi)
            }
        }
    }
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewsForExamArrow(box: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View
    
    private func loadViewsForExamArrow(box: UIView) {
        box.addSubview(can)
        
        can.snp.makeConstraints { (make) in
            make.centerX.equalTo(box.snp.centerX)
            make.centerY.equalTo(box.snp.centerY)
            make.width.equalTo(box.snp.width)
            make.height.equalTo(6.0)
        }
    }
    
    private lazy var can: Canvas = {
        let can = Canvas()
        return can
    }()
    
    //MARK: SubClass
    
    private class Canvas: UIView {
        
        //MARK: Interface
        
        private var lineColor: UIColor = .black
        private var bgColor: UIColor?
        
        func updateArrow(lineColor: UIColor, fillColor: UIColor? = .white) {
            shape.strokeColor = lineColor.cgColor
            shape.fillColor = fillColor?.cgColor ?? UIColor.white.cgColor
            
            setNeedsDisplay()
        }
                
        //MARK: Draw
        
        private var shape: CAShapeLayer = {
            let shape = CAShapeLayer()
            shape.lineWidth = 1.0
            shape.fillColor = UIColor.clear.cgColor
            return shape
        }()
        
        override func draw(_ rect: CGRect) {
            
            shape.removeFromSuperlayer()
            
            let path = UIBezierPath()
            let p0 = CGPoint(x: 0, y: bounds.height)
            let p1 = CGPoint(x: bounds.midX, y: 0)
            let p2 = CGPoint(x: bounds.width, y: bounds.height)
            
            path.move(to: p0)
            path.addLine(to: p1)
            path.addLine(to: p2)
            
            shape.path = path.cgPath
            
            layer.insertSublayer(shape, at: 0)
        }
        
    }

}

