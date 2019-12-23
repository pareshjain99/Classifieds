//
//  ShimmerView.swift
//  DubizzleClassified
//
//  Created by PareshJain on 12/21/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import UIKit

@IBDesignable public class ShimmerView: UIView {
    
    @IBInspectable public var shimmerWidth: CGFloat = 44.0 {
        didSet {
            prepareShimmerLayer()
        }
    }
    
    public var animationDuration: CGFloat = 0.8 {
        didSet {
            shimmerAnimation.duration = CFTimeInterval(animationDuration)
        }
    }
    
    public private(set) var isAnimating: Bool = false
    
    public let layerAnimationKeyPath = "ShimmerViewAnimation"
    public let transformAnimationKeyPath = "transform.translation.x"

    private var shimmerLayer : CAGradientLayer!
    private var shimmerAnimation: CABasicAnimation!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public func startAnimation(){
        isAnimating = true
        shimmerLayer.add(shimmerAnimation, forKey: layerAnimationKeyPath)
    }
    
    public func stopAnimation(){
        isAnimating = false
        shimmerLayer.removeAnimation(forKey: layerAnimationKeyPath)
    }
    
    private func setupView() {
        addObservers()
        prepareShimmerLayer()
        prepareShimmerAnimation()
    }
    
    private func prepareShimmerLayer() {
        shimmerLayer = CAGradientLayer()
        shimmerLayer.colors = [UIColor.white.withAlphaComponent(0.0).cgColor, UIColor.white.withAlphaComponent(0.8).cgColor]
        shimmerLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        shimmerLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        shimmerLayer.transform = CATransform3DMakeRotation(CGFloat.pi/2, 0, 0, 1)
        shimmerLayer.frame = CGRect(x: 0, y: 0, width: shimmerWidth, height: self.bounds.height)
        
        self.layer.sublayers = nil
        self.layer.addSublayer(shimmerLayer)
        self.clipsToBounds = true
    }
    
    private func prepareShimmerAnimation() {
        shimmerAnimation = CABasicAnimation(keyPath: transformAnimationKeyPath)
        shimmerAnimation.duration = CFTimeInterval(animationDuration)
        shimmerAnimation.fromValue = -40
        shimmerAnimation.toValue = self.frame.size.width
        shimmerAnimation.repeatCount = .infinity
        shimmerAnimation.isRemovedOnCompletion = false
    }
    
    @objc private func resumeAnimation() {
        if isAnimating {
            stopAnimation()
            startAnimation()
        }
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector:#selector(resumeAnimation) , name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    deinit {
        stopAnimation()
        NotificationCenter.default.removeObserver(UIApplication.didBecomeActiveNotification)
    }
}
