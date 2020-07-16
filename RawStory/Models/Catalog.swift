import Foundation
import UIKit

struct GoodObject {
    let type: Int // 0 - full cake, 1 - small desert, 3 - by constructor
    let label: String
    let image: UIImage?
    let price: String
    let images: [UIImage?]
    let ingredients: String
    let calories: String
    
    static func getData() -> [GoodObject] {
        var goods = [GoodObject]()
        goods.append(GoodObject(type: 0, label: "Торт Тропический", image: UIImage(named: "cake0_main"), price: "1700", images: [UIImage(named: "cake0_0"), UIImage(named: "cake0_1")], ingredients: "Манго, кешью, сироп топинамбура, кокосовое молоко, миндаль, кокосовая стружка, кокосовое масло, агар-агар, финики, гречиха зелёная проросшая", calories: "423 кКал, Б - 11, Ж - 30, У - 28"))
        
        goods.append(GoodObject(type: 0, label: "Торт Ежевика-кокос", image: UIImage(named: "cake1_main"), price: "1700", images: [UIImage(named: "cake1_0"), UIImage(named: "cake1_1")], ingredients: "Кешью, ежевика, кокосовые сливки, миндаль, финик, органическое какао, масло кокоса, Агар-Агар, сироп топинамбура", calories: "423 кКал, Б - 11, Ж - 30, У - 28"))
        
        goods.append(GoodObject(type: 0, label: "Торт Птичье молоко", image: UIImage(named: "cake2_main"), price: "1300", images: [UIImage(named: "cake2"), UIImage(named: "cake2"), UIImage(named: "cake2")], ingredients: "Рисовая мука, сироп топинамбура, кокосовое молоко, аквафаба, тертое какао", calories: "423 кКал, Б - 11, Ж - 30, У - 28"))
        
        goods.append(GoodObject(type: 0, label: "Торт Сливочный Шоколад", image: UIImage(named: "cake3_main"), price: "1800", images: [UIImage(named: "cake3"), UIImage(named: "cake3"), UIImage(named: "cake3")], ingredients: "Органическое какао, грецкий орех, семена льна, активированный кешью, кокосовое молоко, экстракт ванили, сироп топинамбура, агар-агар", calories: "423 кКал, Б - 11, Ж - 30, У - 28"))
        
        goods.append(GoodObject(type: 1, label: "Десерт Вишня-шоколад", image: UIImage(named: "cake4_main"), price: "210", images: [UIImage(named: "cake4"), UIImage(named: "cake4"), UIImage(named: "cake4")], ingredients: "Органическое какао, кешью, сироп топинамбура, вишня, фундук, агар-агар, кокосовое молоко, гречиха зелёная проросшая, овсяная мука, финик", calories: "423 кКал, Б - 11, Ж - 30, У - 28"))
        
        goods.append(GoodObject(type: 1, label: "Пирожное Черника-ваниль", image: UIImage(named: "cake5_main"), price: "190", images: [UIImage(named: "cake5"), UIImage(named: "cake5"), UIImage(named: "cake5")], ingredients: "Кешью, черника, ваниль, сироп топинамбура, миндаль, финик, грецкий орех, сок лимона, кокосовая стружка, куркума, какао органическое, масло кокоса", calories: "423 кКал, Б - 11, Ж - 30, У - 28"))
        
        return goods
    }
    
    func equals(good: GoodObject) -> Bool {
        if type == good.type && label == good.label && image == good.image && price == good.price && images == good.images && ingredients == good.ingredients && calories == good.calories {
            return true
        } else {
            return false
        }
    }
}
