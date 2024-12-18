//
//  AlbumsTableViewCell.swift
//  BostaTask
//
//  Created by Clara Mounir Adly on 17/12/2024.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {
    // MARK: - Static Properties

    static let identifier = String(describing: AlbumsTableViewCell.self)
    // MARK: - Outlets
    
    @IBOutlet private weak var albumNameLabel: UILabel!
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - Configuration

    func configure(with album: Album) {
        albumNameLabel.text = album.title
      }

    
}
