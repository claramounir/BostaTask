//
//  ImageViewController.swift
//  BostaTask
//
//  Created by Clara Mounir Adly on 17/12/2024.
//

import UIKit
import Kingfisher
class ImageViewController: UIViewController {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    private var imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
          setupScrollView()
          loadImage(for: imageUrl)
          addNavigationShareButton()
    }
    func loadImage(for linkString: String?, _ placeholder: UIImage? = UIImage(named: "placeholder.png")) {
        let options: [KingfisherOptionsInfoItem] = [.cacheOriginalImage, .scaleFactor(0.5)]
        
        guard let linkString,
                let url = URL(string: linkString) else { return }
        
        albumImage.kf.setImage(with: url, placeholder: placeholder, options: options) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                self.albumImage.image = image.image
            case .failure:
                self.albumImage.image = placeholder
            }
        }
    }
    
    private func addNavigationShareButton() {
        let shareButton = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShareImage)
        )
        navigationItem.rightBarButtonItem = shareButton
    }
    @objc
    private func didTapShareImage() {
        guard let image = albumImage.image else {
            debugPrint("No image available to share.")
            return
        }
        shareImage(image)
    }

    /// Shares the provided image using a UIActivityViewController.
    ///
    /// - Parameter image: The UIImage to be shared.
    private func shareImage(_ image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // Configure the popover presentation controller for iPad compatibility
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(
                x: self.view.bounds.midX,
                y: self.view.bounds.midY,
                width: 0,
                height: 0
            )
            popoverController.permittedArrowDirections = []
        }

        // Exclude specific activity types
        activityViewController.excludedActivityTypes = [
            .airDrop,
            .postToFacebook,
            .postToTwitter,
            .mail,
            .message,
            .copyToPasteboard
        ]
        
        // Present the activity view controller
        present(activityViewController, animated: true) {
            debugPrint("Share activity view controller presented successfully.")
        }
    }

}
extension ImageViewController: UIScrollViewDelegate {
    
    private func setupScrollView() {
        imageScrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        albumImage
    }
}
