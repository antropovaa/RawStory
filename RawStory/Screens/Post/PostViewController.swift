import UIKit

class PostViewController: UIViewController {
    
    static let identifier = "PostViewController"
    var post: PostObject?
    
    @IBOutlet private weak var postLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var postImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post?.date
        
        postLabel.text = post?.label
        postImageView.image = post?.image
        textLabel.text = post?.text
    }
}
