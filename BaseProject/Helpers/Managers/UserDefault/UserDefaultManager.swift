//
//  UserDefaultManager.swift
//
//

import UIKit

public class UserDefaultManager {
	
	static let sharedManager = UserDefaultManager()
	private var userDefault:UserDefaults = UserDefaults.standard
	
    func addValue(object:Any,key:String,updateIfCan:Bool = false){
        if updateIfCan {
            userDefault.removeObject(forKey: key)
        }
        userDefault.set(object, forKey: key)
		userDefault.synchronize()
	}
	
    private struct Keys {
        let loggedInUser        : String = "loggedInUser"
        let guideScreenShown    : String = "guideScreenShown"
    }
    
    private let keys = Keys()
    
	func objectForKey(key:String) -> Any? {
		return userDefault.object(forKey: key) as AnyObject?
	}
    
    func addBoolValue(boolObject:Bool, key:String) {
          userDefault.set(boolObject, forKey: key)
    }
    
    func getBoolValue(key:String) -> Bool {
        return userDefault.bool(forKey:key)
    }
    
    func saveBoolValue(boolObject:Bool, key:String) {
        userDefault.set(boolObject, forKey: key)
    }
    
	func removeValue(key:String){
		userDefault.removeObject(forKey: key)
		userDefault.synchronize()
	}
    
    func setFCMToken(_ newFCMToken:String?) {
        guard let token = newFCMToken else {
            userDefault.removeObject(forKey: Constants.UserDefaultKey.fcmToken)
            return
        }
        userDefault.set(token, forKey: Constants.UserDefaultKey.fcmToken)
        userDefault.synchronize()
    }
    
    func getSocialLoginType() -> Constants.SocialType? {
        guard let stringValue = UserDefaults.standard.string(forKey: Constants.UserDefaultKey.socialType) else { return nil }
        return Constants.SocialType(rawValue: stringValue)
    }
    
    func getUserType() -> Constants.UserType? {
        guard let stringValue = UserDefaults.standard.string(forKey: Constants.UserDefaultKey.userType) else { return nil }
        return Constants.UserType(rawValue: stringValue)
    }
    
    func getUserRoleID() -> Int {
        guard let stringValue = UserDefaults.standard.string(forKey: Constants.UserDefaultKey.userType) else { return 0 }
        
        if Constants.UserType(rawValue: stringValue) == .couple {
            return 3
        }else if Constants.UserType(rawValue: stringValue) == .wedPlanner {
            return 2
        }else{
            return 0
        }
    }
    

    func showGuideScreen() -> Bool {
        if getBoolValue(key: keys.guideScreenShown) == false {
            return true
        }
        return false
    }
    
    func setGuideScreen(_ value: Bool) {
        saveBoolValue(boolObject: value, key: keys.guideScreenShown)
    }
    
}
