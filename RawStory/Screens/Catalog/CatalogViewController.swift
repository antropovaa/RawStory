import UIKit

class CatalogViewController: UIViewController {
    
    static let identifier = "Catalog"
    
    var catalogs = [GoodObject]()
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
    }
    
    
}

extension CatalogViewController: UITableViewDataSource, UITableViewDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        updateCartCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogTableViewCell.identifier, for: indexPath) as? CatalogTableViewCell else { return UITableViewCell() }
        cell.configure(with: catalogs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(at: indexPath.row)
    }
}


extension CatalogViewController {
    
    private func loadData() {
        catalogs = GoodObject.getData()
        tableView.reloadData()
    }
    
    private func updateCartCount() {
        let cartItemsCount = CartService.instance.getItems().count
        let cartTitle: String
        if cartItemsCount == 0 {
            cartTitle = "Корзина"
        } else {
            cartTitle = "Корзина (\(cartItemsCount))"
        }
        cartButton.title = cartTitle
    }
    
    private func didSelect(at index: Int) {
        guard index < catalogs.count,
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: DetailsFoodViewController.identifier) as? DetailsFoodViewController else { return }
        
        vc.good = catalogs[index]
        navigationController?.pushViewController(vc, animated: true)
    }
}
