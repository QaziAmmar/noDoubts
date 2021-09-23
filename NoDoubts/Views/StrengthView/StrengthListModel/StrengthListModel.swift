//
//  StrengthListModel.swift
//  NoDoubts
//
//  Created by Qazi on 16/09/2021.
//

import Foundation
struct StrengthModel : Codable {

        let data : [strength]?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
}
struct strength : Codable {

        let createdAt : String?
        let date : String?
        let duration : String?
        let id : String?
        let name : String?
        let reps : String?
        let time : String?
        let userId : String?
        let weight : String?
        let description : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "created_at"
                case date = "date"
                case duration = "duration"
                case id = "id"
                case name = "name"
                case reps = "reps"
                case time = "time"
                case userId = "user_id"
                case weight = "weight"
                case description = "description"
        }
}
