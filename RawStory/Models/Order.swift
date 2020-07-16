import Foundation

class Order {
    
    private init() {}
    
    static let instance = Order()
    
    var items = [CartItem]()
    var package = ""
    var address = ""
    var phone = ""
    var name = ""
    var date = ""
    
    func toString() -> String {
        return "\n• Сумма к оплате: \(orderSum())\n• Упаковка: \(package)\n• Адрес: \(address)\n• Телефон: \(phone)\n• Дата: \(date)\n• Имя: \(name)"
    }
    
    func orderSum() -> Int {
        var sum = 0
        for item in items {
            sum += item.calcPrice()
        }
        return sum
    }
}
