//
//  PhotosModel.swift
//  BostaTask
//
//  Created by Clara Mounir Adly on 16/12/2024.
//


import Foundation
struct Photos: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
