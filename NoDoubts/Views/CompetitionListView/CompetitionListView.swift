//
//  CompetitionListView.swift
//  NoDoubts
//
//  Created by Qazi on 04/09/2021.
//

import SwiftUI

struct CompetitionListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var open = false
    @State var popoverSize = CGSize(width: 100, height: 100)
   
    @State private var moveToCompetitionView: Bool = false
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
            gotoCompetitionView
            Spacer()
            
        
        }.modifier(BannerModifier(model: $competitionList.model)).padding().onAppear(){
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
                Button(action: {
                    moveToCompetitionView.toggle()
                }){
                    Image("plusIcon").resizable().frame(width: 22 , height: 22).padding(.trailing, 20)
                }
                    
                
        }.frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
            
            
            Divider()
            
        }
    }
    //MARK:- Competition List
    func CompetitionList() -> some View{
        let h = VStack(spacing : 8) {
        if (competitionList.Comp?.data?.count == nil){
            Text("No Competition Found").padding().font(.custom("Poppins-Medium", size: 13))
                .foregroundColor(Color.primary)
            
        }else{
        
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
        return h
}
    //MARK:- Linking
    private var gotoCompetitionView : some View {
        
        NavigationLink(destination: CompetitionView(backToList: $moveToCompetitionView),isActive: $moveToCompetitionView,
                       label: {
                        Text("")
                       })
        
    }
}

struct CompetitionListView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionListView()
    }
}
