import UIKit

protocol CartTableViewCellDelegate: class {
    func stepperDidTapped()
}

class CartTableViewCell: UITableViewCell {
    
    static let identifier = "CartCellID"
    
    @IBOutlet weak var goodImageView: UIImageView!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var goodDescription: UILabel!
    @IBOutlet weak var goodPrice: UILabel!
    @IBOutlet weak var goodCounter: UILabel!
    @IBOutlet weak var goodStepper: UIStepper!
    
    weak var delegate: CartTableViewCellDelegate?
    
    @IBAction func goodStepper(_ sender: UIStepper) {
        let items = CartService.instance.getItems()
        
        for item in items {
            if item.object.type == 3 {
                if item.object.ingredients == goodDescription.text {
                    item.count = Int(sender.value)
                    goodCounter.text = "\(item.count) шт."
                    goodPrice.text = "\(CartService.instance.calcItemPrice(item: item))₽"
                }
            } else {
                if item.object.label == goodLabel.text {
                    item.count = Int(sender.value)
                    goodCounter.text = "\(item.count) шт."
                    goodPrice.text = "\(CartService.instance.calcItemPrice(item: item))₽"
                }
            }
        }
        
        delegate?.stepperDidTapped()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with vm: CartItem) {
        goodImageView.image = vm.object.image
        goodLabel.text = vm.object.label
        goodDescription.text = ""
        
        if (vm.object.type == 3) {
            goodDescription.text = vm.object.ingredients
        } else {
            goodDescription.text = ""
        }
        
        let items = CartService.instance.getItems()
        for item in items {
            if item.object.type == 3 {
                if item.object.ingredients == goodDescription.text {
                    goodPrice.text = "\(CartService.instance.calcItemPrice(item: item))₽"
                    goodStepper.value = Double(item.count)
                    goodCounter.text = "\(item.count) шт."
                }
            } else {
                if item.object.label == goodLabel.text {
                    goodPrice.text = "\(CartService.instance.calcItemPrice(item: item))₽"
                    goodStepper.value = Double(item.count)
                    goodCounter.text = "\(item.count) шт."
                }
            }
        }
    }

}
