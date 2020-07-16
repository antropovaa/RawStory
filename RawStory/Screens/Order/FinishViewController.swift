import UIKit

class FinishViewController: UIViewController {
    
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var package: UILabel!
    @IBOutlet weak var sum: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    static let identifier = "Finish"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = "Имя: \(Order.instance.name)"
        phone.text = "Телефон: \(Order.instance.phone)"
        address.text = "Адрес: \(Order.instance.address)"
        package.text = "Тип упаковки: \(Order.instance.package)"
        sum.text = "Сумма к оплате: \(Order.instance.orderSum())₽"
        date.text = "Дата доставки: \(Order.instance.date)"
    }
}
