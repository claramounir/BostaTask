//
//  PhotosCollectionViewCell.swift
//  BostaTask
//
//  Created by Clara Mounir Adly on 18/12/2024.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    // MARK: - Static Properties
    
    static let identifier = String(describing: PhotosCollectionViewCell.self)
    // MARK: - Outlets
    @IBOutlet weak var albumPhoto: UIImageView!
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
//MARK: - EXTENSIONS

extension PhotosCollectionViewCell{
    
    //MARK: - SETUP CELL
    
    func setupCell(photo: Photos) {
        let imageUrl = photo.url.asUrl
        albumPhoto.kf.setImage(with: imageUrl)
    }
}
