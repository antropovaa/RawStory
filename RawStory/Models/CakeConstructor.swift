import Foundation
import UIKit

struct Element {
    var id: Int
    var name: String
}

struct Option {
    var id: Int
    var name: String
    var elementId: Int
    var price: Int
}

class CakeConstructor {
    var elements = [Element]()
    var options = [Option]()
    var optionsByElement = [Option]()
    
    init() {
        setupData()
    }
    
    func setupData() {
        elements.append(Element(id: 1, name: "Вес"))
        elements.append(Element(id: 2, name: "Основа"))
        elements.append(Element(id: 3, name: "Слой №1"))
        elements.append(Element(id: 4, name: "Слой №2"))
        elements.append(Element(id: 5, name: "Начинка"))
        
        options.append(Option(id: 0, name: "", elementId: 1, price: 0))
        options.append(Option(id: 1, name: "1 кг", elementId: 1, price: 100))
        options.append(Option(id: 2, name: "1.5 кг", elementId: 1, price: 100))
        options.append(Option(id: 3, name: "2 кг", elementId: 1, price: 100))
        options.append(Option(id: 4, name: "5 кг", elementId: 1, price: 100))
        
        options.append(Option(id: 0, name: "", elementId: 2, price: 0))
        options.append(Option(id: 1, name: "Миндальная", elementId: 2, price: 100))
        options.append(Option(id: 2, name: "Шоколадная", elementId: 2, price: 100))
        
        options.append(Option(id: 0, name: "", elementId: 3, price: 0))
        options.append(Option(id: 1, name: "Клубника", elementId: 3, price: 100))
        options.append(Option(id: 2, name: "Шоколад", elementId: 3, price: 100))
        options.append(Option(id: 3, name: "Кокос", elementId: 3, price: 100))
        options.append(Option(id: 4, name: "Манго", elementId: 3, price: 100))
        options.append(Option(id: 5, name: "Банан", elementId: 3, price: 100))
        options.append(Option(id: 6, name: "Смородина", elementId: 3, price: 100))
        
        options.append(Option(id: 0, name: "", elementId: 4, price: 0))
        options.append(Option(id: 1, name: "–", elementId: 4, price: 0))
        options.append(Option(id: 2, name: "Клубника", elementId: 4, price: 100))
        options.append(Option(id: 3, name: "Шоколад", elementId: 4, price: 100))
        options.append(Option(id: 4, name: "Кокос", elementId: 4, price: 100))
        options.append(Option(id: 5, name: "Манго", elementId: 4, price: 100))
        options.append(Option(id: 6, name: "Банан", elementId: 4, price: 100))
        options.append(Option(id: 7, name: "Смородина", elementId: 4, price: 100))
        
        options.append(Option(id: 0, name: "", elementId: 5, price: 0))
        options.append(Option(id: 1, name: "–", elementId: 5, price: 0))
        options.append(Option(id: 2, name: "Карамель", elementId: 5, price: 100))
        options.append(Option(id: 3, name: "Пралине", elementId: 5, price: 100))
        options.append(Option(id: 4, name: "Джем", elementId: 5, price: 100))
        
        self.optionsByElement = getOptions(elementId: elements.first!.id)
    }
    
    func getOptions(elementId: Int) -> [Option] {
        let options = self.options.filter{ (o) -> Bool in
            o.elementId == elementId
        }
        return options
    }

    func getOptionById(elementId: Int, id: Int) -> Option {
        let options = getOptions(elementId: elementId)
        var option: Option
        
        option = options.first!
        
        for o in options {
            if o.id == id {
                option = o
            }
        }
        
        return option
    }
    
}


