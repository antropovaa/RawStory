import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "PhotoCollectionViewCell"
    
    @IBOutlet private weak var photoImageView: UIImageView!
    
    func configure(with image: UIImage?) {
        photoImageView.image = image
    }
}
