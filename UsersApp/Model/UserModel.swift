//
//  UserModel.swift
//  UsersApp
//
//  Created by Maxos on 6/10/23.
//

import Foundation

struct UserModel: Decodable {
    let id: Int
    let firstName, lastName: String
    let gender: GenderModel
    let avatar: String
    let age: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case gender, avatar, age
    }
}

enum Sorting {
    case all
    case age(AgeModel)
}

enum Filter {
    case all
    case gender(GenderModel)
}
