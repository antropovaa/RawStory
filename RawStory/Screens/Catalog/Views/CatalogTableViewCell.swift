import UIKit

class CatalogTableViewCell: UITableViewCell {
    
    static let identifier = "CellID"
    
    @IBOutlet weak var goodImageView: UIImageView!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        goodImageView.layer.cornerRadius = 5
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel: GoodObject) {
        goodLabel.text = viewModel.label
        goodImageView.image = viewModel.image
        priceLabel.text = (viewModel.type == 0) ? "\(viewModel.price)₽/кг" : "\(viewModel.price)₽/шт"
    }
}
