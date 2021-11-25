//
//  NoDoubtsApp.swift
//  NoDoubtsWatchApp Extension
//
//  Created by Qazi on 05/10/2021.
//

import SwiftUI

@main
struct NoDoubtsApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                HealthData()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
