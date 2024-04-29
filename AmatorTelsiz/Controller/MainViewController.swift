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

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect(x: 40, y: 170, width: UIScreen.main.bounds.width, height: 300), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    private lazy var secondCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell2")
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

        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true


        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true

        let titleLabel1 = UILabel()
        titleLabel1.text = "Deneme Sınavları"
        titleLabel1.textAlignment = .left
        titleLabel1.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel1)

        titleLabel1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350).isActive = true
        titleLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        secondCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        secondCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        secondCollectionView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        secondCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
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
            cell.contentView.layer.cornerRadius = 15
            cell.contentView.layer.masksToBounds = true
            cell.layer.shadowColor = UIColor.red.cgColor
            cell.layer.shadowOffset = CGSize(width: 1, height: 10)
            cell.layer.shadowOpacity = 0.2
            cell.layer.shadowRadius = 4
            return cell
        } else if collectionView == secondCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CustomCell
            cell.data = data[indexPath.item]
            cell.layer.shadowColor = UIColor.red.cgColor
            cell.layer.shadowOffset = CGSize(width: 1, height: 10)
            cell.layer.shadowOpacity = 0.2
            cell.layer.shadowRadius = 4
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let examVC = AB_IExamViewController()
            examVC.examTitle = data[indexPath.item].title
            navigationController?.pushViewController(examVC, animated: true)
        case 1:
            let examVC = AB_TecExamViewController()
            examVC.examTitle = data[indexPath.item].title
            navigationController?.pushViewController(examVC, animated: true)
        case 2:
            let examVC = AB_IRExamViewController()
            examVC.examTitle = data[indexPath.item].title
            navigationController?.pushViewController(examVC, animated: true)
        case 3:
            let examVC = C_IExamViewController()
            examVC.examTitle = data[indexPath.item].title
            navigationController?.pushViewController(examVC, animated: true)
        case 4:
            let examVC = C_TecExamViewController()
            examVC.examTitle = data[indexPath.item].title
            navigationController?.pushViewController(examVC, animated: true)
        case 5:
            let examVC = C_IRExamViewController()
            examVC.examTitle = data[indexPath.item].title
            navigationController?.pushViewController(examVC, animated: true)
        default:
            print("switch case error")
        }
    }
    
    @objc private func darkModeSwitchChanged(_ sender: UISwitch) {
        DarkModeManager.shared.isDarkModeEnabled = sender.isOn
    }

}
