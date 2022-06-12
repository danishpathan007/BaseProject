

import Foundation
import UIKit

class Constants: NSObject {
    struct ErrorMessages{
        static let noResultfound = "No result found"
        static let apiResponseFailed = "Api response failed"
    }
    
    struct Pagination{
        static let limit          =   200
        static let reportsLimit   =   10
        static let questionsLimit =   10
        static let favouriteList  =   15
    static let gallaryList    =   15
    }
    
    struct UserDefaultKey {
        static let socialType     = "socialType"
        static let userType       = "userType"
        static let token          = "token"
        static let csrf           = "csrf"
        static let isLogin        = "isLogin"
        static let userModel      = "userModel"
        static let fcmToken       = "fcmToken"
        static let linkedinToken  = "linkedinToken"
    }
    
    struct DateFormats {
        static let ApiDateFormat = "yyyy-MM-dd HH:mm:ssZ"
        static let monthYear = "MMMM yyyy"
        static let responseDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        static let DatePickerDateFormat = "yyyy-MM-dd HH:mm:ssZ"
        static let dateMonthYear = "dd-MM-yyyy"
        static let dateMonthYearWith = "dd/MM/yyyy"
        static let yearMonthDate = "yyyy-MM-dd"
        static let yearMonthDateAPI = "yyyy-mm-dd"
        static let monthDateYear = "MM-dd-yyyy"
        static let time = "hh:mm a"
        static let sortTime = "h:mm a"
        static let chatDateFormat = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'"
        static let messageCellDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }
    
    struct AlertTitle{
        static let success = "Success"
        static let alert = "Alert"
        static let error = "Error"
        static let delete = "Delete"
        static let imageNotFound = "Image not found"
        static let videoNotFound = "Video not found"
        static let documentNotFound = "Document not found"
        static let remove = "Remove"
        static let sure = "Are you sure?"
        static let appName = "iNet App"
        static let warning = "Warning"
    }
    
    struct CheckTrueFalseString{
        static let isTrue = "true"
        static let isFalse = "false"
    }
    
    struct ButtonTitle {
        static let cameraButton = "Open Camera"
        static let photoLibraryButton = "Open Photos"
        static let settingsButton = "Open Settings"
    }
    
    struct MediaUploadStack {
        static var uploadingFileIds:[String] = []
    }
    
    struct SuccessMessages{
        static let mailSentSuccess = "Reset password link is send to your email"
        static let passwordChanged = "Your Password has been changed successfully"
        static let profileUpdateSuccess = "Profile Updated Successfully"
    }
    
    enum NotificationType:String {
        case message                =        "message"
        case image                  =        "image"
        case audio                  =        "audio"
        case text                   =        "text"
        case ScheduleAppointment    =        "ScheduleAppointment"
        case AcceptAppointment      =        "AcceptAppointment"
        case RejectAppointment      =        "RejectAppointment"
        case SendProposal           =        "SendProposal"
        case AcceptProposal         =        "AcceptProposal"
        case BookingRequest         =        "BookingRequest"
        case BookingConfirmed       =        "BookingConfirmed"
        case BookingCancelled       =        "BookingCancelled"
    }
    
    struct InputLengthConstraints {
        struct Minimum {
            static let name             =    3
            static let password         =    6
            static let phoneNumber      =    10
            static let firstName        =    3
            static let fullName         =    3
            static let lastName         =    3
            static let userName         =    4
        }
        
        struct Maximum {
            static let fullName         =    50
            static let userName         =    50
            static let password         =    21
            static let email            =    150
            static let phoneNumber      =    16
            static let name             =    80
            static let firstName        =    50
            static let lastName         =    50
            static let description      =    250
            static let yearOfExperience =    3
            static let noOfGuest        =    9
        }
    }
    
    struct RegexPattern {
        static let onlyAlphabetsAneWhiteSpace = ".*[^A-Za-z ].*"
    }
    
    struct ValidationMessages {
        struct name {
            static let tooLong = "Name cannot be more than \(InputLengthConstraints.Maximum.name) characters"
            static let empty = "Please enter the name"
            static let numeric = "Name cannot have numeric values"
            static let specialCharacters = "Name cannot have special characters"
        }
        struct fullname {
            static let tooLong = "Full Name cannot be more than \(InputLengthConstraints.Maximum.fullName) characters"
            static let tooShort = "The fullname cannot be less than  \(InputLengthConstraints.Minimum.fullName) characters"
        }
        struct username {
            static let tooLong = "User Name cannot be more than \(InputLengthConstraints.Maximum.userName) characters"
            static let tooShort = "The username cannot be less than  \(InputLengthConstraints.Minimum.userName) characters"
        }
        struct firstName {
            static let tooLong = "Fist Name cannot be more than \(InputLengthConstraints.Maximum.firstName) characters"
            static let tooShort = "The firstname cannot be less than  \(InputLengthConstraints.Minimum.firstName) characters"
        }
        struct lastName {
            static let tooLong = "Last Name cannot be more than \(InputLengthConstraints.Maximum.lastName) characters"
            static let tooShort = "The lastname cannot be less than  \(InputLengthConstraints.Minimum.lastName) characters"
        }
        struct contact {
            static let tooLong = "Phone Number cannot be more than \(InputLengthConstraints.Maximum.phoneNumber) digits"
            static let tooShort = "The phone number cannot be less than  \(InputLengthConstraints.Minimum.phoneNumber) digits"
        }
        struct message {
            static let empty = "Please enter the Message"
        }
        struct email {
            static let empy = "Please enter the email address"
            static let invalid = "Please enter a valid email address"
            static let exists = "The email address already exists"
        }
        struct password {
            static let confirm = "Please confirm your password"
            static let tooShort = "The password cannot be less than 6 characters"
            static let tooLong = "The password cannot be more than 20 characters"
            static let atLeastOneUpperCaseAndEightCharacters = "The password contains at least 8 characters with at least a uppercase character"
            static let tooWeak = "Weak Password "
            static let tooStrong = "Strong Password"
            static let atLeastOneUpperCase = "Password must contain minimum 8 characters and one uppercase letter"
            static let atLeastOneNumberAndSpecial = "Password must have at least 8 characters with at least one Capital letter, at least one number and special character."
        }
        static let loginFailed = "Login failed!"
        static let noInternetConnection = "Oh! there is a connection issue, Please check your network connection and try again."
        static let serverError = "We are unable to get the response, please try after some time"
        static let titleNoInternet = "No Internet Connection"
        static let userName = "Please enter Username"
        static let enterTitle = "Please enter the title"
        static let enterFirstName = "Please enter the first name"
        static let enterBrideName = "Please enter the bride name"
        static let enterGroomName = "Please enter the groom name"
        static let enterBudgetFrom = "Please set minimum budget range"
        static let enterBudgetTo = "Please set maximum budget range"
        static let enterDistroName = "Please enter distro name."
        static let enterLastName = "Please enter the last name"
        static let enterValidPhone = "Please enter a valid phone number"
        static let enterValidName = "Please enter valid Name"
        static let comfirmPassword = "Please confirm your password."
        static let enterCurrentPassword = "Please enter your current password."
        static let enterNewPassword = "Please enter the new password."
        static let enterConfirmPassword = "Please confirm your password."
        static let enterValidEmail = "Please enter a valid email address."
        static let logoutConfirmation = "Are you sure you want to logout?"
        static let enterOldPassword = "Please enter your Current password."
        static let enterPhoneNumber = "Please enter the phone number"
        static let passwordMismatch = "Your password and confirm password do not match."
        static let samePassword = "New password can't be same as old password."
        static let comfirmPasswordMismatch = "Your password and confirm password do not match"
        static let enterName = "Please enter the Name"
        static let enterDescription = "Please enter the Description"
        static let enterPassword = "Please enter the password."
        static let enterEmail = "Please enter the email address."
        static let deletePagerConfirmation = "Are your sure want to delete this pager ?"
        static let deletePhoneConfirmation = "Are your sure want to delete this phone ?"
        static let changeLocation = "Are you sure you want to change location?"
        static let deleteRota = "Are you sure you want to delete this rota?"
    }
    
    struct  EmptyDataMessage {
        static let noCategory = "No Result Found"
        static let noNotifications = "No Notifications found"
    }
    
    struct AlertMessage {
        static let passwordRecoveryMailSent = "If there exists an account for the supplied email address, you will be receiving a password reset link shortly"
        static let loginFailed = "Login failed"
        static let logoutConfirmation = "Are you sure you want to logout?"
        static let imageNotFoundMessage = "Selected image is not available in directory."
        static let documentNotFoundMessage = "Selected document is not available in directory."
        static let removeConfirmation = "Are you sure you want to remove?"
    }
    
    struct AlertButtons {
        static let okButton = "Ok"
        static let cancelButton = "cancel"
    }
    
    struct StaticPagesType {
        static let termsOfService = "Terms & Conditions"
        static let privacyPolicy = "Privacy Policy"
    }
    struct StringConstants{
        static let emptyMsg = "NA"
    }
    
    struct StatusCode{
        static let success = 200
        static let tokenExpire = 401
    }
    
    struct AppErrorCodes{
        static let tokenExpired = "FORBIDDEN"
    }
    
    struct UserDefaultsKeys{
        static let isResetPassword = "isResetPassword"
        static let isUserLogIn = "isUserlogin"
        static let accessToken  = "token"
        static let email = "email"
        static let password = "password"
        static let userId = "userId"
        static let user = "user"
        static let themeDetail = "themeDetail"
        static let socialUser = "socialUser"
        static let isGuideScreen = "isGuideScreen"
        static let fcmToken  = "fcmToken"
        static let onBoardStep = "onBoardStep"
        static let userType = "UserType"
        static let patient = "Patient"
        static let other = "Other"
        static let isPinAccessOn = "PinAccess"
        static let isBiomatricOrFaceIdAccessOn = "BiomatricOrFaceIdAccessOn"
        static let autoLogoutSecond = "autoLogoutSecond"
        static let autoLogoutName = "autoLogoutName"
        static let saveAppTerminateTime = "AppTerminateTime"
        static let isShowNotifications = "isShowNotifications"
    }
    
    
    enum Storyboard:String {
        case main                     =        "Main"
        case splash                   =        "Splash"
        case login                    =        "Login"
        case dashboard                =        "Dashboard"
        case home                     =        "Home"
        case bookings                 =        "Bookings"
        case messages                 =        "Messages"
        case themeReel                =        "ThemeReel"
        case profile                  =        "Profile"
        case more                     =        "More"
        case signup                   =        "SignUp"
        case sideMenu                 =        "SideMenu"
        case settings                 =        "Settings"
        case appointment              =        "Appointment"
        case invitation               =        "Invitation"
        case weddingTheme             =        "WeddingTheme"
        case photoSlider              =        "PhotoSlider"
        case paymentCard              =        "PaymentCard"
        case task                     =        "Task"
        case advertisement            =        "Advertisement"
        case onBoarding               =        "OnBoarding"
    }
    
    enum SocialProvider: String{
        case facebook = "facebook"
        case google = "google"
        case apple = "apple"
    }
    
    enum SocialType: String {
        case facebook = "facebook"
        case google = "google"
        case apple = "apple"
    }
    
    enum UserType: String {
        case couple = "couple"
        case wedPlanner = "wedPlanner"
    }
    
    struct TabBar{
        static let home = 0
        static let group = 1
        static let messages = 2
        static let more = 3
    }
    
    struct FacebookParameter {
        static let permissions = ["public_profile", "email"]
        static let parameters = ["fields":"id,first_name,last_name,middle_name,name,name_format,short_name,email,picture.width(480).height(480)"]
    }

   
   
}




