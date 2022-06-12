//
//  APIHelper.swift
//  APIHelperDemo
//
//  Created by WC IOS 01 on 01/06/22.
//

import Foundation
import UIKit
import Alamofire

class AlertMessage {
    var title = "Error"
    var body = "Somthing Went Wrong."
    
    init(title:String,body:String) {
        self.title = title
        self.body = body
    }
}

class ErrorObject: Codable {
    let success: Bool
    let message: String
    let status: Int?
    let offset:String
}

protocol EndPointType {
    // MARK: - Vars & Lets -
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
}

enum NetworkEnvironment {
    case dev
    case production
    case stage

}

enum EndpointItem {
    // MARK: - User actions apis -
    case profile
    case updateUser
    case userExists(_: String)
    case login
    case saveUpdatePlannerProfile
    case getDashboardFeeds(_: String)
}

// MARK: - EndPointType
extension EndpointItem: EndPointType {
    
    // MARK: - Vars & Lets -
    
    var baseURL: String {
        switch APIManager.networkEnviroment {
        case .dev: return "https://api.test.com/dev/"
        case .production: return "https://api.test.com/prod/"
        case .stage: return "https://api.test.com/staging/"
        }
    }
    
    var version: String {
        return "/v0_1"
    }
    
    var path: String {
        switch self {
        case .getDashboardFeeds(let pageNo):
            return "herby/Herbydashboard?per_page=10" + "&page=\(pageNo)"
        case .profile:
            return "user/profile"
        case .saveUpdatePlannerProfile:
            return "SaveUpdatePlannerProfile"
        case .updateUser:
            return "user/update"
        case .userExists(let email):
            return "/user/check/\(email)"
        case .login:
            return "Login"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .updateUser,.login:
            return .post
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
        
        switch self {
        case .saveUpdatePlannerProfile:
            return  ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IiIsIlVzZXJJZCI6IjE1OCIsIlJvbGVJZCI6IjIiLCJQaG9uZU51bWJlciI6Ijk2OTA3MzkwNzciLCJTdHJpcGVBY2NvdW50SWQiOiIiLCJVc2VyTmFtZSI6IkFsYmVydCBXaWxsaWFtIiwianRpIjoiOTY0MWRmMWMtZDU3MS00ZWMxLWJlYTEtNjE4NGI3YjRlN2FlIiwiZXhwIjoxNjU0MTY2MTc2LCJpc3MiOiJXZWRncmFtIiwiYXVkIjoiV2VkZ3JhbSJ9.OcUNRnMtj0BHpwMARBX0BVpYuRoboSB7Cj_65Bc5Khk",
                     "Content-Type": "application/json",
                     "Time-Zone": localTimeZoneIdentifier]
        case .login :
            return ["Time-Zone": localTimeZoneIdentifier]
        case .profile, .updateUser:
            return ["Content-Type": "application/json",
                    "X-Requested-With": "XMLHttpRequest",
                    "x-access-token": "someToken"]
        default:
            return ["Authorization": "Bearer 086241ade2f89ddf83c9c26aa466abbf02547e53ee9f14e938f5b96e524ef1a4501046185cd9716ba5002164a420b55017520ad5799ff78b7a69c40c2dc6673f",
                    "Content-Type": "application/x-www-form-urlencoded"]
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}


class APIManager {
    // MARK: - Vars & Lets -
    
    private let sessionManager: Session
    static let networkEnviroment: NetworkEnvironment = .dev
    
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(sessionManager: Session())
        
        return apiManager
    }()
    
    // MARK: - Accessors -
    
    class func shared() -> APIManager {
        return sharedApiManager
    }
    
    // MARK: - Initialization -
    
    private init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }

    
    func call<T>(type: EndPointType, params: Parameters? = nil,isLoaderHidden:Bool = false, handler: @escaping (T?, _ error: AlertMessage?)->()) where T: Codable {
        
        /*
         Show Loader
         */
        if !isLoaderHidden {
            Loader.sharedInstance.startIndicatingActivity()
        }
        
        if !Reachability.isConnectedToNetwork(){
            return
        }
        
        Logger.log("URL : \(type.url)")
        Logger.log("Request Method : \(type.httpMethod)")
        Logger.log("Request Parm : \(String(describing: params))")
        Logger.log("Header : \(String(describing: type.headers))")
        
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate(statusCode: 200..<500).response { data in
            /*
             Hide Loader
             */
            Loader.sharedInstance.stopIndicatingActivity()
            
            switch data.result {
            case .success(_):
                let decoder = JSONDecoder()
                if let jsonData = data.data {
                    do {
                        if let statusCode = data.response?.statusCode {
                            if statusCode == Constants.StatusCode.tokenExpire {
                                Logger.log("Token Expire or unAuthorized user.")
                                /*
                                 Naviagte to Login Screen
                                 */
                                return
                            }
                        }
                        let result = try decoder.decode(T.self, from: jsonData)
                        let str = String(decoding: jsonData, as: UTF8.self)
                        print(str)
                        handler(result, nil)
                    }catch(let err)
                    {
                        handler(nil, AlertMessage(title: "", body: err.localizedDescription))
                    }
                }
                break
            case .failure(_):
                handler(nil, self.parseApiError(data: data.data))
                break
            }
        }
    }
    
    func upload<T>(type: EndPointType, params: [String : String],imageData:Data?,isLoaderHidden:Bool = false, handler: @escaping (T?, _ error: AlertMessage?)->()) where T: Codable {
        
        if !isLoaderHidden {
            Loader.sharedInstance.startIndicatingActivity()
        }
        
        if !Reachability.isConnectedToNetwork(){
            return
        }
        
        Logger.log("URL : \(type.url)")
        Logger.log("Request Method : \(type.httpMethod)")
        Logger.log("Request Parm : \(String(describing: params))")
        Logger.log("Header : \(String(describing: type.headers))")
        
        self.sessionManager.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "ProfilePic", fileName: "user.jpg", mimeType: "image/jpeg")
            }
        },to: type.url, headers: type.headers).validate(statusCode: 200..<500).response{ data in
            
            Loader.sharedInstance.stopIndicatingActivity()
            
            switch data.result {
                
            case .success(_):
                let decoder = JSONDecoder()
                if let jsonData = data.data {
                    do {
                        if let statusCode = data.response?.statusCode {
                            if statusCode == Constants.StatusCode.tokenExpire {
                                Logger.log("Token Expire or unAuthorized user.")
                                /*
                                 Naviagte to Login Screen
                                 */
                                return
                            }
                        }
                        let result = try decoder.decode(T.self, from: jsonData)
                        let str = String(decoding: jsonData, as: UTF8.self)
                        print(str)
                        handler(result, nil)
                    }catch(let err){
                        handler(nil, AlertMessage(title: "", body: err.localizedDescription))
                    }
                }
                break
            case .failure(_):
                handler(nil, self.parseApiError(data: data.data))
                break
            }
        }
    }
    
    private func parseApiError(data: Data?) -> AlertMessage {
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
            print("Error \(error.message)")
            return AlertMessage(title:"",body: error.message)
        }
        return AlertMessage(title: "", body: "Somthing Went Wrong.")
    }
    
}

