import UIKit

class BlogViewController: UIViewController {
    
    var posts = [PostObject]()
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let barItem = navigationItem.rightBarButtonItem {
            let cartItemsCount = CartService.instance.getItems().count
            let cartTitle: String
            if cartItemsCount == 0 {
                cartTitle = "Корзина"
            } else {
                cartTitle = "Корзина (\(cartItemsCount))"
            }
            barItem.title = cartTitle
        }
    }
}

extension BlogViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlogTableViewCell.identifier, for: indexPath) as? BlogTableViewCell else { return UITableViewCell() }
        cell.configure(with: posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 249.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(at: indexPath.row)
    }
}


extension BlogViewController {
    
    private func loadData() {
        posts = PostObject.getData()
        tableView.reloadData()
    }
    
    private func didSelect(at index: Int) {
        guard index < posts.count,
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: PostViewController.identifier) as? PostViewController else { return }

        vc.post = posts[index]
        navigationController?.pushViewController(vc, animated: true)
    }
}
