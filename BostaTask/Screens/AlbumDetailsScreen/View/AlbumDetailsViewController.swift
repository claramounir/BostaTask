//
//  AlbumDetailsViewController.swift
//  BostaTask
//
//  Created by Clara Mounir Adly on 17/12/2024.
//

import UIKit
import Combine
import CombineCocoa

class AlbumDetailsViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var albumNameLabel: UILabel!
    // MARK: - Properties

    private var cancellables: Set<AnyCancellable> = []
    private var albumId: Int
     private var albumTitle: String
    private let viewModel = AlbumDetailsViewModel()
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    // MARK: - Initializers

    init(albumId: Int, albumTitle: String) {
          self.albumId = albumId
          self.albumTitle = albumTitle
          super.init(nibName: nil, bundle: nil)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        private func setAlbumName() {
            albumNameLabel.text = albumTitle
        }
    // MARK: - Setup Methods

      private func setupViews() {
          setupPhotoCollectionView()
        setAlbumName()
           subscribe()
           getData()
          setupTextField()
}
}
// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension AlbumDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue the cell using the correct identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        let photo = viewModel.photos[indexPath.row]
        cell.setupCell(photo: photo)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photos[indexPath.row] // Access the Photos object
        let imageUrl = photo.thumbnailUrl
        let vc = ImageViewController(imageUrl: imageUrl)
        navigationController?.pushViewController(vc, animated: true)
    }
    private func setupPhotoCollectionView() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(UINib(nibName: PhotosCollectionViewCell.identifier, bundle: nil),
                forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
    }
}
// MARK: - ViewModel Subscriptions

extension AlbumDetailsViewController{
    private func getData() {
        viewModel.fetchPhotos(for: albumId)
    }
    func subscribe() {
        viewModel.$photos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.photoCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}
extension AlbumDetailsViewController: UITextFieldDelegate {
    private func setupTextField() {
        searchTextField.delegate = self
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let searchText = searchTextField.text else { return }
        viewModel.searchWithTitle(searchText)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}



