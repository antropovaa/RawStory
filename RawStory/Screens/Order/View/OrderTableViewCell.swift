import UIKit

class OrderTableViewCell: UITableViewCell {
    
    static let identifier = "OrderCartID"
    
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var goodCounter: UILabel!
    @IBOutlet weak var goodPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with vm: CartItem) {
        goodLabel.text = vm.object.label
        goodCounter.text = "\(vm.count) шт."
        goodPrice.text = "\(vm.calcPrice())₽"
    }
}
