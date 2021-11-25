//
//  WatchDashBoard.swift
//  NoDoubtsWatchApp Extension
//
//  Created by Qazi on 05/10/2021.
//

import SwiftUI

struct WatchDashBoard: View {
    @State private var moveToGoal: Bool = false
    @State private var moveToCompetition: Bool = false
    @State private var moveToAddRunning: Bool = false
    var body: some View {
        
            
        VStack(spacing: 15){
            ScrollView(showsIndicators: true){
            Statistics()
            Running()
            StrengthView()
               
            CompetitionView()
                GoalButton()
//                Group{
                    GoToGoal.frame(height: 0).hidden()
                goToCompetition.frame(height: 0).hidden()
                goToAddRunning.frame(height: 0).hidden()
//                }
            Spacer()
            }
        } .navigationTitle("Menu").edgesIgnoringSafeArea(.all).padding(.top , 1)
        
    }
    //MARK:- Statistics data
    fileprivate func Statistics() -> some View {
         // VStack Top Logo
        Button(action:{
            //moveToGoal.toggle()
        }){
            
                    HStack{
                    HStack(spacing: 8){
                        Image("Watch Statistic Logo").resizable().frame(width: 19 , height: 15).padding(.leading , 7)
                    
                    Text("Statistics").font(.custom("Poppins-Bold", size: 8))
                        
                    }
                        Spacer()
                    Image("nextArrow").resizable().frame(width: 3, height: 5).padding(.trailing , 15)
                    }.frame(minWidth: 185, maxWidth: .infinity, minHeight: 45, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).background(Color("StatisticColor"))
            // :ZStack Email
           
             
        }
        .frame(height: 35).background(Color.clear).cornerRadius(4)
    }
    //MARK:- Running data
    fileprivate func Running() -> some View {
         // VStack Top Logo
        Button(action:{
            moveToAddRunning.toggle()
        }){
            
                HStack{
                HStack(spacing: 8){
                    Image("WatchRunning").resizable().frame(width: 14 , height: 18).padding(.leading , 7)
                
                Text("Running").font(.custom("Poppins-Bold", size: 8))
                    
                }
                    Spacer()
                Image("nextArrow").resizable().frame(width: 3, height: 5).padding(.trailing , 15)
                }.frame(minWidth: 185, maxWidth: .infinity, minHeight: 45, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).background(Color("RunningColor")) // :ZStack Email
            
        
        }.frame(height: 35).background(Color.clear).cornerRadius(4)
    }
    //MARK:- Strength data
    fileprivate func StrengthView() -> some View {
         // VStack Top Logo
        Button(action:{
            //moveToGoal.toggle()
        }){
        
                HStack{
                HStack(spacing: 8){
                    Image("WatchStrength").resizable().frame(width: 14 , height: 18).padding(.leading , 7)
                
                Text("Strength").font(.custom("Poppins-Bold", size: 8))
                    
                }
                    Spacer()
                Image("nextArrow").resizable().frame(width: 3, height: 5).padding(.trailing , 15)
                }.frame(minWidth: 185, maxWidth: .infinity, minHeight: 45, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).background(Color("StrengthColor")) // :ZStack Email
        }.frame(height: 35).background(Color("StrengthColor")).cornerRadius(4)
    }
    //MARK:- Competition data
    fileprivate func CompetitionView() -> some View {
         // VStack Top Logo
        Button(action:{
            moveToCompetition.toggle()
        }){
            HStack{
            HStack(spacing: 8){
                Image("WatchCompetition").resizable().frame(width: 14 , height: 18).padding(.leading , 7)
            
            Text("Competition").font(.custom("Poppins-Bold", size: 8))
                
            }
                Spacer()
                Image("nextArrow").resizable().frame(width: 3, height: 5).padding(.trailing , 15)
            }.frame(minWidth: 185, maxWidth: .infinity, minHeight: 45, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).background(Color("CompetitionColor"))
        }.frame(height: 35).background(Color.clear).cornerRadius(4)
    }
    //MARK:- Goal Button
    fileprivate func GoalButton() -> some View {
         // VStack Top Logo
            
        Button(action:{
            moveToGoal.toggle()
        }){
            HStack{
            HStack(spacing: 8){
               
            
                Text("Goals").font(.custom("Poppins-Bold", size: 8)).foregroundColor(.black).font(.custom("Poppins-Bold", size: 8))
                
            }
                Spacer()
                Image("BlackNextArrow").resizable().frame(width: 3, height: 5).padding(.trailing, -40)
            }.padding()
        }.frame(height: 35).background(Color(.white)).cornerRadius(4)
    }
    //MARK:- Linking
    private var GoToGoal : some View {
        
        NavigationLink(destination: AddGoalView(),isActive: $moveToGoal,
                       label: {
                        Text("")
                       })
        
    }
    //MARK:- Linking
    private var goToCompetition : some View {
        
        NavigationLink(destination: WatchAddCompetition(),isActive: $moveToCompetition,
                       label: {
                        Text("")
                       })
        
    }
    //MARK:- Linking
    private var goToAddRunning : some View {
        
        NavigationLink(destination: AddRunningView(),isActive: $moveToAddRunning,
                       label: {
                        Text("")
                       })
        
    }

}

struct WatchDashBoard_Previews: PreviewProvider {
    static var previews: some View {
        WatchDashBoard()
    }
}


