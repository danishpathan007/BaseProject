//
//
// UICollectionView+Extension.swift
//
// Created By: Danish Khan on 28/06/2021
// Swift Version: 5.0
//
//
//
    

import Foundation
import UIKit
extension UICollectionView {
    /**
     Register cell nib without identifier
     */
    func registerNib<Cell: UICollectionViewCell>(cell: Cell.Type) {
        let nibName = String(describing: Cell.self)
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        
    }
    
    /**
     Dequeue registered cell
     */
    func dequeue<Cell: UICollectionViewCell>(indexPath:IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
    
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }
    
    func setEmptyView(image:UIImage) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        imageView.image = image
        self.backgroundView = imageView
    }

//    func restore() {
//        self.backgroundView = nil
//    }
    
    func identifier() -> String {
         return String(describing: self)
     }

}



extension UICollectionViewCell{
    func identifier() -> String {
        return String(describing: self)
    }
}
