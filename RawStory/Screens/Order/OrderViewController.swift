import UIKit

class OrderViewController: UIViewController {
    
    static let identifier = "Order"

    @IBOutlet weak var goods: UITableView!
    @IBOutlet weak var package: UIPickerView!
    @IBOutlet weak var orderDate: UIDatePicker!
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    var message = "Укажите следующие параметры:"
    
    @IBAction func makeOrder(_ sender: Any) {
        getDateFromPicker()
        
        Order.instance.address = addressField.text ?? ""
        Order.instance.phone = phoneField.text ?? ""
        Order.instance.name = nameField.text ?? ""
        
        if (!dataIsCorrect()) {
            createAlert(title: "Заказ не оформлен", message: message, button: "Назад")
            message = "Укажите следующие параметры:"
            
        } else {
            message = "Параметры заказа:\n\(Order.instance.toString())"
            
            let viewController = storyboard?.instantiateViewController(withIdentifier: FinishViewController.identifier) as! FinishViewController
            self.present(viewController, animated: true)

            createAlert(title: "Заказ оформлен", message: message, button: "ОК")
            
        }
    }
    
    var items = [CartItem]()
    
    let packages = ["", "Бумажная", "Пластиковая"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goods.delegate = self
        goods.dataSource = self
        
        package.delegate = self
        package.dataSource = self
        
        addressField.delegate = self
        phoneField.delegate = self
        nameField.delegate = self
        
        loadCart()
        
        orderDate.minimumDate = NSDate() as Date
        orderDate.maximumDate = Date(timeInterval: 864000, since: NSDate() as Date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCart()
    }
}

// TEXT FIELDS
extension OrderViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getOrderData(textField: textField)
        return true
    }
}

// TABLE
extension OrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath) as? OrderTableViewCell else { return UITableViewCell() }
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// PICKER
extension OrderViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return packages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return packages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Order.instance.package = packages[row]
    }
}


extension OrderViewController {
    func loadCart() {
        items = CartService.instance.getItems()
        Order.instance.items = items
        goods.reloadData()
    }
    
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM в H:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        Order.instance.date = formatter.string(from: orderDate.date)
    }
    
    func getOrderData(textField: UITextField) {
        switch textField.placeholder {
        case "Адрес":
            Order.instance.address = addressField.text ?? ""
            break
        case "Телефон":
            Order.instance.phone = phoneField.text ?? ""
            break
        case "Имя":
            Order.instance.name = nameField.text ?? ""
            break
        default:
            break
        }
    }
    
    func createAlert(title: String, message: String, button: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: button, style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func dataIsCorrect() -> Bool{
        var correct = true
        
        if Order.instance.items.count == 0 {
            message = "Корзина пуста"
            return false
        }
        
        if Order.instance.package == "" {
            message += "\n• Вид упаковки"
            correct = false
        }
        if Order.instance.address == "" {
            message += "\n• Адрес доставки"
            correct = false
        }
        if Order.instance.phone == "" {
            message += "\n• Телефон"
            correct = false
        }
        if Order.instance.name == "" {
            message += "\n• Имя"
            correct = false
        }
        if Order.instance.date == "" {
            message += "\n• Дату доставки"
            correct = false
        }
        
        return correct
    }
}
