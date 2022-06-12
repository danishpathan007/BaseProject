//
//  Indicator.swift
//  APIHelperDemo
//
//  Created by Danish on 04/06/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class Loader: NSObject{

    static let sharedInstance = Loader()
    
    let association = ObjectAssociation<UIView>()

    var activityIndicator: UIView {
        set { association[UIApplication.shared.topMostViewController()!] = newValue }
        get {
            if let indicator = association[UIApplication.shared.topMostViewController()!] {
                return indicator
            } else {
                association[UIApplication.shared.topMostViewController()!] = NVActivityIndicatorView.customIndicator(view: UIApplication.shared.topMostViewController()?.view ?? UIView())
                return association[UIApplication.shared.topMostViewController()!]!
            }
        }
    }
    
    // MARK: - Acitivity Indicator
     func startIndicatingActivity() {
        DispatchQueue.main.async {
            UIApplication.shared.topMostViewController()?.view.addSubview(self.activityIndicator)
        }
    }
    
     func stopIndicatingActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.removeFromSuperview()
        }
    }
}

extension NVActivityIndicatorView {
    public static func customIndicator(view:UIView) -> UIView {
       let bgView = UIView()
       bgView.frame = view.frame
       bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
       print(view.frame.width/2)
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: view.center.x - 20, y: view.frame.height/2 - 20, width: 50, height: 50), type: .ballSpinFadeLoader, color:  UIColor.red, padding: NVActivityIndicatorView.DEFAULT_PADDING)
       print(view.frame)
       view.addSubview(bgView)
       bgView.addSubview(activityIndicator)
       activityIndicator.startAnimating()
       return bgView
   }
}
