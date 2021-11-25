//
//  NoDoubtsApp.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 17/08/2021.
//

import SwiftUI

@main
struct NoDoubtsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            if AppHelper.helper.loadMyUser() != nil{
                DashboardView()
            }else{
                LoginView()
            }
        }
    }
}
