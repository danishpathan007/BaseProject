
import Foundation
import UIKit
extension UITableView {
    /**
     Register cell nib without identifier
     */
    func registerNib<Cell: UITableViewCell>(cell: Cell.Type) {
        let nibName = String(describing: Cell.self)
        
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        
    }
    
    /**
     Register header footer
     */
    
    func registerHeaderFooterNib<View: UIView>(view: View.Type) {
        let viewName = String(describing: View.self)
        
        register(UINib(nibName: viewName, bundle: nil), forHeaderFooterViewReuseIdentifier: viewName)
    }
    
    
    /**
     Dequeue registered cell
     */
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
    
    /**
     Dequeue Header footer
     */
    func dequeueHeaderFooter<View: UIView>() -> View {
        let identifier = String(describing: View.self)
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? View else {
            fatalError("Error in header footer")
        }
        return view
    }
    
    
    /**
     Hide extra rows
     */
    func hideExtraRows() {
        tableFooterView = UIView()
    }
    
    /**
     To show empty data message
     */
    
    func setEmptyView(title: String, message: String,ofSize: Int) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .semibold)
        
        emptyView.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -80).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        titleLabel.text = title
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    
    func setEmptyImage(_ image: UIImage) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.backgroundView = imageView
        self.separatorStyle = .none
    }
    /**
     To Become FirstResponder TextField
     */
    
    func becomeFirstResponderTextField() {
    outer: for cell in visibleCells {
        for view in cell.contentView.subviews {
            if let textfield = view as? UITextField {
                textfield.becomeFirstResponder()
                break outer
            }
        }
    }
    }
    
    func setCustomInfiniteIndicator() {
        let frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        self.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: frame)
    }
    
}

extension UITableViewCell{
    class func identifier() -> String {
        return String(describing: self)
    }
}
