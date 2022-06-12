
import Foundation
import UIKit
import AVFoundation
import AVKit

class CommonUtilities{
    
    //MARK:- Password SecureTextEntry Method
    /**
     This Method manages the password field secure textentry functionality.
     
     # Parameters
     
     * textfield: Pass the textfield on which you want to perform the secure textEntry show/hide funtionality. eg. passwordTextField
     * button: Pass the button clicking on which you want to perform the functionality.
     
     # Must Assign
     Please set the textfield secureTextEntry property true before calling this method.
     ```
     passwordTextField.isSecureTextEntry = true
     ```
     */
    class func showHidePasswordCharacters(textField:UITextField, button:UIButton){
        //Tag 0 for uncrossed state
        //Tag 1 for crossed state
        let isShowPassword = Bool(truncating: button.tag as NSNumber)
        textField.isSecureTextEntry = isShowPassword
        let eyeIcon = isShowPassword ? UIImage(named: "eyeCross") : UIImage(named: "eye")
        button.setImage(eyeIcon, for: .normal)
        button.tag = isShowPassword ? 0 : 1
    }
    
 
    
    class func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
    }
    
    class func getDateFormatted(dateString:String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormats.yearMonthDate
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    
    class func getThumbnailFromUrl(_ url: URL?, _ completion: @escaping ((_ image: UIImage?)->Void)) {

        guard let url = url else { return }
        DispatchQueue.main.async {
            let asset = AVAsset(url: url)
            let assetImgGenerate = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true

            let time = CMTimeMake(value: 2, timescale: 1)
            do {
                let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: img)
                completion(thumbnail)
            } catch {
                print("Error :: ", error.localizedDescription)
                completion(nil)
            }
        }
    }
    
}


// MARK: - Root Screen Utility
class RootScreenUtility {
    
    class func window(for view: UIView) -> UIWindow? {
        if #available(iOS 13, *) {
            return (view.window?.windowScene?.delegate as! SceneDelegate).window
        }
        else {
            return (UIApplication.shared.delegate as! AppDelegate).window
        }
    }
    
    class func setRootScreen(window: UIWindow?) {
        let isUserLogin = UserDefaultManager.sharedManager.getBoolValue(key: Constants.UserDefaultsKeys.isUserLogIn)
        
        if UserDefaultManager.sharedManager.showGuideScreen() {
            let guideController = UIStoryboard(name: Constants.Storyboard.onBoarding.rawValue, bundle: nil).instantiateInitialViewController()
            window?.rootViewController = guideController
        }else if isUserLogin{
//            if let user = CommonUtilities.getUserFromUserDefaults(){
//                if let isBioSaved = user.userInfo?.isBioSaved {
//                    if isBioSaved{
//                        let dashboard = UIStoryboard(name: Constants.Storyboard.dashboard.rawValue, bundle: nil).instantiateInitialViewController()
//                        window?.rootViewController = dashboard!
//                        window?.makeKeyAndVisible()
//                    }else{
//                        let storyboard = UIStoryboard(name: Constants.Storyboard.main.rawValue, bundle: nil)
//                        let loginViewController = storyboard.instantiateViewController(withIdentifier: RegisterOptionViewController.identifier())
//                        let navigation = UINavigationController(rootViewController: loginViewController)
//                        navigation.navigationBar.isHidden = true
//                        window?.rootViewController = navigation
//                    }
//                }
//            }
        }else{
//            let storyboard = UIStoryboard(name: Constants.Storyboard.main.rawValue, bundle: nil)
//            let registerViewController = storyboard.instantiateViewController(withIdentifier: RegisterViewController.identifier())
//            let navigation = UINavigationController(rootViewController: registerViewController)
//            navigation.navigationBar.isHidden = true
//            window?.rootViewController = navigation
        }
    }
}


open class FormValidation {
   
    class func checkValidEmail(_ email:String) -> Bool {
        let emailRegEx = "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,4})$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    class func isValidEmail(_ email:String) -> String? {
        if isEmpty(string: email) {
            return Constants.ValidationMessages.enterEmail
        }else if !checkValidEmail(email){
            return Constants.ValidationMessages.enterValidEmail
        }else {
            return nil
        }
    }
    
    class func checkValidPassword(_ password: String) -> String? {
        if password.count < 6 {
            return Constants.ValidationMessages.password.tooShort
        } else if password.count > 20 {
            return Constants.ValidationMessages.password.tooLong
        } else {
            return nil
        }
    }
    
    //    class func checkValidPassword(_ password: String) -> Bool {
    //        let regex = "^(?=.*?[A-Z])(?=.*?[a-z]).{6,}$"
    //        let passwordTest = NSPredicate(format:"SELF MATCHES %@", regex)
    //        return passwordTest.evaluate(with: password)
    //    }
    
    class func checkValidPhone(_ phone:String)-> Bool{
        let PHONE_REGEX = "^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[0-9]*$"
        return NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX).evaluate(with: phone) && (phone.count >= 10 && phone.count <= 16)
    }
    
    class func checkValidUrl(_ urlString: String) -> Bool {
        let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
    }
    
    class func checkValidPAN(_ pan: String) -> Bool {
        let regex = "[A-Z]{5}[0-9]{4}[A-Z]{1}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: pan)
    }
       
    class func isEmpty(string: String?) -> Bool {
        guard let password = string else { return true }
        if password.trimSpace().isEmpty {
            return true
        }
        return false
    }
        
    class func isValidate(to password:String) -> String? {
        if FormValidation.isEmpty(string: password) {
            return Constants.ValidationMessages.enterNewPassword
        }
        return FormValidation.checkValidPassword(password)
    }
    
    class func isValidate(to password:String, from confirmPassword:String) -> String? {
        if FormValidation.isEmpty(string: password) {
            return Constants.ValidationMessages.enterConfirmPassword
        }
        if let errorString =  FormValidation.checkValidPassword(password) {
            return errorString
        }
        return isPasswordsMatch(to: password, from: confirmPassword)
    }
    
    class func isPasswordsMatch(to password:String, from confirmPassword:String) -> String? {
        if password != confirmPassword {
            return Constants.ValidationMessages.passwordMismatch
        }
        return nil
    }
    
    
    
    
}


class AlertUtility {
    
    static let CancelButtonIndex = -1;
    
    class func showAlert(_ onController:UIViewController!, title:String?,message:String? ) {
        showAlert(onController, title: title, message: message, cancelButton: "OK", buttons: nil, actions: nil)
    }
    
    /**
     - parameter title:        title for the alert
     - parameter message:      message for alert
     - parameter cancelButton: title for cancel button
     - parameter buttons:      array of string for title for other buttons
     - parameter actions:      action is the callback which return the action and index of the button which was pressed
     */
    
    
    class func showAlert(_ onController:UIViewController!, title:String?,message:String? = nil ,cancelButton:String = "OK",buttons:[String]? = nil,actions:((_ alertAction:UIAlertAction,_ index:Int)->())? = nil) {
        // make sure it would be run on  main queue
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: cancelButton, style: UIAlertAction.Style.cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            actions?(action,CancelButtonIndex)
        }
        action.setValue(UIColor.appColor(.primaryColor), forKey: "titleTextColor")
        alertController.addAction(action)
        if let _buttons = buttons {
            for button in _buttons {
                let action = UIAlertAction(title: button, style: .default) { (action) in
                    let index = _buttons.index(of: action.title!)
                    actions?(action,index!)
                }
                alertController.addAction(action)
            }
        }
        onController.present(alertController, animated: true, completion: nil)
    }
    
    class func showDeleteAlert(_ on: UIViewController, text: String,
                               _ deleteAction: @escaping  (() -> ()) ) {
        showAlert(
            on,
            title: "Delete \(text)",
            message: "Are you sure you want to delete the \(text).",
            cancelButton: "No",
            buttons: ["Yes"]) { (_, index) in
                if index != -1 {
                    deleteAction()
                }
            }
    }
}
