import UIKit

class BlogTableViewCell: UITableViewCell {
    
    static let identifier = "BlogCellID"
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel: PostObject) {
        postLabel.text = viewModel.label
        postImageView.image = viewModel.image
        dateLabel.text = viewModel.date
    }
}
