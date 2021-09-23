//
//  SetGoalModel.swift
//  NoDoubts
//
//  Created by Qazi on 11/09/2021.
//

import Foundation
struct SetGoalModel : Codable {

        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case message = "message"
                case status = "status"
        }
}
