//
//  rUNNIGmODEL.swift
//  NoDoubts
//
//  Created by Qazi on 13/09/2021.
//

import Foundation
struct RunnigModel : Codable {

        let data : [running]?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
}
struct running : Codable {

        let averageSpeed : String?
        let distance : String?
        let id : String?
        let time : String?
        let userId : String?
        let createdat : String?
        let data: String?

        enum CodingKeys: String, CodingKey {
                case averageSpeed = "average_speed"
                case distance = "distance"
                case id = "id"
                case time = "time"
                case userId = "user_id"
                case createdat = "created_at"
                case data = "data"
        }
}
