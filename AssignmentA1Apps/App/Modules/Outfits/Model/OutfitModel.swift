//
//  OutfitModel.swift
//  AssignmentA1Apps
//
//  Created by Yogi Rawat on 19/09/25.
//

import Foundation


struct OutfitModel : Codable {
    let data : [Outfit]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Outfit].self, forKey: .data)
    }
}

struct Outfit : Codable {
    let image : String?
    let email : String?
    let name : String?
    let age : Int?
    let dob : String?

    enum CodingKeys: String, CodingKey {

        case image = "image"
        case email = "email"
        case name = "name"
        case age = "age"
        case dob = "dob"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
    }

}

