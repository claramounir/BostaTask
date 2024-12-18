//
//  DataSource.swift
//  BostaTask
//
//  Created by Clara Mounir Adly on 17/12/2024.
//

import Foundation
import Combine
import Moya
import CombineMoya

final class DataSource {
    private let provider = MoyaProvider<APIService>()
    
    func getUsers() -> AnyPublisher<[User], Error> {
        provider.requestPublisher(APIService.getUsers)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getAlbums(userId: Int) -> AnyPublisher<[Album], Error> {
        provider.requestPublisher(.getAlbums(userId: userId))
            .map(\.data)
            .decode(type: [Album].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getPhotos(albumId: Int) -> AnyPublisher<[Photos], Error> {
        provider.requestPublisher(.getPhotos(albumId: albumId))
            .map(\.data)
            .decode(type: [Photos].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
