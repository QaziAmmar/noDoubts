//
//  CompetitionListView.swift
//  NoDoubts
//
//  Created by Qazi on 04/09/2021.
//

import SwiftUI

struct CompetitionListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var competitionList = CompetitionListViewModel()
    var body: some View {
        loadView()
    }
}
extension CompetitionListView{
    func loadView() -> some View {
        LoadingView(isShowing: $competitionList.loading) {
        VStack(alignment: .center) {
            BackButtonView()
            ScrollView{
            CompetitionList()
            }
            Spacer()
            
        }.padding().onAppear(){
            competitionList.ApiCalling()
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
           
                    Text("Competition")
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
    //MARK:- Competition List
    func CompetitionList() -> some View{
        
        ForEach(competitionList.Comp?.data?.indices ?? 0..<0 , id: \.self){ item in
            ZStack(alignment: .leading) {
          
            Rectangle()
                .fill(Color.white)
                .frame(height: 75)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            VStack(alignment: .leading, spacing: 10) {
                Text(competitionList.Comp?.data?[item].title ?? "")
                    
                    .background(Color.white)
                    .foregroundColor(Color.black)
                  //  .padding([.trailing, .top, .bottom])
                    .font(.custom("Poppins-Medium", size: 14))
                
              
                Text(competitionList.Comp?.data?[item].date ?? "")
                    
                    .background(Color.white)
                    .foregroundColor(Color("light"))
                    
                    .font(.custom("Poppins-Medium", size: 14))
                   
                }.padding([.leading, .trailing] , 10)
        }
            
        }
    }
}

struct CompetitionListView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionListView()
    }
}
