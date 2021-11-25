//
//  RunningView.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 25/08/2021.
//

import SwiftUI

struct RunningView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var open = false
    @State var popoverSize = CGSize(width: 100, height: 100)
    @State private var MovetoAddRunning: Bool = false
    @ObservedObject var RunningView = RunningViewModel()
    var body: some View {
        loadView().onAppear(){
            RunningView.ApiCalling()
        }.navigationBarHidden(true)
    }
}

//struct RunningView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunningView()
//    }
//}
//    MARK:- View Extension
extension RunningView{
    func loadView() -> some View {
        LoadingView(isShowing: $RunningView.loading) {
        VStack(alignment: .center) {
            BackButtonView()
            ScrollView{
            AllRunningDetails()
            }
            gotoAddRunning
            Spacer()
            
        }.modifier(BannerModifier(model: $RunningView.model)).padding()
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
           
                    Text("Running")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                
                
                Spacer()
                Button(action: {
                    MovetoAddRunning.toggle()
                }){
                    Image("plusIcon").resizable().frame(width: 22 , height: 22).padding(.trailing, 20)
                }
                    
                
        }.frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
            
            
            Divider()
            
        }
    }
    //MARK:- All strength details
    func AllRunningDetails() -> some View{
        let h = VStack(spacing : 8) {
        if (RunningView.Running?.data?.count == nil){
            Text("No Data Found").padding().font(.custom("Poppins-Medium", size: 13))
                .foregroundColor(Color.primary)
        }else{
            
        
        
        
        ForEach(RunningView.Running?.data?.indices ?? 0..<0 , id: \.self){ item in
            ZStack(alignment: .leading) {
          
            Rectangle()
                .fill(Color.white)
                .frame(height: 75)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            
            
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 2){
                    Text("Running")
                    
                    .background(Color.white)
                    .foregroundColor(Color.black)
                  //  .padding([.trailing, .top, .bottom])
                    .font(.custom("Poppins-Medium", size: 14))
                    Spacer()
                    Image("stepsImage").resizable().frame(width: 15 , height: 15)
                    Text("Steps")
                        
                        .background(Color.white)
                        .foregroundColor(Color.black)
                      //  .padding([.trailing, .top, .bottom])
                        .font(.custom("Poppins-Medium", size: 10))
                }
                HStack{
                    Text(RunningView.Running?.data?[item].date ?? "")
                    
                    .background(Color.white)
                    .foregroundColor(Color("light"))
                    
                    .font(.custom("Poppins-Medium", size: 14))
                    Spacer()
                    Text(RunningView.Running?.data?[item].distance ?? "")
                        
                        .background(Color.white)
                        .foregroundColor(Color("light"))
                        
                        .font(.custom("Poppins-Medium", size: 14))
                }
            }.padding([.leading, .trailing] , 10)
        }
            
        }
        }
        }
        return h
    }
    //MARK:- Linking
    private var gotoAddRunning : some View {
        
        NavigationLink(destination: AddRunningView(value: $MovetoAddRunning),isActive: $MovetoAddRunning,
                       label: {
                        Text("")
                       })
        
    }
}

