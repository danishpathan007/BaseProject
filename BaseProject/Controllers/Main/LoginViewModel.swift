//
//  LoginViewModel.swift
//  APIHelperDemo
//
//  Created by Danish on 06/06/22.
//

import Foundation

// MARK: - Welcome
struct LoginModel: Codable {
    let success: Bool?
    let status: Int?
    let data: DataClass?
    let offset, message: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    let token: String?
    let userInfo: UserInfo?
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let isSuspended: Bool?
    let lastName, locationName: String?
    let otp: String?
    let bio: String?
    let userImage: String?
    let countryCode: String?
    let latitude: Double?
    let groomName, phoneNumber: String?
    let userID: Int?
    let isBioSaved, hasActiveSubscription: Bool?
    let budgetTo: Int?
    let qrCodeImage: String?
    let noOfGuest, budgetFrom, countryID: Int?
    let brideName, experience: String?
    let longitude: Double?
    let isShowNotifications: Bool?
    let countryName, stripeAccountID, firstName, emailID: String?
    let isSocialLogin: Bool?
    let roleID: Int?

    enum CodingKeys: String, CodingKey {
        case isSuspended, lastName, locationName, otp, bio, userImage, countryCode, latitude, groomName, phoneNumber
        case userID
        case isBioSaved, hasActiveSubscription, budgetTo, qrCodeImage, noOfGuest, budgetFrom
        case countryID
        case brideName, experience, longitude, isShowNotifications, countryName
        case stripeAccountID
        case firstName
        case emailID
        case isSocialLogin
        case roleID
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}




//func getProfile(handler: @escaping ( _ loginModel: LoginModel?, _ error: AlertMessage?)->()) {
//
//    let parm = ["countryId": 2,
//                "email": "",
//                 "phoneNumber": "9690739077",
//                 "password": "123456",
//                 "deviceType": "iOS",
//                 "deviceAddress": "E96CEA5B-8E59-4E35-9519-AB2F1CBF2B5C",
//                 "fcmToken": "cXmbmFFxo0KZudsd5G72tP:APA91bFQt47XfFYIqOFg5ZugMVP1jyRNGV1hBuGUVDF95nbDq1L7ghVIKkGQRhcgKmDQJywKB96VEgMib8LAWtQTaC6CRWmANt0j4_w5RSfM5ip8sajDzGSP8KuZICOxs8mgpFh0Yilq",
//                 "loginType": "phone",
//                 "roleId" : 2,
//                 "fbLinked": false,
//                 "googleLinked": false,
//                 "appleLinked": false,
//                 "fbLinkedId": "",
//                 "googleLinkedId": "",
//                 "appleLinkedId": ""
//    ] as [String : Any]
//
//    apiManager.call(type: EndpointItem.login,params: parm) { (loginModel: LoginModel?, message: AlertMessage?) in
//        if let loginModel = loginModel {
//            if loginModel.success ?? false {
//                print(loginModel.data?.token)
//            }else{
//                print("Error \(loginModel.message)")
//            }
//            handler(nil, nil)
//        } else {
//            handler(loginModel, message!)
//        }
//    }
//}
//
//
//func updateProfile(handler: @escaping ( _ loginModel: LoginModel?, _ error: AlertMessage?)->()) {
//
//
//    let parm = [ "LocationName": "Sector 82, Mohali", "Experience": "6", "FirstName": "Albertss", "LastName": "William", "Bio": "Wedding planner", "userId": "0", "CreatedBy": "0", "Latitude": "30.650385"]
//
//    let imageData = #imageLiteral(resourceName: "user").jpegData(compressionQuality: 0.75)
//
//    apiManager.upload(type: EndpointItem.saveUpdatePlannerProfile, params: parm, imageData: nil) { (loginModel: LoginModel?, message: AlertMessage?) in
//        if let loginModel = loginModel {
//            if loginModel.success ?? false {
//                print(loginModel.data?.token)
//            }else{
//                print("Error \(loginModel.message)")
//            }
//            handler(nil, nil)
//        } else {
//            handler(loginModel, message!)
//        }
//    }
//}
