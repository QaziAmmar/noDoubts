//
//  AppDelegate.swift
//  NoDoubts
//
//  Created by Qazi on 25/10/2021.
//

import Foundation
import SwiftUI
import GoogleMaps
import GoogleSignIn
class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       
        GMSServices.provideAPIKey("AIzaSyDSQAAHpSSlAg9BUKVxHTry_l5qcgbu4zM")
        GIDSignIn.sharedInstance().serverClientID = "99295727751-u8q59cd68u35lnaiqood5j1ragnp3phl.apps.googleusercontent.com"
               
        return true
    }
}
