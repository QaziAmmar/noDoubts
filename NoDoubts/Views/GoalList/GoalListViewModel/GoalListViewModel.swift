//
//  GoalListViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 21/09/2021.
//

import Foundation
class GoalListViewModel: ObservableObject{
@Published var goalList : StrengthModel?
@Published var loading = false
@Published var model: BannerData?
@Published  var movetoDashboard: Bool = false

func loadJson(from decoder: Decoder ) throws {
    
    goalList = try StrengthModel(from: decoder)
}
//MARK:-  Goal  Api
func ApiGoalList(){
    
        loading = true
        
        ApiManager.URLResponse("api/Workout/goal?user_id=20", method: .get, parameters: nil, headers: nil) { competitions in
            //            parse login data
            do {
                let decoder = JSONDecoder()
                let GoalListModel = try decoder.decode(StrengthModel.self, from: competitions)

                if GoalListModel.status == 1 {
                    self.loading = false
                    print(GoalListModel)
                    self.goalList = GoalListModel
//                        self.model = BannerData(title:  competitionsModels.message ?? "", message: competitionsModels.message, color: .green, image: "success")
                } else {
                    //                    show error
                    self.model = BannerData(title: GoalListModel.message ?? "", message: GoalListModel.message, color: .red, image: "error")
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

