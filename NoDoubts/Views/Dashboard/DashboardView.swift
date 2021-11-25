//
//  DashboardView.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 20/08/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DashboardView: View {
    @State private var moveToRunningView: Bool = false
    @State private var moveToCompetitionView: Bool = false
    @State private var moveToGoalList: Bool = false
    @State private var moveToAboutUs: Bool = false
    
    @State private var movetoStrengthList: Bool = false
    @State private var moveToProfileView: Bool = false
    @State private var userProfile: String = ""
    @StateObject var DashBoard = DashBoardViewModel()
    var body: some View {
        NavigationView{
        LoadingView(isShowing: $DashBoard.loading) {
//            ScrollView{
        VStack{
            imageSetting()
            
            mainSetting().padding(.top , 0)
            runningSwimmingDetails().padding(.top , 0)
            SetGHoalButton()
            AboutButton()
            Group{
            gotoRunning
            gotoCompetition
            gotoGoalList
            gotoAboutUs
            gotoStrengthView
            gotoProfileView
            }.hidden()
            Spacer()
//        }
        }.onAppear(){
            if DashBoard.isCalledApi{
            DashBoard.ApiDashBoard()
            }
           let profile = AppHelper.helper.loadMyUser()
            userProfile = profile?.data?.image ?? ""
        }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
//            }
        }
    }.navigationBarHidden(true)
}
    //MARK:- Dashboard
    fileprivate func imageSetting() -> some View {
        HStack{
            Text("Dashboard").font(.custom("Poppins-Bold", size: 18))
            Spacer()
            Button(action: {
                moveToProfileView.toggle()
                          }){
                WebImage(url:URL(string: userProfile)).resizable().placeholder(Image("Profile Picture")).clipShape(Circle()).shadow(radius: 4).frame(width: 70 , height: 70).padding(.leading , 5)
            }
        }.padding()
    }
    //MARK:- Dashboard
    fileprivate func mainSetting() -> some View {
        HStack(spacing: 0){
            ZStack(alignment: .leading) {
                
                Rectangle()
                    //.fill(Color("DashBoardFillColor"))
                    .frame(height: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("DashBoardFillColor"), lineWidth: 0.1)
                    ).cornerRadius(15)
                
                
                
                HStack {
                    Image("flamenco-uploading 1").resizable().frame(width: 150 , height: 150).padding(.leading , -10).padding(.top , -50)
                    
                    Text(DashBoard.Dash?.data?.quotation ?? "")
                        
                        .background(Color("DashBoardFillColor"))
                        .foregroundColor(Color.black)
                        .padding([.trailing, .top, .bottom]).padding(.leading, -16)
                        .font(.custom("Poppins-Medium", size: 17.06))
                }
                
            }.foregroundColor(Color("DashBoardFillColor"))
            
        }.padding()
    }
    //MARK:- Details
    fileprivate func runningSwimmingDetails() -> some View {
        VStack(spacing: 0){
            HStack(spacing: 20){
                ZStack(alignment: .topLeading){
                    Text("Statistic").foregroundColor(Color("StatisticColor")).font(.custom("Poppins-Medium", size: 14.5)).padding()
                Image("statistic").resizable().frame(height: 120)
                   
                    HStack{
                        Image("StatisticLogo 1").resizable().frame(width: 24 , height: 24)
                        Spacer()
                        Text(DashBoard.Dash?.data?.goal ?? "").font(.custom("Poppins-SemiBold", size: 18)).foregroundColor(Color("StatisticColor"))
               
                        
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .leading).frame(height: 30).padding([.leading , .trailing] , 15).padding(.top , 75)
                    
                }
                Button(action: {
                                 moveToRunningView.toggle()
                              }){
                ZStack(alignment: .topLeading){
//
                    Text("Running").foregroundColor(Color("LogoutButtonColor")).font(.custom("Poppins-Medium", size: 14.5)).padding()
                Image("Running").resizable().frame(height: 120)
                    HStack{
                        Image("RunningLogo").resizable().frame(width: 24 , height: 24)
                        Spacer()
                        Text("\(DashBoard.Dash?.data?.running ?? "") KM").font(.custom("Poppins-SemiBold", size: 18)).foregroundColor(Color("LogoutButtonColor"))
               
                        
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .leading).frame(height: 30).padding([.leading , .trailing] , 15).padding(.top , 75)
                }
                   
                }

            }.padding()
            
            HStack(spacing: 20){
                Button(action: {
                    movetoStrengthList.toggle()
                              }){
                ZStack(alignment: .topLeading){
                    Text("Strength").foregroundColor(Color("StrengthColor")).font(.custom("Poppins-Medium", size: 14.5)).padding()
                Image("Swimming").resizable().frame(height: 120)
                    HStack{
                        Image("strengthLogo").resizable().frame(width: 24 , height: 24)
                        Spacer()
                        Text(DashBoard.Dash?.data?.strength ?? "").font(.custom("Poppins-SemiBold", size: 18)).foregroundColor(Color("StrengthColor"))
               
                        
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .leading).frame(height: 30).padding([.leading , .trailing] , 15).padding(.top , 75)
                }
                }
                Button(action: {
                                 moveToCompetitionView.toggle()
                              }){
                ZStack(alignment: .topLeading){
                    Text("Competition").foregroundColor(Color("Competition")).font(.custom("Poppins-Medium", size: 14.5)).padding()
                Image("Competition").resizable().frame(height: 120)
                    HStack{
                        Image("CompetitionLogo").resizable().frame(width: 24 , height: 24)
                        Spacer()
                        Text(DashBoard.Dash?.data?.competition ?? "").font(.custom("Poppins-SemiBold", size: 18)).foregroundColor(Color("Competition"))
               
                        
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .leading).frame(height: 30).padding([.leading , .trailing] , 15).padding(.top , 75)
                }
                }
                
            }.padding()
        }
        
   }
    //MARK:- SetGoal Button
    fileprivate func SetGHoalButton() -> some View {
         Button(action: {
            moveToGoalList.toggle()
           
            
        }, label: {
            ZStack(alignment: .trailing){
            Text("Goal")
                .font(Font.custom("Poppins-Bold", size: 16))
                .frame(minWidth : 0 , maxWidth: .infinity)
                .frame(height: 55)
                    .foregroundColor(Color.white)
                Image("ArrowRight").resizable().frame(width: 20, height: 20).padding()
            }
            
            
        })
         .background(Color("fg"))
         .cornerRadius(6)
         .frame(height : 55)
         .padding([.top ] ,5)
         .padding([.leading , .trailing] , 16)
    }
    //MARK:- about Button
    fileprivate func AboutButton() -> some View {
         Button(action: {
           
            moveToAboutUs.toggle()
            
        }, label: {
            ZStack(alignment: .trailing){
            Text("About")
                .font(Font.custom("Poppins-Bold", size: 16))
                .frame(minWidth : 0 , maxWidth: .infinity)
                .frame(height: 55)
                    .foregroundColor(Color.white)
                Image("ArrowRight").resizable().frame(width: 20, height: 20).padding()
            }
            
            
        })
         .background(Color("fg"))
         .cornerRadius(6)
         .frame(height : 55)
         .padding([.top], 5).padding([.leading , .trailing] , 16)
    }
    //MARK:- Linking
    private var gotoRunning : some View {
        
        NavigationLink(destination: RunningView(),isActive: $moveToRunningView,
                       label: {
                        Text("")
                       })
        
    }
    //MARK:- Link to competition
    private var gotoCompetition : some View {
        
        NavigationLink(destination: CompetitionListView(),isActive: $moveToCompetitionView,
                       label: {
                        Text("")
                       })
        
    }
    //MARK:- Link to goal
    private var gotoGoalList : some View {
        
        NavigationLink(destination: AllGoalListView(),isActive: $moveToGoalList,
                       label: {
                        Text("")
                       })
        
    }
    //MARK:- Link to About Us
    private var gotoAboutUs : some View {
        
        NavigationLink(destination: AboutUsView(),isActive: $moveToAboutUs,
                       label: {
                        Text("")
                       })
        
    }
    //MARK:- Link to Profile
    private var gotoProfileView : some View {
        
        NavigationLink(destination: ProfileView(),isActive: $moveToProfileView,
                       label: {
                        Text("")
                       })
        
    }
    //MARK:- Link to Strength
    private var gotoStrengthView : some View {
        
        NavigationLink(destination: StrengthDetailView(),isActive: $movetoStrengthList,
                       label: {
                        Text("")
                       })
        
    }
    
    
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
