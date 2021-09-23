//
//  CompetitionListViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 13/09/2021.
//

import Foundation
class CompetitionListViewModel: ObservableObject{
    @Published var Comp : CompetitionModel?
    @Published var loading = false
    @Published var model: BannerData?
    @Published  var movetoDashboard: Bool = false
    
    func loadJson(from decoder: Decoder ) throws {
        
        Comp = try CompetitionModel(from: decoder)
    }
    
    //MARK:- SignUp Api
    func ApiCalling(){
        
            loading = true
            
            ApiManager.URLResponse("api/Workout/competition?user_id=20", method: .get, parameters: nil, headers: nil) { competitions in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let competitionsModels = try decoder.decode(CompetitionModel.self, from: competitions)

                    if competitionsModels.status == 1 {
                        self.loading = false
                        print(competitionsModels)
                        self.Comp = competitionsModels
                        self.model = BannerData(title:  competitionsModels.message ?? "", message: competitionsModels.message, color: .green, image: "success")
                    } else {
                        //                    show error
                        self.model = BannerData(title: competitionsModels.message ?? "", message: competitionsModels.message, color: .red, image: "error")
                    }
                } catch let error {
                    self.loading = false
                    print(error)
                }
                
                
            } withapiFiluer: { error in
                self.loading = false
                print("\(error)")
            }
    }

}

