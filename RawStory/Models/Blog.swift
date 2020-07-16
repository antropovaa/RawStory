import Foundation
import UIKit

struct PostObject {
    let label: String
    let image: UIImage?
    let date: String
    var text: String
    
    static func getData() -> [PostObject] {
        var posts = [PostObject]()
        
        var postDate = "18.06.2019"
        posts.append(PostObject(label: "Что такое RAW десерт?", image: UIImage(named: postDate), date: postDate, text: getTextByDate(date: postDate)))
        
        postDate = "29.05.2019"
        posts.append(PostObject(label: "Позавтракаем вместе?", image: UIImage(named: postDate), date: postDate, text: getTextByDate(date: postDate)))
        
        return posts
    }
}

func getTextByDate(date: String) -> String {
    var text = ""
    do {
        if let path = Bundle.main.path(forResource: date, ofType: "txt"){
            let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
            let myStrings = data.components(separatedBy: NSCharacterSet.newlines)
            
            text = myStrings.joined(separator: "\n")
        }
    } catch let err as NSError {
        print(err)
    }
    
    return text
}
