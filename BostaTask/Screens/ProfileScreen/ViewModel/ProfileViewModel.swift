////
////  ProfileViewModel.swift
////  BostaTask
////
////  Created by Clara Mounir Adly on 17/12/2024.
////
//
import Foundation
import Combine
final class ProfileViewModel {
  // MARK: - DEPENDANCIES
    private let dataSource: DataSource
    private var cancellables = Set<AnyCancellable>()
    // MARK: - PROPERITES

    @Published var users: [User]?
    @Published var albums = [Album]() 
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
  // MARK: - INITIALIZER

    init(dataSource: DataSource  = DataSource()) {
        self.dataSource = dataSource
    }

   // MARK: - FETCH USER
    func fetchUsers() {
        isLoading = true
        dataSource.getUsers()
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { users in
                self.users = users
            })
            .store(in: &cancellables)
    }
    // MARK: - FETCH ALBUMS

    func fetchAlbums(for userId: Int) {
        isLoading = true
        dataSource.getAlbums(userId: userId)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { albums in
                self.albums = albums
            })
            .store(in: &cancellables)
    }
}
