//
//  CompetitionModel.swift
//  NoDoubts
//
//  Created by Qazi on 13/09/2021.
//

import Foundation
struct CompetitionModel : Codable {

        let data : [competition]?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
}
struct competition : Codable {

        let date : String?
        let id : String?
        let lat : String?
        let longField : String?
        let place : String?
        let result : String?
        let title : String?
        let userId : String?

        enum CodingKeys: String, CodingKey {
                case date = "date"
                case id = "id"
                case lat = "lat"
                case longField = "long"
                case place = "place"
                case result = "result"
                case title = "title"
                case userId = "user_id"
        }
}
