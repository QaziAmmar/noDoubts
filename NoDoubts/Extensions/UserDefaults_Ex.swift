//
//  UserDefaults.swift
//  F5
//
//  Created by Qazi Ammar Arshad on 14/06/2021.
//

import Foundation
import SwiftUI

enum UserDefaultEnum: String {
    case email
    case password
    case name
    case id
    case token
    case is_using_app_first_time
    case isUserRateAvailable
    case coupon
    
//    Rate Enums
    case faith
    case friendship
    case fidelity
    case fun
    case fluid
    case finance
    case fellatio
    case feelings
    case fitness
    case food
    case fine
    case fashion
    case function
    case fucking
    case fortitude
    case family
             
}

//class UserDefaults_Ex {
//    
//    
//    //    Save login details to userDefaults.
//    static let standard = UserDefaults_Ex()
//    
//    func saveUserDetailsToUserDefaults(userData: LoginModel) {
//        UserDefaults.standard.setValue(userData.data?.email, forKey: UserDefaultEnum.email.rawValue)
//        UserDefaults.standard.setValue(userData.data?.id, forKey: UserDefaultEnum.id.rawValue)
//        UserDefaults.standard.setValue(userData.data?.token, forKey: UserDefaultEnum.token.rawValue)
//        UserDefaults.standard.setValue(userData.data?.name, forKey: UserDefaultEnum.name.rawValue)
//        UserDefaults.standard.setValue(userData.data?.isUserRateAvailable, forKey: UserDefaultEnum.isUserRateAvailable.rawValue)
//        UserDefaults.standard.setValue(userData.data?.coupon, forKey: UserDefaultEnum.coupon.rawValue)
//    }
//    
//    func isUserDefaultsEmpty() -> Bool {
//        
//        if UserDefaults.standard.value(forKey: UserDefaultEnum.id.rawValue) == nil {
//            return true
//        } else {
//            return false
//        }
//    }
//    
//    func clear_login_details() {
//        //        At time of logout remove all the userdefaults data.
//        UserDefaults.standard.removeObject(forKey: UserDefaultEnum.email.rawValue)
//        UserDefaults.standard.removeObject(forKey: UserDefaultEnum.id.rawValue)
//        UserDefaults.standard.removeObject(forKey: UserDefaultEnum.token.rawValue)
//        UserDefaults.standard.removeObject(forKey: UserDefaultEnum.name.rawValue)
//        UserDefaults.standard.removeObject(forKey: UserDefaultEnum.isUserRateAvailable.rawValue)
//        UserDefaults.standard.removeObject(forKey: UserDefaultEnum.coupon.rawValue)
//        print("Clearing UserDefaults data")
//        clear_rating_details()
//    }
//    
//    func clear_rating_details() {
//        //        At time of logout remove all the userdefaults data.
//        for list in RateViewModel().rateArray {
//            UserDefaults.standard.removeObject(forKey: list)
//        }
//        
//        print("Clearing Rating data data")
//    }
//    
//    
//    func is_using_app_first_time() -> Bool {
//        /**
//         This function is use to show the walk through pages at the start of the app
//         */
//        
//        if UserDefaults.standard.value(forKey: UserDefaultEnum.is_using_app_first_time.rawValue) == nil {
//            return true
//        } else {
//            return false
//        }
//    }
//    
//    
//    func isRateAvailable() -> Bool {
//        /**
//         If use has not added his rate then this function return false
//         */
//        return UserDefaults.standard.bool(forKey: UserDefaultEnum.isUserRateAvailable.rawValue)
//    }
//    
//    
//}
