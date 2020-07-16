import UIKit

class CartViewController: UIViewController {
    
    static let identifier = "CartID"
    
    @IBOutlet weak var goods: UITableView!
    @IBOutlet weak var finalSum: UILabel!
    
    @IBAction func makeOrder(_ sender: Any) {
        if (cartIsEmpty()) {
            createAlert(title: "Корзина пуста", message: "Добавьте товары в корзину")
        } else {
            guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: OrderViewController.identifier) as? OrderViewController else { return }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    var items = [CartItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        goods.delegate = self
        goods.dataSource = self
        
        loadCart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCart()
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.5
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, sourceView, completionHandler) in
            
            CartService.instance.removeFromCart(index: indexPath.row)
            self?.items.remove(at: indexPath.row)
            self?.updateFinalSum()
            completionHandler(true)
        }

        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
}

extension CartViewController: CartTableViewCellDelegate {
    
    func stepperDidTapped() {
        updateFinalSum()
    }
}

extension CartViewController {
    func loadCart() {
        items = CartService.instance.getItems()
        goods.reloadData()
        updateFinalSum()
    }
    
    func updateFinalSum() {
        finalSum.text = "\(CartService.instance.calculateFinalSum())₽"
    }
    
    func cartIsEmpty() -> Bool {
        if CartService.instance.getItems().count == 0 {
            return true
        }
        return false
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Назад", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
