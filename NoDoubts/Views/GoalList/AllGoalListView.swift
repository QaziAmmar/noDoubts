//
//  AllGoalListView.swift
//  NoDoubts
//
//  Created by Qazi on 21/09/2021.
//

import SwiftUI

struct AllGoalListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var GoalList = GoalListViewModel()
    var body: some View {
        loadView()
    }
}
extension AllGoalListView{
    func loadView() -> some View {
        LoadingView(isShowing: $GoalList.loading) {
        VStack(alignment: .center) {
            BackButtonView()
            ScrollView{
            CompetitionList()
            }
            Spacer()
            
        }.padding().onAppear(){
            GoalList.ApiGoalList()
        }.navigationBarHidden(true)
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
           
                    Text("Goals")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                
                
                Spacer()
                    HStack(spacing: 22){
                       
                        Image("plusIcon").resizable().frame(width: 22 , height: 22)
                    }.padding(.trailing , 20)
                    
                
        }.frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
            
            
            Divider()
            
        }
    }
    //MARK:- Competition List
    func CompetitionList() -> some View{
        
        ForEach(GoalList.goalList?.data?.indices ?? 0..<0 , id: \.self){ item in
            ZStack(alignment: .leading) {
          
            Rectangle()
                .fill(Color.white)
                .frame(height: 85)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Text(GoalList.goalList?.data?[item].name
                     ?? "")
                    
                    .background(Color.white)
                    .foregroundColor(Color.black)
                  //  .padding([.trailing, .top, .bottom])
                    .font(.custom("Poppins-Medium", size: 14))
                    Spacer()
                    Text("Mark as Done").font(.custom("Poppins-Medium", size: 10)).padding(.trailing , 5)
                }
                
              
                Text(GoalList.goalList?.data?[item].description ?? "").multilineTextAlignment(.leading)
                    
                    .background(Color.white)
                    .foregroundColor(Color("light"))
                    
                    .font(.custom("Poppins-Medium", size: 14))
                
                   
                }.padding([.leading, .trailing] , 10)
        }
            
        }
    }
}

struct AllGoalListView_Previews: PreviewProvider {
    static var previews: some View {
        AllGoalListView()
    }
}
