//
//  AboutUsView.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 25/08/2021.
//

import SwiftUI

struct AboutUsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
      loadView()
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}

//    MARK:- View Extension
extension AboutUsView{
    func loadView() -> some View {
        VStack(alignment: .center) {
            BackButtonView()
            Logo()
            SocialIcons()
            Spacer()
           
        }.padding().navigationBarHidden(true)
        
    }
    //MARK:- Back Button
    fileprivate func BackButtonView() -> some View {
        
        VStack(alignment: .leading) {
            HStack{
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                
                    Image("back_arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
            }).padding(.leading , 20)
                .padding([.leading], -30)
                    Text("About Us")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                
                
            }
            
            Divider()
            
        }
    }
    //MARK:- Logo Data
    fileprivate func Logo () -> some View {
        
        VStack(spacing: 15) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72, alignment: .center)
            Text("NoDoubts is a brand for a company thats provide plantbased nutrition mainly for athletes in performance sport. Want to learn more about the products we provide").multilineTextAlignment(.center).font(.custom("Poppins-Regular", size: 12))
            
        }.padding()
    }
    //MARK:- Social Icons
    fileprivate func SocialIcons () -> some View {
        HStack(spacing: 15){
            Image("facebook").resizable().frame(width: 24 , height: 24)
            Image("google").resizable().frame(width: 24 , height: 24)
            Image("youtube").resizable().frame(width: 24 , height: 24)
            Image("instagram").resizable().frame(width: 24 , height: 24)
            
        }
    }
}
