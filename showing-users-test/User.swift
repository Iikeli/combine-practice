//
//  User.swift
//  showing-users-test
//
//  Created by Iiro Alhonen on 21.07.21.
//

/// The struct representing a user.
struct User: Codable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id, email, first_name, last_name, avatar
    }
}

/// Struct for getting initial data in.
struct Initial: Codable {
    let data: [User]
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}
