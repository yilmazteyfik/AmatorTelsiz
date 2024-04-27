import UIKit

struct CustomData {
    var title: String
    var backgroundImage: UIImage
}

class MainViewController: UIViewController {

    fileprivate let data = [
        CustomData(title: "A/B Sınıfı İşletme ", backgroundImage: UIImage(named: "6016915")!),
        CustomData(title: "A/B Sınıfı Teknik ", backgroundImage: UIImage(named: "8808136")!),
        CustomData(title: "A/B Sınıfı Ulusal ve Uluslararası", backgroundImage: UIImage(named: "6488972")!),
        CustomData(title: "C Sınıfı İşletme ", backgroundImage: UIImage(named: "5617266")!),
        CustomData(title: "C Sınıfı Teknik", backgroundImage: UIImage(named: "6488972")!),
        CustomData(title: "C Sınıfı Ulusal ve Uluslararası", backgroundImage: UIImage(named: "5617266")!)
    ]

    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect(x: 40, y: 170, width: UIScreen.main.bounds.width, height: 300), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    private let secondCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell2") // Doğru hücre sınıfını kaydedin
        cv.backgroundColor = .purple
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

// MARK: - Helpers
extension MainViewController {
    private func style() {
       
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false

        view.addSubview(secondCollectionView)
        secondCollectionView.backgroundColor = .white
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        secondCollectionView.showsHorizontalScrollIndicator = false
    }

    private func layout() {
        
        let titleLabel = UILabel()
        titleLabel.text = "Soru Bankaları"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
          
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
       
        let titleLabel1 = UILabel()
        titleLabel1.text = "Deneme Sınavları"
        titleLabel1.textAlignment = .left
        titleLabel1.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel1)
       
        titleLabel1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 380).isActive = true
        titleLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        secondCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        secondCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        secondCollectionView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        secondCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    

}

// MARK: - Functions
extension MainViewController {
    @objc func abButtonTapped() {
        print("A/B button Tapped")
    }

    @objc func cButtonTapped() {
        print("C button Tapped")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.width * 0.6)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
            cell.data = data[indexPath.item]

            // Apply rounded corners and shadow
            cell.contentView.layer.cornerRadius = 15
            cell.contentView.layer.masksToBounds = true
            cell.layer.shadowColor = UIColor.red.cgColor
            cell.layer.shadowOffset = CGSize(width: 1, height: 10)
            cell.layer.shadowOpacity = 0.2
            cell.layer.shadowRadius = 4

            return cell
        } else if collectionView == secondCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CustomCell
            cell.data = data[indexPath.item] // İkinci collectionView için aynı veriyi kullanın
            cell.layer.shadowColor = UIColor.red.cgColor
            cell.layer.shadowOffset = CGSize(width: 1, height: 10)
            cell.layer.shadowOpacity = 0.2
            cell.layer.shadowRadius = 4
            return cell
        }
        return UICollectionViewCell()
    }
}
