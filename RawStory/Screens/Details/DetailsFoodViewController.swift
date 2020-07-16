import UIKit

class DetailsFoodViewController: UIViewController {
    
    static let identifier = "DetailsFoodViewController"
    var good: GoodObject?
    
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var caloriesLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var priceText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = good?.label
        
        switch good?.type {
        case 0:
            priceText.text = "₽/кг"
        case 1:
            priceText.text = "₽/шт"
        default:
            priceText.text = "₽"
        }
        
        priceLabel.text = good?.price
        caloriesLabel.text = good?.calories
        ingredientsLabel.text = good?.ingredients
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: PhotoCollectionViewCell.identifer, bundle: Bundle.main),
                                forCellWithReuseIdentifier: PhotoCollectionViewCell.identifer)
        
        pageControl.addTarget(self, action: #selector(pageChanged(_:)), for: .valueChanged)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Корзина", style: .plain, target: self,
            action: #selector(didTapCart(_:))
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateCartCount()
    }
    
    @IBAction func addToCart(_ sender: Any) {
        if let good = good {
            CartService.instance.addToCart(good)
        }
        updateCartCount()
    }
    
}

extension DetailsFoodViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = good?.images.count ?? 0
        return good?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifer, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: good?.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        pageControl.currentPage = index
    }
}

extension DetailsFoodViewController {
    
    @objc func didTapCart(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: CartViewController.identifier) as? CartViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pageChanged(_ sender: UIPageControl) {
        collectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func updateCartCount() {
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
