//
//  AppHelper.helper.swift
//  Wellyx
//
//  Created by admin on 12/07/2018.
//  Copyright © 2018 Edward Milton and Co. All rights reserved.
//

import UIKit
import SwiftUI
import Combine


class AppHelper : NSObject {
    
    static let helper = AppHelper()
    
    override init() {}
    
}


//MARK:- Data Functions

extension AppHelper{
    
    
     func loadMyUser()->SignUpModels?{

        if let data = UserDefaults.standard.value(forKey:"user") as? Data {
            let decoder = JSONDecoder()
            let user =  try? decoder.decode(SignUpModels.self, from: data)
            return user
        }

        return nil
    }
     func saveMyUser(_ signUp:SignUpModels){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(signUp) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "user")
        }
    }
    func removeMyUser(){
        UserDefaults.standard.removeObject(forKey: "user")
    }
   
  
    
    
}


