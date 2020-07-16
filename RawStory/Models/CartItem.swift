import Foundation

class CartItem {
    
    var object: GoodObject
    var count: Int
    
    init(object: GoodObject) {
        self.object = object
        count = 1
    }
    
    func calcPrice() -> Int {
        return Int(self.object.price)! * self.count
    }
    
    func price() -> String {
        return self.object.price
    }

}
