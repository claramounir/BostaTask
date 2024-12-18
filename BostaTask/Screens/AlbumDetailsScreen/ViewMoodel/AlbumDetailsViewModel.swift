//
//  AlbumDetailsViewModel.swift
//  BostaTask
//
//  Created by Clara Mounir Adly on 17/12/2024.
//

import Foundation
import Combine

final class AlbumDetailsViewModel {
    // MARK: - Properties

    private let dataSource: DataSource
    private var cancellables = Set<AnyCancellable>()
    
// Published properties to bind to the UI
    @Published var photos = [Photos]()
    @Published var allPhotos: [Photos] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Initialization
    
    init(dataSource: DataSource  = DataSource()) {
        self.dataSource = dataSource
    }
    func fetchPhotos(for albumId: Int) {
        isLoading = true
        dataSource.getPhotos(albumId: albumId)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { photos in
                self.photos = photos
                self.allPhotos = photos
            })
            .store(in: &cancellables)
    }
    func searchWithTitle(_ title: String) {
        title.isEmpty ?
        (photos = allPhotos) :
        (photos = allPhotos.filter { $0.title.lowercased().contains(title.lowercased())  })
    }
    
}
