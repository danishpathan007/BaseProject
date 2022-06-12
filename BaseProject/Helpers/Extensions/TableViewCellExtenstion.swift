//
//  TableViewCellExtenstion.swift


import UIKit

extension UITableViewCell{
    
    class var className:String {
        get {
            return NSStringFromClass(classForCoder()).components(separatedBy: ".").last!
        }
    }
    
}

extension UITableView {
    
    @IBInspectable var useAutomaticDemensions:Bool {
        set{
            if newValue {
                self.estimatedRowHeight = self.rowHeight
                self.rowHeight = UITableView.automaticDimension
            }
            else {
                self.rowHeight = self.estimatedRowHeight
                self.estimatedRowHeight = 0
                
            }
        }
        get{
            return self.estimatedRowHeight != 0
        }
    }
    
    
}


extension UICollectionView {
    @IBOutlet weak var backView:UIView?{
        set{
            self.backgroundView = newValue
        }
        get{
            return self.backgroundView
        }
    }
}
