//
//  MOONMenu.swift
//  MOONMenus
//
//  Created by 月之暗面 on 2020/4/23.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import UIKit

class MOONMenu: NSObject {
    static let core = MOONMenu()
    private let key = "kMOONMenuConfigKey"
    private override init() {
        let jsonString = UserDefaults.standard.string(forKey: key)
        guard let data = jsonString?.data(using: .utf8) else {
            config = Config()
            return
        }
        config = (try? JSONDecoder().decode(Config.self, from: data)) ?? Config()
    }
    
    let config: Config
    
    func start() {
        window.isHidden = false
    }
    
    private func saveConfigs() {
        guard let data = try? JSONEncoder().encode(self.config) else { return }
        guard let jsonString = String(data: data, encoding: .utf8) else { return }
        print("MOON__Log__deinit  \(jsonString)")
        UserDefaults.standard.set(jsonString, forKey: self.key)
        UserDefaults.standard.synchronize()
    }
    
    private lazy var window: Window = {
        let window = Window(frame: UIScreen.main.bounds)
        window.windowLevel = .alert
        window.rootViewController = UINavigationController.init(rootViewController: self.rootVC)
        window.noResponseView = self.rootVC.view
        return window
    }()
    
    private lazy var rootVC: RootController = {
        let rootVC = RootController()
        return rootVC
    }()
    
    @objc(MOONMenuConfig)
    class Config: NSObject, Codable {
        
        enum MenuState: String, Codable {
            case isOpen
            case isClose
        }
        var state = MenuState.isClose
        
        enum AbsorbMode: String, Codable {
            case system
            case edge
            case none
        }
        var absorb = AbsorbMode.system
        
        var openSize = CGSize(width: 300.0, height: 300.0)
        
        var closeSize = CGSize(width: 65.0, height: 65.0)
        
        var openCenter = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height * 0.33)
        
        var closeCenter: CGPoint = CGPoint(x: 200, y: 200)
    }
    
    @objc(MOONMenuWindow)
    private class Window: UIWindow {
        
        var noResponseView: UIView? = nil
        
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            let view = super.hitTest(point, with: event)
            return (view?.isEqual(noResponseView) ?? false) ? nil : view
        }
    }
    
    @objc(MOONMenuRootController)
    fileprivate class RootController: UIViewController {
        
        private lazy var closeView: UIView = {
            let closeView = UIView.init()
            closeView.backgroundColor = .clear
            closeView.isHidden = true
            
            closeView.isUserInteractionEnabled = true
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(updateMunuEvent))
            singleTap.numberOfTapsRequired = 1
            singleTap.numberOfTouchesRequired = 1
            closeView.addGestureRecognizer(singleTap)
            
            return closeView
        }()
        
        private lazy var basicMenu: Basic = {
            let basicMenu = Basic()
            basicMenu.backgroundColor = .clear
            basicMenu.layer.cornerRadius = 15.0
            basicMenu.layer.masksToBounds = true
            
            basicMenu.isUserInteractionEnabled = true
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(updateMunuEvent))
            singleTap.numberOfTapsRequired = 1
            singleTap.numberOfTouchesRequired = 1
            basicMenu.addGestureRecognizer(singleTap)
            
            return basicMenu
        }()
        
        private lazy var subMenu: MoonStyleMenu = {
            let subMenu = MoonStyleMenu.init(frame: .zero)
            
            subMenu.layer.cornerRadius = 18.0
            subMenu.layer.masksToBounds = true
            
            return subMenu
        }()
    }
    
    @objc(MOONMenuBasic)
    fileprivate class Basic: UIView {
        
        private let config = MOONMenu.core.config
        
        private var isUpdating = false
        private var beginPoint = CGPoint.zero
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(icon)
            addSubview(visualView)
            addSubview(display)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            icon.frame = bounds
            visualView.frame = bounds
            display.frame = bounds
        }
        
        private lazy var icon: UIImageView = {
            let icon = UIImageView(image: UIImage(named: "moonShadow"))
            return icon
        }()
        
        private lazy var visualView: UIVisualEffectView = {
            var effect: UIVisualEffect
            if #available(iOS 13.0, *) {
                effect = UIBlurEffect(style: .systemMaterial)
            } else {
                effect = UIBlurEffect(style: .extraLight)
            }
            let visualView = UIVisualEffectView(effect: effect)
            visualView.alpha = 0.0
            return visualView
        }()
        
        private lazy var display: Display = {
            let display = Display()
            return display
        }()
        
    }
    
    @objc(MOONMenuDisplay)
    fileprivate class Display: UIView {
        
    }
}

extension MOONMenu.RootController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(closeView)
        view.addSubview(basicMenu)
        
        basicMenu.bounds = CGRect(origin: .zero, size: MOONMenu.core.config.closeSize)
        basicMenu.center = MOONMenu.core.config.closeCenter
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        closeView.frame = view.bounds
    }
    
    //MARK: Event
    
    @objc private func updateMunuEvent() {
        basicMenu.updateMunuState {
            switch MOONMenu.core.config.state {
            case .isOpen:
                self.closeView.isHidden = false
            case .isClose:
                self.closeView.isHidden = true
            }
        }
    }
    
}

extension MOONMenu.Basic {
    
    //MARK: Interface
    
    func updateMunuState(complete: (() -> Void)?) {
        isUpdating = true
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            switch self.config.state {
            case .isOpen:
                self.bounds = CGRect(origin: .zero, size: self.config.closeSize)
                self.center = self.config.closeCenter
                
                self.icon.alpha = 1.0
                self.visualView.alpha = 0.0
                self.display.alpha = 0.0
            case .isClose:
                self.bounds = CGRect(origin: .zero, size: self.config.openSize)
                self.center = self.config.openCenter
                
                self.icon.alpha = 0.0
                self.visualView.alpha = 1.0
                self.display.alpha = 1.0
            }
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }) { (finished) in
            switch self.config.state {
            case .isOpen:
                self.config.state = .isClose
            case .isClose:
                self.config.state = .isOpen
            }
            complete?()
            
            self.isUpdating = false
            //TODO: Delay fade
        }
    }
    
    //MARK: Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        beginPoint = touches.first?.previousLocation(in: self) ?? CGPoint.zero
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch config.state {
        case .isOpen:
            break
        case .isClose:
            let newPoint = touches.first?.location(in: self) ?? CGPoint.zero
            
            self.center.x += newPoint.x - beginPoint.x
            self.center.y += newPoint.y - beginPoint.y
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesHandle()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesHandle()
    }
    
    //MARK: Private
    
    //TODO: Filter tap and pan gesture
    private func touchesHandle() {
        if !isUpdating {
            switch config.state {
            case .isOpen:
                break
            case .isClose:
                let result = countingAdaptPosition()
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.center = result
                }) { (finished) in
                    self.config.closeCenter = self.center
                }
            }
        }
    }
    
    ///计算最终位置
    private func countingAdaptPosition() -> CGPoint {
        var result = CGRect(origin: CGPoint(x: self.center.x - self.bounds.width / 2.0, y: self.center.y - self.bounds.height / 2.0), size: self.bounds.size)
        let barrier = UIScreen.main.bounds
        switch config.absorb {
        case .system:
            result = makeFrameAbsorb(frame: result, barrier: barrier)
            break
        case .edge:
            result = makeFrameEdgeAbsorb(frame: result, barrier: barrier)
            break
        case .none:
            result = makeFrameInBarrier(frame: result, barrier: barrier)
            break
        }
        
        return CGPoint(x: result.midX, y: result.midY)
    }
    
    ///保证在屏幕内
    private func makeFrameInBarrier(frame: CGRect, barrier: CGRect) -> CGRect {
        var result = frame
        
        let maxWidth = barrier.width - result.width
        let maxHeight = barrier.height - result.height
        
        result.origin.x = (result.origin.x < 0) ? 0 : result.origin.x
        result.origin.y = (result.origin.y < 0) ? 0 : result.origin.y
        
        result.origin.x = (result.origin.x > maxWidth) ? maxWidth : result.origin.x
        result.origin.y = (result.origin.y > maxHeight) ? maxHeight : result.origin.y
        
        return result
    }
    ///直接吸附
    private func makeFrameAbsorb(frame: CGRect, barrier: CGRect) -> CGRect {
        var result = makeFrameInBarrier(frame: frame, barrier: barrier)
        
        let maxX = barrier.width - result.width
        let maxY = barrier.height - result.height
        
        let dT = result.midY
        let dL = result.midX
        let dB = barrier.height - dT
        let dR = barrier.width - dL
        let dMin = [dT, dL, dB, dR].sorted().first  //决定向哪个方向吸附
        
        if (dMin == dT) {
            result = CGRect(origin: CGPoint(x: result.origin.x, y: 0), size: result.size)
        } else if (dMin == dB) {
            result = CGRect(origin: CGPoint(x: result.origin.x, y: maxY), size: result.size)
        } else if (dMin == dL) {
            result = CGRect(origin: CGPoint(x: 0, y: result.origin.y), size: result.size)
        } else if (dMin == dR) {
            result = CGRect(origin: CGPoint(x: maxX, y: result.origin.y), size: result.size)
        }
        
        return result
    }
    ///贴近边界才吸附
    private func makeFrameEdgeAbsorb(frame: CGRect, barrier: CGRect) -> CGRect {
        let absorbEdge = max(frame.width, frame.height) / 2.0
        let newBarrier = CGRect(origin: .zero,
                                size: CGSize(width: barrier.width - absorbEdge,
                                             height: barrier.height - absorbEdge))
        if (newBarrier.contains(frame)) {
            return frame
        } else {
            return makeFrameAbsorb(frame: frame, barrier: newBarrier)
        }
    }
    
    
}
