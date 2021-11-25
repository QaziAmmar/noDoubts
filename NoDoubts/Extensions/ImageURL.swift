//
//  ImageURL.swift
//  MyFavoutiteFoods
//
//  Created by Shanker Jadav on 4/4/21.
//

import Foundation
import SwiftUI
import GoogleSignIn

struct URLImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    
    var placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "")) {
        self.placeholder = placeholder
        self.imageLoader.load(url: url)
    }
    
    var body: some View {
        if let uiImage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiImage).resizable()
        } else {
            return placeholder
        }
    }
    
}
//MARK:- SIGN In with Google

class GoogleStuff: UIViewController, GIDSignInDelegate, ObservableObject {
    @Published var doneGettingData = false
    var googleSignIn = GIDSignIn.sharedInstance()
    var googleId = ""
    var googleIdToken = ""
    var googleFirstName = ""
    var googleLastName = ""
    var googleEmail = ""
    var googleProfileURL = ""
    
    
    @State var model: BannerData?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        guard user != nil else {
            print("Uh oh. The user cancelled the Google login.")
            return
        }
        
        print("TOKEN => \(user.authentication.idToken!)")
        let token = user.authentication.idToken!
        let name = user.profile?.name ?? ""
        let email = user.profile?.email ?? ""
        googleIdToken = token
        googleFirstName = name
        googleEmail = email
       
        self.doneGettingData = true
      // APISocialLogin(social_key: "google", email: email, name: name, social_token: token)
       // viewModel.APISocialLogin(social_key: "google", email: email, name: name, social_token: token)
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        guard user != nil else {
            print("Uh oh. The user cancelled the Google login.")
            return
        }
        
        print("TOKEN => \(user.authentication.idToken!)")
        
    }
   
    
}
