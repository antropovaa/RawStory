import Foundation
import UIKit

struct Cake {
    var weight: Int
    var base: Int
    var layer1: Int
    var layer2: Int
    var topping: Int
    var price: Int
    
    func toGoodObject() -> GoodObject {
        
        let constructor = CakeConstructor()
        var info = ""
    
        let baseText = constructor.getOptionById(elementId: 2, id: base).name
        let layersText = (layer2 == 1) ? "\(constructor.getOptionById(elementId: 3, id: layer1).name)" : "\(constructor.getOptionById(elementId: 3, id: layer1).name) + \(constructor.getOptionById(elementId: 4, id: layer2).name)"
        let toppingText = (topping == 1) ? "" : "\(constructor.getOptionById(elementId: 5, id: topping).name)"
        
        if toppingText == "" {
            info = "База " + baseText + ", " + layersText
        } else {
            info = "База " + baseText + ", " + layersText + ", начинка " + toppingText
        }
        
        let object = GoodObject(type: 3, label: "Собранный торт", image: UIImage(named: "custom_cake"), price: "\(price)", images: [], ingredients: info, calories: "")
        return object
    }
    
    func equals(cake: Cake) -> Bool {
        if (weight == cake.weight && base == cake.base && layer1 == cake.layer1 && layer2 == cake.layer2 && topping == cake.topping) {
            return true
        } else {
            return false
        }
    }
}


