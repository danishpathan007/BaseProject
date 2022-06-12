//
//  ClosureButton.swift
//
//  Created by Danish Khan on 14/12/20.
//

import Foundation
import UIKit

protocol ClosureButtonTargetViewDelegate:class {
    func closureButtonTargetView() -> UIView!
}

class ClosureButton: UIButton {
    
    public typealias ButtonAction = (ClosureButton)->Void
    private var closureCallback:ButtonAction!
    
    var targetViewDelegate:ClosureButtonTargetViewDelegate!
    
    func setAction(controlEvents:UIControl.Event = UIControl.Event.touchUpInside,action:@escaping ButtonAction){
        self.closureCallback = action
        self.removeTarget(self, action: #selector(ClosureButton.actionPerformed), for: controlEvents)
        self.addTarget(self, action: #selector(ClosureButton.actionPerformed), for: controlEvents)
    }
    
    @objc private func actionPerformed() {
        self.closureCallback(self)
    }
    
    var targetView:UIView {
        get{
            if let view = targetViewDelegate.closureButtonTargetView() {
                return view
            }
            fatalError("implement the ClosureButtonTargetViewDelegate to the target view")
        }
    }
   
//    @IBInspectable
//    var isApplyGradient:Bool = false
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if isApplyGradient {
//            gradientLayer.frame = bounds
//        }
//    }
//
//    private lazy var gradientLayer: CAGradientLayer = {
//        let l = CAGradientLayer()
//        l.frame = self.bounds
//        l.colors = [UIColor.appColor(.primaryColor).cgColor, UIColor.appColor(.secondaryColor).cgColor]
//        l.startPoint = CGPoint(x: 0, y: 0.5)
//        l.endPoint = CGPoint(x: 1, y: 0.5)
//        l.cornerRadius = self.layer.cornerRadius
//        layer.insertSublayer(l, at: 0)
//        return l
//    }()
    
}


