import UIKit

class ConstructorViewController: UIViewController {
    
    @IBOutlet private weak var cakePicker: UIPickerView!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var toppingLabel: UILabel!
    @IBOutlet weak var layersLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    
    @IBOutlet weak var weightPrice: UILabel!
    @IBOutlet weak var toppingPrice: UILabel!
    @IBOutlet weak var layersPrice: UILabel!
    @IBOutlet weak var basePrice: UILabel!
    @IBOutlet weak var fullPrice: UILabel!
    
    @IBOutlet weak var dotWeight: UIImageView!
    @IBOutlet weak var dotBase: UIImageView!
    @IBOutlet weak var dotLayer: UIImageView!
    @IBOutlet weak var dotTopping: UIImageView!
    
    var cakeID = 1
    
    var layer1Price = 0
    var layer1Text = ""
    
    var layer2Price = 0
    var layer2Text = ""
    
    var choosedCake = Cake(weight: 0, base: 0, layer1: 0, layer2: 0, topping: 0, price: 0)
    var cakeObject: GoodObject!
    
    var selectedElement: Element?
    var selectedOption: Option?
    
    var constructor = CakeConstructor()
    
    var message = ""
    var alertTitle = "Торт не собран"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.selectedIndex = 1
        
        cakeID = 1
        
        weightLabel.text = ""
        toppingLabel.text = ""
        layersLabel.text = ""
        baseLabel.text = ""
        
        weightPrice.text = ""
        toppingPrice.text = ""
        layersPrice.text = ""
        basePrice.text = ""
        
        fullPrice.text = ""
        
        cakePicker.dataSource = self
        cakePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateCartCount()
    }
    
    @IBAction func addToCart(_ sender: Any) {
        if !isOptionsCorrect(cake: choosedCake) || !isLayersCorrect(cake: choosedCake) {
            createAlert(title: alertTitle, message: message)
        }  else {
            CartService.instance.addToCart(choosedCake.toGoodObject())
            
            if let barItem = navigationItem.rightBarButtonItem {
                barItem.title = "Корзина (\(CartService.instance.getItems().count))"
            }
        }
    }

}

extension ConstructorViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return constructor.elements.count
        case 1:
            return constructor.optionsByElement.count
        default:
            return 0
        }
    }
}

extension ConstructorViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let element = constructor.elements[row]
            return element.name
        } else {
            let option = constructor.optionsByElement[row]
            return option.name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let element = constructor.elements[row]
            selectedElement = element
            
            constructor.optionsByElement = constructor.getOptions(elementId: element.id)
            pickerView.reloadComponent(1)
            
            switch element.id {
            case 1:
                pickerView.selectRow(choosedCake.weight, inComponent: 1, animated: true)
            case 2:
                pickerView.selectRow(choosedCake.base, inComponent: 1, animated: true)
            case 3:
                pickerView.selectRow(choosedCake.layer1, inComponent: 1, animated: true)
            case 4:
                pickerView.selectRow(choosedCake.layer2, inComponent: 1, animated: true)
            case 5:
                pickerView.selectRow(choosedCake.topping, inComponent: 1, animated: true)
            default:
                pickerView.selectRow(0, inComponent: 1, animated: true)
            }
        
        } else {
            cakeID += 1
            let option = self.constructor.optionsByElement[row]
            selectCake(option: option)
            choosedCake.price = calculatePrice(cake: choosedCake, constructor: self.constructor)
            fullPrice.text = "\(choosedCake.price)₽"
        }
    }
}

extension ConstructorViewController {
    func selectCake(option: Option) {
        
        var imageName = "dot"
        if option.name == "" {
            imageName = "dot_grey"
        }
        
        switch option.elementId {
        case 1:
            do {
                choosedCake.weight = option.id
                weightLabel.text = option.name
                weightPrice.text = "\(option.price)₽"
                dotWeight.image = UIImage(named: imageName)
            }
        case 2:
            do {
                choosedCake.base = option.id
                baseLabel.text = option.name
                basePrice.text = "\(option.price)₽"
                dotBase.image = UIImage(named: imageName)
            }
        case 3:
            do {
                layer1Price = option.price
                choosedCake.layer1 = option.id
                layer1Text = option.name
                layersLabel.text = (layer2Text == "") ? layer1Text : "\(layer1Text) + \(layer2Text)"
                layersPrice.text = "\(layer1Price + layer2Price)₽"
                dotLayer.image = UIImage(named: imageName)
            }
        case 4:
            do {
                layer2Price = option.price
                choosedCake.layer2 = option.id
                layer2Text = (option.id == 0 || option.id == 1) ? "" : option.name
                layersLabel.text = (layer2Text == "") ? layer1Text : "\(layer1Text) + \(layer2Text)"
                layersPrice.text = "\(layer1Price + layer2Price)₽"
                dotLayer.image = UIImage(named: imageName)
            }
        case 5:
            do {
                choosedCake.topping = option.id
                toppingLabel.text = option.name
                toppingPrice.text = "\(option.price)₽"
                dotTopping.image = UIImage(named: imageName)
            }
        default:
            do {}
        }
    }
    
    func calculatePrice(cake: Cake, constructor: CakeConstructor) -> Int {
        let weightPrice = constructor.getOptionById(elementId: 1, id: cake.weight).price
        let basePrice = constructor.getOptionById(elementId: 2, id: cake.base).price
        let layer1Price = constructor.getOptionById(elementId: 3, id: cake.layer1).price
        let layer2Price = constructor.getOptionById(elementId: 4, id: cake.layer2).price
        let toppingPrice = constructor.getOptionById(elementId: 5, id: cake.topping).price
        
        return weightPrice + basePrice + layer2Price + layer1Price + toppingPrice
    }
    
    func isOptionsCorrect(cake: Cake) -> Bool {
        message = "Укажите следующие параметры торта:"
        
        var errors = ["", "", "", "", ""]
        
        if cake.weight == 0 {
            errors[0] = "Вес"
        }
        if cake.base == 0 {
            errors[1] = "Основа"
        }
        if cake.layer1 == 0 {
            errors[2] = "Слой №1"
        }
        if cake.layer2 == 0 {
            errors[3] = "Слой №2"
        }
        if cake.topping == 0 {
            errors[4] = "Начинка"
        }
        
        for error in errors {
            if error != "" {
                message += "\n• \(error)"
            }
        }
        
        if errors != ["", "", "", "", ""] {
            return false
        } else {
            return true
        }
    }
    
    func isLayersCorrect(cake: Cake) -> Bool {
        if cake.layer1 == (cake.layer2 - 1) {
            message = "Слои должны быть разные"
            return false
        } else {
            return true
        }
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Назад", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateCartCount() {
        if let barItem = navigationItem.rightBarButtonItem {
            let cartItemsCount = CartService.instance.getItems().count
            let cartTitle: String
            if cartItemsCount == 0 {
                cartTitle = "Корзина"
            } else {
                cartTitle = "Корзина (\(cartItemsCount))"
            }
            barItem.title = cartTitle
        }
    }
}
