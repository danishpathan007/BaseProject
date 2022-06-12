
import Foundation
import UIKit

extension String {
    
    func attributedStringWithColor(_ strings: [String], color: UIColor,font:UIFont,characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: color,NSAttributedString.Key.font: font], range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    
    
    func trimSpace() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var length:Int{
        return self.count
    }
    
    var localized:String {
        return NSLocalizedString(self, comment: self)
    }
    var simplePhoneNumber:String {
        var string = self.replacingOccurrences(of: "-", with: "")
        string = string.replacingOccurrences(of: "(", with: "")
        string = string.replacingOccurrences(of: ")", with: "")
        string = string.replacingOccurrences(of: " ", with: "")
        return string
    }
    
    var toInt:Int? {
        return Int.init(self)
    }
    
    var toFloat:Float? {
        return Float.init(self)
    }
    
    var toDouble:Double? {
        return Double.init(self)
    }
    var html2AttributedString : NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    func ltrim(_ str: String, _ chars: Set<Character>) -> String {
        if let index = str.firstIndex(where: {!chars.contains($0)}) {
            return String(str[index..<str.endIndex])
        } else {
            return ""
        }
    }
    
    var validURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    
    func UTCToLocalDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormats.messageCellDateFormat
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self) ?? Date()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        return dateFormatter.string(from: dt)
    }
    
    func converOnCreatedDate() -> String {
        let dateFormatter = DateFormatter()

        if (self.contains(".")) {
            dateFormatter.dateFormat = Constants.DateFormats.responseDateFormat
        }
        else{
            dateFormatter.dateFormat = Constants.DateFormats.dateMonthYearWith
        }
      
        dateFormatter.timeZone=TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self) ?? Date()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = Constants.DateFormats.dateMonthYearWith
        
        return dateFormatter.string(from: dt)
    }
    
    func converOnCreatedTime() -> String {
        let dateFormatter = DateFormatter()

        if (self.contains(".")) {
            dateFormatter.dateFormat = Constants.DateFormats.responseDateFormat
        }
        else{
            dateFormatter.dateFormat = Constants.DateFormats.messageCellDateFormat
        }
        dateFormatter.timeZone=TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self) ?? Date()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: dt)
    }
   
    
    func timeInterval() -> String {
        let dateFormatter = DateFormatter()

        if (self.contains(".")) {
            dateFormatter.dateFormat = Constants.DateFormats.responseDateFormat
        }
        else{
            dateFormatter.dateFormat = Constants.DateFormats.messageCellDateFormat
        }
        dateFormatter.timeZone=TimeZone(abbreviation: "UTC")
        
        let dateWithTime = dateFormatter.date(from: self) ?? Date()
        
        dateFormatter.timeZone = TimeZone.current
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateWithTime, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" : "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" : "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" : "\(day)" + " " + "days ago"
        }else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" : "\(hour)" + " " + "hours ago"
        }else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" : "\(minute)" + " " + "minutes ago"
        }else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "second ago" : "\(second)" + " " + "seconds ago"
        } else {
            return "a moment ago"
        }
    }
    
    func UTCToLocalDateYMD() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormats.messageCellDateFormat
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self) ?? Date()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = Constants.DateFormats.yearMonthDate
        
        return dateFormatter.string(from: dt)
    }
    
    
    
    func UTCToLocalTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormats.messageCellDateFormat
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self) ?? Date()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.string(from: dt)
    }
    
    

    
}


extension Int {
    
    var toString:String{
        return String.init(describing: self)
    }
}


extension Double {
    
    var toString:String{
        return String.init(describing: self)
    }
}


extension Float{
    
    var toString:String{
        return String.init(describing: self)
    }
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

protocol DataModel{}
extension String:DataModel {}
extension Int:DataModel {}
extension Array:DataModel{}
extension Dictionary:DataModel{}

extension DataModel
{
    var toString:String?{
        return self as? String
    }
    var toArray:Array<Any>?{
        return self as? Array
    }
    
    var toDictionary:Dictionary<String, Any>?{
        return self as? Dictionary<String, Any>
    }
}

//MARK:- UITapGesture Label Extension
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
}


extension UILabel {

    func boldSubstring(_ substr: String) {
        guard substr.isEmpty == false,
            let text = attributedText,
            let range = text.string.range(of: substr, options: .caseInsensitive) else {
                return
        }
        let attr = NSMutableAttributedString(attributedString: text)
        let start = text.string.distance(from: text.string.startIndex, to: range.lowerBound)
        let length = text.string.distance(from: range.lowerBound, to: range.upperBound)
        attr.addAttributes([NSAttributedString.Key.font: UIFont.RobotoBoldFontWith(size: self.font.pointSize) ?? UIFont.boldSystemFont(ofSize: self.font.pointSize)],
                           range: NSMakeRange(start, length))
        attributedText = attr
    }
}


protocol AttributedStringComponent {
    var text: String { get }
    func getAttributes() -> [NSAttributedString.Key: Any]?
}

// MARK: String extensions

extension String: AttributedStringComponent {
    var text: String { self }
    func getAttributes() -> [NSAttributedString.Key: Any]? { return nil }
}

extension String {
    func toAttributed(with attributes: [NSAttributedString.Key: Any]?) -> NSAttributedString {
        .init(string: self, attributes: attributes)
    }
}

// MARK: NSAttributedString extensions

extension NSAttributedString: AttributedStringComponent {
    var text: String { string }

    func getAttributes() -> [Key: Any]? {
        if string.isEmpty { return nil }
        var range = NSRange(location: 0, length: string.count)
        return attributes(at: 0, effectiveRange: &range)
    }
}

extension NSAttributedString {

    convenience init?(from attributedStringComponents: [AttributedStringComponent],
                      defaultAttributes: [NSAttributedString.Key: Any],
                      joinedSeparator: String = " ") {
        switch attributedStringComponents.count {
        case 0: return nil
        default:
            var joinedString = ""
            typealias SttributedStringComponentDescriptor = ([NSAttributedString.Key: Any], NSRange)
            let sttributedStringComponents = attributedStringComponents.enumerated().flatMap { (index, component) -> [SttributedStringComponentDescriptor] in
                var components = [SttributedStringComponentDescriptor]()
                if index != 0 {
                    components.append((defaultAttributes,
                                       NSRange(location: joinedString.count, length: joinedSeparator.count)))
                    joinedString += joinedSeparator
                }
                components.append((component.getAttributes() ?? defaultAttributes,
                                   NSRange(location: joinedString.count, length: component.text.count)))
                joinedString += component.text
                return components
            }

            let attributedString = NSMutableAttributedString(string: joinedString)
            sttributedStringComponents.forEach { attributedString.addAttributes($0, range: $1) }
            self.init(attributedString: attributedString)
        }
    }
}
