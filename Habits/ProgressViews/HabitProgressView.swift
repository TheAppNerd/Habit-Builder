//
//  HabitProgressView.swift
//  Habits
//
//  Created by Alexander Thompson on 27/4/21.
//

import UIKit

class HabitProgressView: UIProgressView {

    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCircularPath()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        self.progressTintColor = color
        configureCircularPath()
    }
    
    
    private func configureCircularPath() {
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 80, startAngle: -.pi, endAngle: 3 * .pi / 2, clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        
        circleLayer.fillColor = UIColor.clear.cgColor
        
        circleLayer.lineCap = .round
        
        circleLayer.lineWidth = 20.0
        
        circleLayer.strokeColor = UIColor.black.cgColor
        
        progressLayer.path = circularPath.cgPath
        
        progressLayer.fillColor = UIColor.clear.cgColor
        
        progressLayer.lineCap = .round
        
        progressLayer.lineWidth = 20.0
        
        progressLayer.strokeEnd = 0
        
        progressLayer.strokeColor = UIColor.red.cgColor
        
        layer.addSublayer(circleLayer)
        
        layer.addSublayer(progressLayer)
        
    }
    
    func progressAnimation(duration: TimeInterval, TotalAmount: Float, progress: CGFloat) {
        
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        circularProgressAnimation.duration = duration
        
        circularProgressAnimation.toValue = 1.0
        
        circularProgressAnimation.fillMode = .forwards
        
        circularProgressAnimation.isRemovedOnCompletion = false
        
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        
    }
    
}
