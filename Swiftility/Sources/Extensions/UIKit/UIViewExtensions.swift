//
//  UIViewExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/22/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import UIKit

// MARK: - Convenience init
extension UIView
{
    public convenience init(backgroundColor: UIColor)
    {
        self.init()
        self.backgroundColor = backgroundColor
    }
}

// MARK: - Constraints
extension UIView
{
    public func addConstraints(
        withVisualFormat format: String,
        views: [String : UIView] = [:],
        options: NSLayoutFormatOptions =  NSLayoutFormatOptions.directionLeadingToTrailing,
        metrics: [String : AnyObject]? = nil)
    {
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: metrics, views: views))
    }
}

// MARK: - Animations
extension UIView
{
    public func addFadeTransition(_ duration: CFTimeInterval)
    {
        let animation:CATransition = CATransition()
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration

        self.layer.add(animation, forKey: kCATransitionFade)
    }
    
    public func setHidden(
        _ hidden: Bool,
        animated: Bool,
        duration: TimeInterval = 0.2,
        customAnimations: (() -> Void)? = nil,
        completion: ((Void) -> Void)? = nil)
    {
        guard hidden != self.isHidden else {
            return
        }
        
        guard animated else {
            self.isHidden = hidden
            self.alpha = hidden ? 0 : 1
            customAnimations?()
            completion?()
            return
        }
        
        self.alpha = hidden ? 1 : 0
        
        if !hidden {
            self.isHidden = false
        }
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: .beginFromCurrentState,
            animations: {
                self.alpha = hidden ? 0 : 1
                customAnimations?()
            },
            completion: { finished in
                guard finished else { return }
                
                if hidden {
                    self.isHidden = true
                }
                
                completion?()
            }
        )
    }
}

// MARK: - Screenshot
extension UIView
{
    public func screenshot() -> UIImage?
    {
        let rect = self.bounds
        
        UIGraphicsBeginImageContext(rect.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        self.layer.render(in: context)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
    }
}

// MARK: - Frame convinience
extension UIView
{
    public var size: CGSize {
        get { return self.frame.size }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.size.width = value.width;
            newFrame.size.height = value.height;
            self.frame = newFrame
        }
    }
    
    public var left: CGFloat {
        get { return self.frame.origin.x }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.x = value;
            self.frame = newFrame;
        }
    }
    
    public var top: CGFloat {
        get { return self.frame.origin.y }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.y = value;
            self.frame = newFrame;
        }
    }
    
    public var right: CGFloat {
        get { return self.frame.origin.x + self.frame.size.width }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.x = value - frame.size.width;
            self.frame = newFrame;
        }
    }
    
    public var bottom: CGFloat {
        get { return self.frame.origin.y + self.frame.size.height }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.y = value - frame.size.height;
            self.frame = newFrame;
        }
    }
    
    public var width: CGFloat {
        get { return self.frame.size.width }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.size.width = value;
            self.frame = newFrame;
        }
    }
    
    public var height: CGFloat {
        get { return self.frame.size.height }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.size.height = value;
            self.frame = newFrame;
        }
    }
    
    public var centerY: CGFloat {
        get { return self.center.y }
        
        set(value) {
            self.center = CGPoint(x: self.center.x, y: value)
        }
    }
    
    public var centerX: CGFloat {
        get { return self.center.x }
        
        set(value) {
            self.center = CGPoint(x: value, y: self.center.y);
        }
    }
    
    // MARK: - Margins
    
    public var bottomMargin: CGFloat {
        get {
            guard let unwrappedSuperview = self.superview else {
                return 0
            }
            
            return unwrappedSuperview.height - self.bottom;
        }
        
        set(value) {
            guard let unwrappedSuperview = self.superview else { return }
            
            var frame = self.frame;
            frame.origin.y = unwrappedSuperview.height - value - self.height;
            self.frame = frame;
        }
    }
    
    
    public var rightMargin: CGFloat {
        get {
            guard let unwrappedSuperview = self.superview else {
                return 0
            }
            
            return unwrappedSuperview.width - self.right;
        }
        
        set(value) {
            guard let unwrappedSuperview = self.superview else { return }
            
            var frame = self.frame;
            frame.origin.y = unwrappedSuperview.width - value - self.width;
            self.frame = frame;
        }
    }
    
    // MARK: - Center
    
    public func centerInSuperview()
    {
        if let u = self.superview {
            self.center = CGPoint(x: u.bounds.midX, y: u.bounds.midY);
        }
    }
    
    public func centerVertically()
    {
        if let unwrappedOptional = self.superview {
            self.center = CGPoint(x: self.center.x, y: unwrappedOptional.bounds.midY);
        }
    }
    
    public func centerHorizontally()
    {
        if let unwrappedOptional = self.superview {
            self.center = CGPoint(x: unwrappedOptional.bounds.midX, y: self.center.y);
        }
    }
    
    // MARK: - Subviews
    
    public func removeAllSubviews(recursively: Bool = false)
    {
        while self.subviews.count > 0 {
            if let view = self.subviews.last {
                
                if recursively {
                    view.removeAllSubviews(recursively: recursively)
                }
                
                view.removeFromSuperview()
            }
        }
    }
}
