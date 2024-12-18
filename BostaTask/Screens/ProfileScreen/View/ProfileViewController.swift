//
//  ProfileViewController.swift
//  BostaTask
//
//  Created by Clara Mounir Adly on 17/12/2024.
//

import UIKit
import Combine
import CombineCocoa
class ProfileViewController: UIViewController {
    // MARK: - Outlets
    
    @IBOutlet private weak var albumsTabelView: UITableView!
    @IBOutlet private weak var adressLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    // MARK: - Properties
    
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel = ProfileViewModel()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getData()
    }
    private func setupViews() {
        setupAlbumTableView()
        userDataSubscribe()
        albumsSubscribe()
       
    }
}
//MARK: - EXTENSIONS
extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
 
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.albums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = albumsTabelView.dequeueReusableCell(withIdentifier: AlbumsTableViewCell.identifier, for: indexPath) as? AlbumsTableViewCell {
            cell.configure(with: viewModel.albums[indexPath.row])
            return cell
        } else {
            // Return a default UITableViewCell in case the casting fails
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.albums[indexPath.row]
        let vc = AlbumDetailsViewController(
            albumId: album.id,
            albumTitle: album.title
        )
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func setupAlbumTableView() {
        albumsTabelView.delegate = self
        albumsTabelView.dataSource = self
        albumsTabelView.register(UINib(nibName: AlbumsTableViewCell.identifier, bundle: nil),
        forCellReuseIdentifier: AlbumsTableViewCell.identifier)
    }

}
// MARK: - Address Formatting & User Data Subscription
extension ProfileViewController{
    
    private func formatAddress(_ address: Address) -> String {
        let components = [address.street, address.suite, address.city, address.zipcode]
        return components
            .compactMap { $0 } // Remove nil values
            .joined(separator: ", ")
    }

    private func userDataSubscribe() {
        viewModel.$users
            .sink { [weak self] users in
                guard let self = self else { return }
                
                if let users = users, let firstUser = users.first {
                self.nameLabel.text = firstUser.name
                self.adressLabel.text = self.formatAddress(firstUser.address)
                    viewModel.fetchAlbums(for: firstUser.id)
            }
            }
            .store(in: &cancellables)
    }
    // MARK: - Albums Subscription

    private func albumsSubscribe() {
        viewModel.$albums
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                print(viewModel.albums.count)
                albumsTabelView.reloadData()
            }
            .store(in: &cancellables)
    }
    // MARK: - Data Fetching

    private func getData() {
        viewModel.fetchUsers()
        
    }
  
}
