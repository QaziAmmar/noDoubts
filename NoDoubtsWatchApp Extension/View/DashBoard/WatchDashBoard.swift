//
//  WatchDashBoard.swift
//  NoDoubtsWatchApp Extension
//
//  Created by Qazi on 05/10/2021.
//

import SwiftUI

struct WatchDashBoard: View {
    var body: some View {
        VStack{
            Statistics()
            Spacer()
        }.padding()
    }
    //MARK:- Statistics data
    fileprivate func Statistics() -> some View {
         // VStack Top Logo
            
            VStack {
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .fill(Color("StatisticColor"))
                        .frame(height: 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color("StatisticColor"), lineWidth: 0.5)
                        ).cornerRadius(5)
                    
                    Text("Statistics").font(.custom("Poppins-Bold", size: 6)).padding()
                } // :ZStack Email
            // :ZStack Password
            }
    }
    //MARK:- Statistics data
    fileprivate func Running() -> some View {
         // VStack Top Logo
            
            VStack {
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .fill(Color("StatisticColor"))
                        .frame(height: 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.white, lineWidth: 0.5)
                        )
                    
                    Text("Running").font(.custom("Poppins-Bold", size: 6))
                } // :ZStack Email
            // :ZStack Password
            }
    }

}

struct WatchDashBoard_Previews: PreviewProvider {
    static var previews: some View {
        WatchDashBoard()
    }
}
