//
//  StrengthDetailView.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 25/08/2021.
//

import SwiftUI

struct StrengthDetailView: View {
    @ObservedObject var strengthList = StrengthViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        loadView().onAppear(){
            strengthList.ApiStrengthList()
        }
    }
}

struct StrengthDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StrengthDetailView()
    }
}
//    MARK:- View Extension
extension StrengthDetailView{
    func loadView() -> some View {
        LoadingView(isShowing: $strengthList.loading) {
        VStack(alignment: .center) {
            BackButtonView()
            allStrengthDetails()
            Spacer()
            
        }.padding().modifier(BannerModifier(model: $strengthList.model)).navigationBarHidden(true)
        }
        
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
            })
           
                    Text("Strength")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                
                
                Spacer()
                    HStack(spacing: 22){
                        Image("filter").resizable().frame(width: 28 , height: 28)
                        Image("plusIcon").resizable().frame(width: 22 , height: 22)
                    }.padding(.trailing , 20)
                    
                
        }.frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
            
            
            Divider()
            
        }
    }
    //MARK:- All strength details
    func allStrengthDetails() -> some View{
        
        ForEach(strengthList.StrengthList?.data?.indices ?? 0..<0 , id: \.self){ item in
            ZStack(alignment: .leading) {
          
            Rectangle()
                .fill(Color.white)
                .frame(height: 75)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            
            
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(strengthList.StrengthList?.data?[item].name ?? "")
                    
                    .background(Color.white)
                    .foregroundColor(Color.black)
                  //  .padding([.trailing, .top, .bottom])
                    .font(.custom("Poppins-Medium", size: 14))
                HStack{
                Text(strengthList.StrengthList?.data?[item].date ?? "")
                    
                    .background(Color.white)
                    .foregroundColor(Color("light"))
                    
                    .font(.custom("Poppins-Medium", size: 14))
                    Spacer()
                    Text("\(strengthList.StrengthList?.data?[item].duration ?? "") Min")
                        
                        .background(Color.white)
                        .foregroundColor(Color("light"))
                        
                        .font(.custom("Poppins-Medium", size: 14))
                }
            }.padding([.leading, .trailing] , 10)
        }
            
        }
    }
}
