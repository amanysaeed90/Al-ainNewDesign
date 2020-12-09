//
//  HidingViewController.swift
//  Optimus
//
//  Created by Tristan Himmelman on 2015-03-17.
//  Copyright (c) 2015 Hearst TV. All rights reserved.
//

import UIKit

class HidingViewController {
    
    var child: HidingViewController?
    var navSubviews: [UIView]?
    var view: UIView
    var deltaConstraint: NSLayoutConstraint?
    
    var expandedCenter: ((UIView) -> CGPoint)?
    
    var alphaFadeEnabled = false
    var contractsUpwards = true
    
    private var needsConstraintBasedContractsUpwardsUpdate: Bool
    
    init(view: UIView, constraint: NSLayoutConstraint? = nil) {
        self.view = view
        self.deltaConstraint = constraint
        self.needsConstraintBasedContractsUpwardsUpdate = constraint != nil
    }
    
    init() {
        view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.clear
        view.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        needsConstraintBasedContractsUpwardsUpdate = false
    }
    
    func updateContractsUpwardsIfNeeded() {
        guard let deltaConstraint = deltaConstraint, needsConstraintBasedContractsUpwardsUpdate else { return }
        
        needsConstraintBasedContractsUpwardsUpdate = false
        view.superview?.layoutIfNeeded()
        let oldMinY = view.frame.minY
        deltaConstraint.constant += 1
        view.superview?.layoutIfNeeded()
        self.contractsUpwards = view.frame.minY > oldMinY
        deltaConstraint.constant -= 1
    }
    
    func expandedCenterValue() -> CGPoint {
        if let expandedCenter = expandedCenter {
            return expandedCenter(view)
        }
        return CGPoint(x: 0, y: 0)
    }
    
    func contractionAmountValue() -> CGFloat {
        return view.bounds.height
    }
    
    func contractedCenterValue() -> CGPoint {
        var expanded = expandedCenterValue()
        expanded.y += contractionAmountValue() * (contractsUpwards ? -1 : 1)
        return expanded
    }
    
    func isContracted() -> Bool {
        if let deltaConstraint = deltaConstraint {
            return deltaConstraint.constant == view.bounds.height * (contractsUpwards ? 1 : -1)
        } else {
            return Float(fabs(view.center.y - contractedCenterValue().y)) < FLT_EPSILON
        }
    }
    
    func isExpanded() -> Bool {
        if let deltaConstraint = deltaConstraint {
            return deltaConstraint.constant == 0
        } else {
            return Float(fabs(view.center.y - expandedCenterValue().y)) < FLT_EPSILON
        }
    }
    
    func totalHeight() -> CGFloat {
        let height = expandedCenterValue().y - contractedCenterValue().y
        if let child = child {
            return child.totalHeight() + height
        }
        return height
    }
    
    func setAlphaFadeEnabled(_ alphaFadeEnabled: Bool) {
        self.alphaFadeEnabled = alphaFadeEnabled
        
        if !alphaFadeEnabled {
            updateSubviewsToAlpha(1.0)
        }
    }
    
    func updateYOffset(_ delta: CGFloat) -> CGFloat {
        var deltaY = delta
        if child != nil && deltaY < 0 {
            deltaY = child!.updateYOffset(deltaY)
            child!.view.isHidden = (deltaY) < 0;
        }
        
        var newYOffset = view.center.y + deltaY
        var newYCenter = max(min(expandedCenterValue().y, newYOffset), contractedCenterValue().y)
        if contractsUpwards == false {
            newYOffset = view.center.y - deltaY
            newYCenter = min(max(expandedCenterValue().y, newYOffset), contractedCenterValue().y)
        }
        
        if let deltaConstraint = deltaConstraint {
            deltaConstraint.constant = contractsUpwards
                ? max(min(deltaConstraint.constant - deltaY,  view.bounds.height), 0)
                : min(max(deltaConstraint.constant + deltaY, -view.bounds.height), 0)
        } else {
            view.center = CGPoint(x: view.center.x, y: newYCenter)
        }
        
        if alphaFadeEnabled {
            var newAlpha: CGFloat = 1.0 - (expandedCenterValue().y - view.center.y) * 2 / contractionAmountValue()
            newAlpha = CGFloat(min(max(FLT_EPSILON, Float(newAlpha)), 1.0))
            
            updateSubviewsToAlpha(newAlpha)
        }
        
        var residual = newYOffset - newYCenter
        
        if (child != nil && deltaY > 0 && residual > 0) {
            residual = child!.updateYOffset(residual)
            child!.view.isHidden = residual - (newYOffset - newYCenter) > 0
        }
        
        return residual;
    }
    
    func snap(_ contract: Bool, animated: Bool = true, completion:((Void) -> Void)!) -> CGFloat {
        func _snap() -> CGFloat {
            if let child = self.child {
                return contract && child.isContracted()
                    ? self.contract()
                    : self.expand()
            }
            return contract
                ? self.contract()
                : self.expand()
        }
        
        //  guard animated else { let delta = _snap(); completion?(<#Void#>); return delta }
        
        var deltaY: CGFloat = 0
        
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions(), animations: {
            deltaY = _snap()
            if let _ = self.deltaConstraint {
                self.view.superview?.layoutIfNeeded()
            }
        }) { (success: Bool) -> Void in
            if completion != nil{
                completion;
            }
        }
        
        return deltaY;
    }
    
    func expand() -> CGFloat {
        view.isHidden = false
        
        if alphaFadeEnabled {
            updateSubviewsToAlpha(1)
            navSubviews = nil
        }
        
        var amountToMove = expandedCenterValue().y - view.center.y
        
        if let deltaConstraint = deltaConstraint {
            deltaConstraint.constant = 0
        } else {
            view.center = expandedCenterValue()
        }
        if let child = child {
            amountToMove += child.expand()
        }
        
        return amountToMove;
    }
    
    func contract() -> CGFloat {
        if alphaFadeEnabled {
            updateSubviewsToAlpha(0)
        }
        
        let amountToMove = contractedCenterValue().y - view.center.y
        
        if let deltaConstraint = deltaConstraint {
            deltaConstraint.constant = view.bounds.height * (contractsUpwards ? 1 : -1)
        } else {
            view.center = contractedCenterValue()
        }
        
        return amountToMove;
    }
    
    // MARK: - Private methods
    
    fileprivate func updateSubviewsToAlpha(_ alpha: CGFloat) {
        if navSubviews == nil {
            navSubviews = []
            
            // loops through and subview and save the visible ones in navSubviews array
            for subView in view.subviews {
                let isBackgroundView = subView === view.subviews[0]
                let isViewHidden = subView.isHidden || Float(subView.alpha) < FLT_EPSILON
                
                if isBackgroundView == false && isViewHidden == false {
                    navSubviews?.append(subView)
                }
            }
        }
        
        if let subViews = navSubviews {
            for subView in subViews {
                subView.alpha = alpha
            }
        }
    }
}
