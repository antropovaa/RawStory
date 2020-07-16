import Foundation

class CartService {
    
    private init() {}
    
    private var items: [CartItem] = []
    
    static let instance = CartService()
    
    func addToCart(_ object: GoodObject) {
        if let existed = items.filter( {$0.object.ingredients == object.ingredients}).first {
            existed.count += 1
        } else {
            items.append(CartItem(object: object))
        }
    }
    
    func removeFromCart(index: Int) {
        items.remove(at: index)
    }
    
    func getItems() -> [CartItem] {
        return items
    }
    
    func getCount() -> Int {
        return items.count
    }
    
    func getGoodObject(item: CartItem) -> GoodObject {
        return item.object
    }
    
    func calcItemPrice(item: CartItem) -> Int {
        return item.calcPrice()
    }
    
    func calculateFinalSum() -> Int {
        var sum = 0
        for item in items {
            sum += item.calcPrice()
        }
        return sum
    }
    
    func clearCart() {
        items = [CartItem]()
    }
}
