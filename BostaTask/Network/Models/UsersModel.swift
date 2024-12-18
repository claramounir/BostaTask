//
//  UsersModel.swift
//  BostaTask
//
//  Created by Clara Mounir Adly on 16/12/2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}
