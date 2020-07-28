//
//  PersonModel.swift
//  Test
//
//  Created by iMac on 10.06.2020.
//  Copyright © 2020 AlexAviJr. All rights reserved.
//

import Foundation

class PersonModel: Codable {
    
    var name = ""
    var lastName = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case lastName = "last_name"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName) ?? ""
    }
    
}
